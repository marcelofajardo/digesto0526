<?php

namespace App\Services;

use App\Models\AiProvider;

class AiProviderConnectionTester
{
    public function __construct(
        private readonly AiProviderClient $client,
    ) {}

    public function test(AiProvider $provider): AiProviderConnectionResult
    {
        $failureMessage = null;
        $summary = $this->client->generate(
            $provider,
            'Responde únicamente "OK" para confirmar que el servicio está disponible.',
            timeout: 30,
            onFailure: function (string $message) use (&$failureMessage): void {
                $failureMessage = $message;
            },
        );

        if (filled($summary)) {
            return new AiProviderConnectionResult(true, 'El proveedor respondió correctamente y generó texto.');
        }

        return new AiProviderConnectionResult(
            false,
            $failureMessage ?? 'El proveedor no devolvió un resultado para la prueba.',
        );
    }
}
