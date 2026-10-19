<?php

use App\Models\AiProvider;
use App\Services\AiProviderClient;
use App\Services\AiProviderRepository;
use App\Services\DocumentSummaryService;
use App\Services\DocumentTextExtractor;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

uses(TestCase::class);

it('returns null without calling providers when PDF text extraction fails', function (): void {
    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->andReturn(null);

    $repository = Mockery::mock(AiProviderRepository::class);
    $repository->shouldNotReceive('enabledInPriorityOrder');

    $client = Mockery::mock(AiProviderClient::class);
    $client->shouldNotReceive('generate');

    Http::preventStrayRequests();

    expect((new DocumentSummaryService($extractor, $repository, $client))
        ->generateFromFile('documentos/ley.pdf'))->toBeNull();
});

it('tries enabled providers in priority order until one returns a summary', function (): void {
    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->with('documentos/ley.pdf')
        ->andReturn('Texto extraido del PDF.');

    $ollama = new AiProvider([
        'name' => 'Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:14b',
        'priority' => 1,
    ]);
    $gemini = new AiProvider([
        'name' => 'Gemini',
        'driver' => 'gemini',
        'url' => 'https://generativelanguage.googleapis.com/v1beta/models',
        'model' => 'gemini-2.5-flash',
        'priority' => 2,
    ]);

    $repository = Mockery::mock(AiProviderRepository::class);
    $repository->shouldReceive('enabledInPriorityOrder')
        ->once()
        ->andReturn(new Collection([$ollama, $gemini]));

    $client = Mockery::mock(AiProviderClient::class);
    $client->shouldReceive('generate')
        ->once()
        ->withArgs(fn (AiProvider $provider, array $messages, mixed ...$options): bool => $provider === $ollama
            && $messages[0]['role'] === 'system'
            && str_contains($messages[0]['content'], 'REGLAS CRÍTICAS DE SALIDA:')
            && $messages[1]['role'] === 'user'
            && str_contains($messages[1]['content'], 'Texto extraido del PDF.')
            && in_array(0.1, $options, true))
        ->andReturn(null);
    $client->shouldReceive('generate')
        ->once()
        ->withArgs(fn (AiProvider $provider, array $messages, mixed ...$options): bool => $provider === $gemini
            && $messages[0]['role'] === 'system'
            && $messages[1]['role'] === 'user'
            && str_contains($messages[1]['content'], 'Texto extraido del PDF.')
            && in_array(0.1, $options, true))
        ->andReturn('Resumen generado por Gemini.');

    Http::preventStrayRequests();

    expect((new DocumentSummaryService($extractor, $repository, $client))
        ->generateFromFile('documentos/ley.pdf'))->toBe('Resumen generado por Gemini.');
});

it('falls back to Z.ai when Ollama does not generate a summary', function (): void {
    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->andReturn('Texto extraido del PDF.');

    $ollama = new AiProvider([
        'name' => 'Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:7b',
        'priority' => 1,
    ]);
    $zai = new AiProvider([
        'name' => 'Z.ai',
        'driver' => 'zai',
        'url' => 'https://api.z.ai/api/paas/v4/chat/completions',
        'model' => 'glm-4.5-flash',
        'priority' => 2,
    ]);

    $repository = Mockery::mock(AiProviderRepository::class);
    $repository->shouldReceive('enabledInPriorityOrder')
        ->once()
        ->andReturn(new Collection([$ollama, $zai]));

    $client = Mockery::mock(AiProviderClient::class);
    $client->shouldReceive('generate')
        ->once()
        ->with($ollama, Mockery::type('array'), 120, null, 0.1)
        ->andReturn(null);
    $client->shouldReceive('generate')
        ->once()
        ->with($zai, Mockery::type('array'), 120, null, 0.1)
        ->andReturn('Resumen generado por Z.ai.');

    Http::preventStrayRequests();

    expect((new DocumentSummaryService($extractor, $repository, $client))
        ->generateFromFile('documentos/ley.pdf'))->toBe('Resumen generado por Z.ai.');
});

it('returns null and logs the providers when all configured providers fail', function (): void {
    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->andReturn('Texto extraido del PDF.');

    $provider = new AiProvider([
        'name' => 'Proveedor personalizado',
        'driver' => 'openai_compatible',
        'url' => 'https://ai.example.test/v1/chat/completions',
        'model' => 'custom-model',
    ]);

    $repository = Mockery::mock(AiProviderRepository::class);
    $repository->shouldReceive('enabledInPriorityOrder')
        ->once()
        ->andReturn(new Collection([$provider]));

    $client = Mockery::mock(AiProviderClient::class);
    $client->shouldReceive('generate')
        ->once()
        ->with($provider, Mockery::type('array'), 120, null, 0.1)
        ->andReturn(null);

    Log::spy();
    Http::preventStrayRequests();

    expect((new DocumentSummaryService($extractor, $repository, $client))
        ->generateFromFile('documentos/ley.pdf'))->toBeNull();

    Log::shouldHaveReceived('warning')
        ->withArgs(fn (string $message, array $context): bool => str_contains($message, 'proveedores de IA configurados')
            && $context['providers'][0]['name'] === 'Proveedor personalizado');
});
