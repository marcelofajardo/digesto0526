<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use PhpOffice\PhpWord\IOFactory;

class GeminiService
{
    protected string $apiKey;
    protected string $apiUrl = 'https://googleapis.com';

    public function __construct()
    {
        $this->apiKey = config('services.gemini.key');
    }

    /**
     * Extrae el texto de un archivo .docx
     */
    public function extractTextFromDocx(string $filePath): string
    {
        $phpWord = IOFactory::load($filePath);
        $text = '';
        
        foreach ($phpWord->getSections() as $section) {
            foreach ($section->getElements() as $element) {
                if (method_exists($element, 'getText')) {
                    $text .= $element->getText() . "\n";
                }
            }
        }
        
        return $text;
    }

    /**
     * Genera la descripción corta usando la API de Gemini
     */
    public function generateShortDescription(string $text): string
    {
        $prompt = "Lee el siguiente texto extraído de un documento y genera una descripción corta de máximo 3 líneas indicando el tema principal y su objetivo:\n\n" . $text;

        $response = Http::post("{$this->apiUrl}?key={$this->apiKey}", [
            'contents' => [
                [
                    'parts' => [
                        ['text' => $prompt]
                    ]
                ]
            ]
        ]);

        if ($response->successful()) {
            return $response->json('candidates.0.content.parts.0.text') ?? 'No se pudo generar el resumen.';
        }

        return 'Error al conectar con la IA: ' . $response->body();
    }
}
