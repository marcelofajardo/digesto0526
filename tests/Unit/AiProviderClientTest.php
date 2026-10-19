<?php

use App\Models\AiProvider;
use App\Services\AiProviderClient;
use App\Services\AiProviderConnectionTester;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

uses(TestCase::class);

it('sends Ollama requests using the configured endpoint and model', function (): void {
    $provider = new AiProvider([
        'name' => 'Local Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:14b',
    ]);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response([
            'response' => "Resumen breve.\n\nObjetivo principal.",
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe("Resumen breve.\n\nObjetivo principal.");

    Http::assertSent(fn (Request $request): bool => $request->url() === 'http://localhost:11434/api/generate'
        && $request['model'] === 'qwen2.5-coder:14b'
        && $request['stream'] === false
        && str_contains($request['prompt'], 'Texto del documento'));
});

it('sends role-based messages and temperature to an OpenAI-compatible provider', function (): void {
    $provider = new AiProvider([
        'name' => 'Custom AI',
        'driver' => 'openai_compatible',
        'url' => 'https://ai.example.test/v1/chat/completions',
        'model' => 'custom-model',
    ]);
    $messages = [
        ['role' => 'system', 'content' => 'Reglas del resumen.'],
        ['role' => 'user', 'content' => 'Texto a resumir:\n\nContenido.'],
    ];

    Http::fake([
        'https://ai.example.test/v1/chat/completions' => Http::response([
            'choices' => [
                ['message' => ['content' => "- Primera idea.\n- Segunda idea."]],
            ],
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, $messages, temperature: 0.1))
        ->toBe("- Primera idea.\n- Segunda idea.");

    Http::assertSent(fn (Request $request): bool => $request->url() === 'https://ai.example.test/v1/chat/completions'
        && $request['messages'] === $messages
        && $request['temperature'] === 0.1);
});

it('maps system messages and temperature to Gemini request fields', function (): void {
    $provider = new AiProvider([
        'name' => 'Google Gemini',
        'driver' => 'gemini',
        'url' => 'https://generativelanguage.googleapis.com/v1beta/models',
        'model' => 'gemini-test-model',
        'api_key' => 'gemini-test-secret',
    ]);
    $messages = [
        ['role' => 'system', 'content' => 'Reglas del resumen.'],
        ['role' => 'user', 'content' => 'Texto a resumir:\n\nContenido.'],
    ];

    Http::fake([
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-test-model:generateContent' => Http::response([
            'candidates' => [
                ['content' => ['parts' => [['text' => '- Primera idea.']]]],
            ],
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, $messages, temperature: 0.1))
        ->toBe('- Primera idea.');

    Http::assertSent(fn (Request $request): bool => $request['systemInstruction']['parts'][0]['text'] === 'Reglas del resumen.'
        && $request['contents'][0]['role'] === 'user'
        && $request['contents'][0]['parts'][0]['text'] === 'Texto a resumir:\n\nContenido.'
        && $request['generationConfig']['temperature'] === 0.1);
});

it('maps system messages and temperature to native Ollama request fields', function (): void {
    $provider = new AiProvider([
        'name' => 'Local Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:14b',
    ]);
    $messages = [
        ['role' => 'system', 'content' => 'Reglas del resumen.'],
        ['role' => 'user', 'content' => 'Texto a resumir:\n\nContenido.'],
    ];

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response(['response' => '- Primera idea.']),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, $messages, temperature: 0.1))
        ->toBe('- Primera idea.');

    Http::assertSent(fn (Request $request): bool => $request['system'] === 'Reglas del resumen.'
        && $request['prompt'] === 'Texto a resumir:\n\nContenido.'
        && $request['options']['temperature'] === 0.1);
});

it('uses the OpenAI-compatible chat endpoint when Ollama is configured with a v1 base URL', function (): void {
    $provider = new AiProvider([
        'name' => 'Ollama',
        'driver' => 'ollama',
        'url' => 'http://ollama.internal:11434/v1',
        'model' => 'qwen2.5-coder:14b',
    ]);

    Http::fake([
        'http://ollama.internal:11434/v1/chat/completions' => Http::response([
            'choices' => [
                ['message' => ['content' => 'Resumen Ollama compatible.']],
            ],
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe('Resumen Ollama compatible.');

    Http::assertSent(fn (Request $request): bool => $request->url() === 'http://ollama.internal:11434/v1/chat/completions'
        && $request['model'] === 'qwen2.5-coder:14b'
        && $request['messages'][0]['content'] === 'Texto del documento');
});

it('sends Gemini requests with the encrypted provider key', function (): void {
    $provider = new AiProvider([
        'name' => 'Google Gemini',
        'driver' => 'gemini',
        'url' => 'https://generativelanguage.googleapis.com/v1beta/models',
        'model' => 'gemini-test-model',
        'api_key' => 'gemini-test-secret',
    ]);

    Http::fake([
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-test-model:generateContent' => Http::response([
            'candidates' => [
                ['content' => ['parts' => [['text' => 'Resumen de Gemini.']]]],
            ],
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe('Resumen de Gemini.');

    Http::assertSent(fn (Request $request): bool => $request->url() === 'https://generativelanguage.googleapis.com/v1beta/models/gemini-test-model:generateContent'
        && $request->header('x-goog-api-key') === ['gemini-test-secret']
        && str_contains($request['contents'][0]['parts'][0]['text'], 'Texto del documento'));
});

it('supports a custom OpenAI-compatible endpoint and optional API key', function (): void {
    $provider = new AiProvider([
        'name' => 'Custom AI',
        'driver' => 'openai_compatible',
        'url' => 'https://ai.example.test/v1/chat/completions',
        'model' => 'custom-model',
        'api_key' => 'custom-test-secret',
    ]);

    Http::fake([
        'https://ai.example.test/v1/chat/completions' => Http::response([
            'choices' => [
                ['message' => ['content' => 'Resumen personalizado.']],
            ],
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe('Resumen personalizado.');

    Http::assertSent(fn (Request $request): bool => $request->url() === 'https://ai.example.test/v1/chat/completions'
        && $request->header('Authorization') === ['Bearer custom-test-secret']
        && $request['model'] === 'custom-model'
        && $request['messages'][0]['content'] === 'Texto del documento');
});

it('uses the Z.ai OpenAI-compatible endpoint and requires its API key', function (): void {
    $provider = new AiProvider([
        'name' => 'Z.ai',
        'driver' => 'zai',
        'url' => 'https://api.z.ai/api/paas/v4/chat/completions',
        'model' => 'glm-4.5-flash',
        'api_key' => 'zai-test-secret',
    ]);

    Http::fake([
        'https://api.z.ai/api/paas/v4/chat/completions' => Http::response([
            'choices' => [
                ['message' => ['content' => 'Resumen de Z.ai.']],
            ],
        ]),
    ]);

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe('Resumen de Z.ai.');

    $request = Http::recorded()->first()[0];

    expect([
        'url' => $request->url(),
        'authorization_present' => filled($request->header('Authorization')),
        'model' => $request['model'],
        'prompt' => $request['messages'][0]['content'],
    ])->toBe([
        'url' => 'https://api.z.ai/api/paas/v4/chat/completions',
        'authorization_present' => true,
        'model' => 'glm-4.5-flash',
        'prompt' => 'Texto del documento',
    ]);
});

it('skips Z.ai when its API key has not been entered', function (): void {
    $provider = new AiProvider([
        'name' => 'Z.ai',
        'driver' => 'zai',
        'url' => 'https://api.z.ai/api/paas/v4/chat/completions',
        'model' => 'glm-4.5-flash',
    ]);

    Http::fake();

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBeNull();

    Http::assertNothingSent();
});

it('appends the chat endpoint and uses the Gemini key for its OpenAI-compatible base URL', function (): void {
    config(['services.gemini.key' => 'gemini-compatible-test-secret']);

    $provider = new AiProvider([
        'name' => 'Google Gemini',
        'driver' => 'openai_compatible',
        'url' => 'https://generativelanguage.googleapis.com/v1beta/openai',
        'model' => 'gemini-2.5-flash',
    ]);
    $provider->setAttribute('env_key', 'GEMINI_API_KEY');

    Http::fake([
        'https://generativelanguage.googleapis.com/v1beta/openai/chat/completions' => Http::response([
            'choices' => [
                ['message' => ['content' => 'Resumen compatible de Gemini.']],
            ],
        ]),
    ]);

    expect($provider->effectiveApiKey())->toBe('gemini-compatible-test-secret')
        ->and(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe('Resumen compatible de Gemini.');

    Http::assertSent(fn (Request $request): bool => $request->url() === 'https://generativelanguage.googleapis.com/v1beta/openai/chat/completions'
        && $request['model'] === 'gemini-2.5-flash'
        && $request['messages'][0]['content'] === 'Texto del documento');
});

it('uses the DeepSeek environment key with the OpenAI-compatible chat API', function (): void {
    config(['services.deepseek.key' => 'deepseek-test-secret']);

    $provider = new AiProvider([
        'name' => 'DeepSeek',
        'driver' => 'deepseek',
        'url' => 'https://api.deepseek.com/chat/completions',
        'model' => 'deepseek-chat',
    ]);

    Http::fake([
        'https://api.deepseek.com/chat/completions' => Http::response([
            'choices' => [
                ['message' => ['content' => 'Resumen de DeepSeek.']],
            ],
        ]),
    ]);

    expect($provider->effectiveApiKey())->toBe('deepseek-test-secret');

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBe('Resumen de DeepSeek.');

    $request = Http::recorded()->first()[0];

    expect([
        'url' => $request->url(),
        'authorization_present' => filled($request->header('Authorization')),
        'model' => $request['model'],
        'prompt' => $request['messages'][0]['content'],
    ])->toBe([
        'url' => 'https://api.deepseek.com/chat/completions',
        'authorization_present' => true,
        'model' => 'deepseek-chat',
        'prompt' => 'Texto del documento',
    ]);
});

it('skips DeepSeek when its environment key is not configured', function (): void {
    config(['services.deepseek.key' => null]);

    $provider = new AiProvider([
        'name' => 'DeepSeek',
        'driver' => 'deepseek',
        'url' => 'https://api.deepseek.com/chat/completions',
        'model' => 'deepseek-chat',
    ]);

    Http::fake();

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBeNull();

    Http::assertNothingSent();
});

it('skips Gemini when no API key is stored or configured', function (): void {
    config(['services.gemini.key' => null]);

    $provider = new AiProvider([
        'name' => 'Google Gemini',
        'driver' => 'gemini',
        'url' => 'https://generativelanguage.googleapis.com/v1beta/models',
        'model' => 'gemini-test-model',
    ]);
    $provider->setAttribute('env_key', 'GEMINI_API_KEY');

    Http::fake();

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBeNull();

    Http::assertNothingSent();
});

it('tests a provider connection with a short prompt', function (): void {
    $provider = new AiProvider([
        'name' => 'Local Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:14b',
    ]);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response(['response' => 'OK']),
    ]);

    $result = app(AiProviderConnectionTester::class)->test($provider);

    expect($result->successful)->toBeTrue()
        ->and($result->message)->toContain('respondió correctamente');

    Http::assertSent(fn (Request $request): bool => $request->url() === 'http://localhost:11434/api/generate'
        && str_contains($request['prompt'], 'confirmar que el servicio está disponible.'));
});

it('returns the unreachable endpoint host when connection fails', function (): void {
    $provider = new AiProvider([
        'name' => 'Local Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:14b',
    ]);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::failedConnection(),
    ]);

    $result = app(AiProviderConnectionTester::class)->test($provider);

    expect($result->successful)->toBeFalse()
        ->and($result->message)->toContain('localhost:11434')
        ->and($result->message)->toContain('debe estar accesible');
});

it('explains when the configured model or endpoint is not found', function (): void {
    $provider = new AiProvider([
        'name' => 'Google Gemini',
        'driver' => 'gemini',
        'url' => 'https://generativelanguage.googleapis.com/v1beta/models',
        'model' => 'modelo-inexistente',
        'api_key' => 'gemini-test-secret',
    ]);

    Http::fake([
        'https://generativelanguage.googleapis.com/v1beta/models/modelo-inexistente:generateContent' => Http::response([
            'error' => ['message' => 'Not found'],
        ], 404),
    ]);

    $result = app(AiProviderConnectionTester::class)->test($provider);

    expect($result->successful)->toBeFalse()
        ->and($result->message)->toContain('HTTP 404')
        ->and($result->message)->toContain('Endpoint o modelo');
});

it('explains that HTTP 500 means the provider failed while generating', function (): void {
    $provider = new AiProvider([
        'name' => 'Local Ollama',
        'driver' => 'ollama',
        'url' => 'http://localhost:11434/api/generate',
        'model' => 'qwen2.5-coder:7b',
    ]);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response([
            'error' => 'model runner failed',
        ], 500),
    ]);

    $result = app(AiProviderConnectionTester::class)->test($provider);

    expect($result->successful)->toBeFalse()
        ->and($result->message)->toContain('HTTP 500')
        ->and($result->message)->toContain('logs del servicio y del modelo');
});

it('explains provider quota errors without exposing API keys', function (): void {
    $provider = new AiProvider([
        'name' => 'OpenAI',
        'driver' => 'openai_compatible',
        'url' => 'https://api.openai.com/v1/chat/completions',
        'model' => 'gpt-4o-mini',
        'api_key' => 'openai-test-secret',
    ]);
    $provider->setAttribute('env_key', 'OPENAI_API_KEY');

    Http::fake([
        'https://api.openai.com/v1/chat/completions' => Http::response([
            'error' => ['message' => 'Quota exceeded'],
        ], 429),
    ]);

    $result = app(AiProviderConnectionTester::class)->test($provider);

    expect($result->successful)->toBeFalse()
        ->and($result->message)->toContain('HTTP 429')
        ->and($result->message)->toContain('cuota o límite')
        ->and($result->message)->not->toContain('openai-test-secret');
});

it('explains that HTTP 402 from DeepSeek means the account balance is insufficient', function (): void {
    $provider = new AiProvider([
        'name' => 'DeepSeek',
        'driver' => 'deepseek',
        'url' => 'https://api.deepseek.com/chat/completions',
        'model' => 'deepseek-chat',
        'api_key' => 'deepseek-test-secret',
    ]);

    Http::fake([
        'https://api.deepseek.com/chat/completions' => Http::response([
            'error' => ['message' => 'Insufficient Balance'],
        ], 402),
    ]);

    $result = app(AiProviderConnectionTester::class)->test($provider);

    expect($result->successful)->toBeFalse()
        ->and($result->message)->toContain('Saldo insuficiente')
        ->and($result->message)->not->toContain('deepseek-test-secret');
});

it('logs provider failures without recording API keys', function (): void {
    $provider = new AiProvider([
        'name' => 'Custom AI',
        'driver' => 'openai_compatible',
        'url' => 'https://ai.example.test/v1/chat/completions',
        'model' => 'custom-model',
        'api_key' => 'custom-test-secret',
    ]);

    Http::fake([
        'https://ai.example.test/v1/chat/completions' => Http::response(['error' => 'Unauthorized'], 401),
    ]);

    Log::spy();

    expect(app(AiProviderClient::class)->generate($provider, 'Texto del documento'))
        ->toBeNull();

    Log::shouldHaveReceived('warning')
        ->withArgs(fn (string $message, array $context): bool => str_contains($message, 'proveedor de IA')
            && ! str_contains(json_encode($context), 'custom-test-secret'));
});

it('encrypts provider API keys in the model attributes', function (): void {
    $provider = new AiProvider;
    $provider->api_key = 'provider-test-secret';

    expect($provider->getAttributes()['api_key'])
        ->not->toBe('provider-test-secret')
        ->and($provider->api_key)->toBe('provider-test-secret');
});
