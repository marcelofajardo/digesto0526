<?php

namespace App\Services;

use App\Models\AiProvider;
use Illuminate\Support\Facades\Log;

class DocumentSummaryService
{
    public function __construct(
        private readonly DocumentTextExtractor $documentTextExtractor,
        private readonly AiProviderRepository $aiProviderRepository,
        private readonly AiProviderClient $aiProviderClient,
    ) {}

    public function generateFromFile(mixed $file): ?string
    {
        $text = $this->documentTextExtractor->extract($file);

        if (blank($text)) {
            return null;
        }

        $messages = [
            [
                'role' => 'system',
                'content' => "Eres un redactor experto. Tu tarea es escribir un resumen ejecutivo 
                          del texto provisto en un formato completamente humano, fluido y directo. 
                \n\nREGLAS CRÍTICAS DE SALIDA:\n1. El resumen debe tener una extensión obligatoria de entre 80 y 120 palabras en total.\n1. 
                El resumen debe ser obligatoriamente un SOLO PÁRRAFO continuo de texto (prosa corrida) y .\n2. 
                Está TERMINANTEMENTE PROHIBIDO usar viñetas, ítems, guiones, listas numeradas, negritas internas o saltos de línea.
                \n3. El párrafo debe empezar DIRECTAMENTE con la primera idea central o regla del documento. 
                No uses introducciones como 'El texto presenta...', 'El documento constituye...', 
                'Este texto describe...', ni 'El resumen es...'.\n4. 
                Conecta las ideas usando conectores humanos naturales 
                (por ejemplo: 'Para ello, se establece que...', 'Asimismo, es necesario...', 
                'Por otra parte, se determina que...').\n5. 
                No incluyas saludos, introducciones, ni explicaciones finales. Solo entrega el párrafo del resumen.",
            ],
            [
                'role' => 'user',
                'content' => "Texto a resumir:\n\n".$text,
            ],
        ];

        $providers = $this->aiProviderRepository->enabledInPriorityOrder();

        foreach ($providers as $provider) {
            $summary = $this->aiProviderClient->generate($provider, $messages, temperature: 0.2);

            if (filled($summary)) {
                return $summary;
            }
        }

        Log::warning('No se pudo generar la descripcion del documento con los proveedores de IA configurados.', [
            'providers' => $providers->map(fn (AiProvider $provider): array => [
                'id' => $provider->getKey(),
                'name' => $provider->name,
                'driver' => $provider->driver,
            ])->all(),
        ]);

        return null;
    }
}
