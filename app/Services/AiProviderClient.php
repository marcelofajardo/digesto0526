<?php

namespace App\Services;

use App\Models\AiProvider;
use Closure;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class AiProviderClient
{
    public function generate(
        AiProvider $provider,
        string|array $prompt,
        int $timeout = 120,
        ?Closure $onFailure = null,
        ?float $temperature = null,
    ): ?string {
        $messages = is_string($prompt)
            ? [['role' => 'user', 'content' => $prompt]]
            : $prompt;

        $response = match ($provider->driver) {
            'ollama' => $this->generateWithOllama($provider, $messages, $timeout, $onFailure, $temperature),
            'gemini' => $this->generateWithGemini($provider, $messages, $timeout, $onFailure, $temperature),
            'openai_compatible', 'deepseek', 'zai' => $this->generateWithOpenAiCompatible($provider, $messages, $timeout, $onFailure, $temperature),
            default => $this->skipUnknownProvider($provider, $onFailure),
        };

        $path = match ($provider->driver) {
            'ollama' => $this->ollamaUsesOpenAiEndpoint($provider->url)
                ? 'choices.0.message.content'
                : 'response',
            'gemini' => 'candidates.0.content.parts.0.text',
            'openai_compatible', 'deepseek', 'zai' => 'choices.0.message.content',
            default => null,
        };

        return $path === null
            ? null
            : $this->summaryFromResponse($response, $provider, $path, $onFailure);
    }

    private function generateWithOllama(
        AiProvider $provider,
        array $messages,
        int $timeout,
        ?Closure $onFailure,
        ?float $temperature,
    ): ?Response {
        $prompt = collect($messages)
            ->where('role', 'user')
            ->pluck('content')
            ->implode("\n\n");
        $systemPrompt = collect($messages)
            ->where('role', 'system')
            ->pluck('content')
            ->implode("\n\n");

        if ($this->ollamaUsesOpenAiEndpoint($provider->url)) {
            return $this->post(
                $provider,
                $this->ollamaChatCompletionsUrl($provider->url),
                array_filter([
                    'model' => $provider->model,
                    'messages' => $messages,
                    'temperature' => $temperature,
                ], fn (mixed $value): bool => $value !== null),
                timeout: $timeout,
                onFailure: $onFailure,
            );
        }

        return $this->post(
            $provider,
            $provider->url,
            array_filter([
                'model' => $provider->model,
                'prompt' => $prompt,
                'system' => filled($systemPrompt) ? $systemPrompt : null,
                'stream' => false,
                'options' => $temperature === null ? null : ['temperature' => $temperature],
            ], fn (mixed $value): bool => $value !== null),
            timeout: $timeout,
            onFailure: $onFailure,
        );
    }

    private function generateWithGemini(
        AiProvider $provider,
        array $messages,
        int $timeout,
        ?Closure $onFailure,
        ?float $temperature,
    ): ?Response {
        $key = $provider->effectiveApiKey();

        if (blank($key)) {
            Log::warning('Se omitio Gemini porque no tiene una clave API configurada.', [
                'provider_id' => $provider->getKey(),
            ]);
            $onFailure?->__invoke('No hay una clave API guardada para este proveedor.');

            return null;
        }

        $url = rtrim($provider->url, '/')
            .'/'.rawurlencode($provider->model).':generateContent';

        return $this->post(
            $provider,
            $url,
            array_filter([
                'systemInstruction' => $this->geminiSystemInstruction($messages),
                'contents' => array_values(array_map(
                    fn (array $message): array => [
                        'role' => $message['role'] === 'assistant' ? 'model' : 'user',
                        'parts' => [['text' => $message['content']]],
                    ],
                    array_filter($messages, fn (array $message): bool => $message['role'] !== 'system'),
                )),
                'generationConfig' => $temperature === null ? null : ['temperature' => $temperature],
            ], fn (mixed $value): bool => $value !== null),
            ['x-goog-api-key' => $key],
            $timeout,
            $onFailure,
        );
    }

    private function generateWithOpenAiCompatible(
        AiProvider $provider,
        array $messages,
        int $timeout,
        ?Closure $onFailure,
        ?float $temperature,
    ): ?Response {
        $key = $provider->effectiveApiKey();

        $requiresApiKey = $provider->driver === 'deepseek'
            || $provider->driver === 'zai'
            || ($provider->driver === 'openai_compatible'
                && in_array($provider->getAttribute('env_key'), ['GEMINI_API_KEY', 'OPENAI_API_KEY'], true));

        if ($requiresApiKey && blank($key)) {
            Log::warning('Se omitio un proveedor OpenAI-compatible porque no tiene una clave API configurada.', [
                'provider_id' => $provider->getKey(),
            ]);
            $onFailure?->__invoke('No hay una clave API guardada para este proveedor.');

            return null;
        }

        return $this->post(
            $provider,
            $this->openAiChatCompletionsUrl($provider->url),
            array_filter([
                'model' => $provider->model,
                'messages' => $messages,
                'temperature' => $temperature,
            ], fn (mixed $value): bool => $value !== null),
            filled($key) ? ['Authorization' => 'Bearer '.$key] : [],
            $timeout,
            $onFailure,
        );
    }

    /**
     * @param  array<int, array{role: string, content: string}>  $messages
     * @return array{parts: array<int, array{text: string}>}|null
     */
    private function geminiSystemInstruction(array $messages): ?array
    {
        $systemPrompt = collect($messages)
            ->where('role', 'system')
            ->pluck('content')
            ->implode("\n\n");

        return filled($systemPrompt) ? ['parts' => [['text' => $systemPrompt]]] : null;
    }

    /**
     * @param  array<string, mixed>  $payload
     * @param  array<string, string>  $headers
     */
    private function post(
        AiProvider $provider,
        string $url,
        array $payload,
        array $headers = [],
        int $timeout = 120,
        ?Closure $onFailure = null,
    ): ?Response {
        try {
            $response = Http::acceptJson()
                ->withHeaders($headers)
                ->connectTimeout(5)
                ->timeout($timeout)
                ->post($url, $payload);
        } catch (ConnectionException $exception) {
            $endpointAddress = $this->endpointAddress($url);

            Log::warning('No se pudo conectar con un proveedor de IA.', [
                'provider_id' => $provider->getKey(),
                'provider' => $provider->name,
                'driver' => $provider->driver,
                'endpoint_address' => $endpointAddress,
                'exception' => $exception::class,
            ]);
            $onFailure?->__invoke($endpointAddress === null
                ? 'No se pudo conectar al endpoint. Revisa la URL y que el proveedor esté disponible desde el servidor de Laravel.'
                : "No se pudo conectar a {$endpointAddress}. Ese host debe estar accesible desde el servidor de Laravel.");

            return null;
        }

        if (! $response->successful()) {
            Log::warning('Un proveedor de IA no pudo generar la descripcion del documento.', [
                'provider_id' => $provider->getKey(),
                'provider' => $provider->name,
                'driver' => $provider->driver,
                'status' => $response->status(),
            ]);
            $onFailure?->__invoke($this->failureMessageForStatus($response->status()));

            return null;
        }

        return $response;
    }

    private function summaryFromResponse(
        ?Response $response,
        AiProvider $provider,
        string $path,
        ?Closure $onFailure,
    ): ?string {
        if ($response === null) {
            return null;
        }

        $summary = data_get($response->json(), $path);

        if (! is_string($summary) || blank($summary)) {
            Log::warning('Un proveedor de IA devolvio una respuesta vacia o invalida.', [
                'provider_id' => $provider->getKey(),
                'provider' => $provider->name,
                'driver' => $provider->driver,
            ]);
            $onFailure?->__invoke('El servicio respondió, pero no devolvió texto generado. Revisa el modelo configurado.');

            return null;
        }

        $summary = preg_replace('/[ \t]+/u', ' ', trim($summary));
        $summary = is_string($summary) ? preg_replace('/ *\R */u', "\n", $summary) : null;
        $summary = is_string($summary) ? preg_replace('/\n{3,}/u', "\n\n", $summary) : null;

        if (! is_string($summary) || blank($summary)) {
            Log::warning('Un proveedor de IA devolvio una respuesta que no se pudo normalizar.', [
                'provider_id' => $provider->getKey(),
                'provider' => $provider->name,
                'driver' => $provider->driver,
            ]);
            $onFailure?->__invoke('El servicio devolvió texto que no se pudo procesar.');

            return null;
        }

        return $summary;
    }

    private function skipUnknownProvider(AiProvider $provider, ?Closure $onFailure): null
    {
        Log::warning('Se ignoro un proveedor de IA desconocido.', [
            'provider_id' => $provider->getKey(),
            'provider' => $provider->name,
            'driver' => $provider->driver,
        ]);
        $onFailure?->__invoke('El tipo de proveedor configurado no es compatible.');

        return null;
    }

    private function failureMessageForStatus(int $status): string
    {
        return match ($status) {
            400 => 'El proveedor rechazó la solicitud (HTTP 400). Revisa el modelo y el endpoint.',
            401 => 'Credencial rechazada (HTTP 401). Revisa la clave API guardada.',
            403 => 'Acceso denegado (HTTP 403). Revisa la clave y los permisos del proveedor.',
            404 => 'Endpoint o modelo no encontrado (HTTP 404). Revisa ambos valores.',
            402 => 'Saldo insuficiente o pago requerido (HTTP 402). Revisa el saldo y la facturación de la cuenta del proveedor.',
            429 => 'El proveedor informó cuota o límite de solicitudes (HTTP 429).',
            500 => 'El proveedor respondió con HTTP 500 y falló al generar. El endpoint es accesible; revisa los logs del servicio y del modelo configurado.',
            default => "El proveedor respondió con HTTP {$status}. Revisa el log para más información.",
        };
    }

    private function openAiChatCompletionsUrl(string $url): string
    {
        $url = rtrim($url, '/');
        $path = parse_url($url, PHP_URL_PATH);
        $path = is_string($path) ? rtrim($path, '/') : '';

        if (str_ends_with($path, '/chat/completions')) {
            return $url;
        }

        if (str_ends_with($path, '/v1') || str_ends_with($path, '/v1beta/openai')) {
            return $url.'/chat/completions';
        }

        return $url;
    }

    private function ollamaUsesOpenAiEndpoint(string $url): bool
    {
        $path = parse_url($url, PHP_URL_PATH);
        $path = is_string($path) ? rtrim($path, '/') : '';

        return str_ends_with($path, '/v1')
            || str_ends_with($path, '/v1/chat/completions');
    }

    private function ollamaChatCompletionsUrl(string $url): string
    {
        $url = rtrim($url, '/');

        return str_ends_with($url, '/chat/completions')
            ? $url
            : $url.'/chat/completions';
    }

    private function endpointAddress(string $url): ?string
    {
        $host = parse_url($url, PHP_URL_HOST);

        if (! is_string($host) || blank($host)) {
            return null;
        }

        $port = parse_url($url, PHP_URL_PORT);

        return $host.(is_int($port) ? ':'.$port : '');
    }
}
