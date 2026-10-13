<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use PhpOffice\PhpWord\IOFactory;
use Throwable;

class GeminiService
{
    protected string $apiKey;

    protected string $apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.8-flash:generateContent';

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
                    $text .= $element->getText()."\n";
                }
            }
        }

        return $text;
    }

    public function generateDescriptionFromFile(UploadedFile $file): ?string
    {
        if (blank($this->apiKey)) {
            Log::warning('No se pudo generar la descripcion del documento: falta GEMINI_API_KEY.');

            return null;
        }

        try {
            $response = Http::timeout(90)->post("{$this->apiUrl}?key={$this->apiKey}", [
                'contents' => [
                    [
                        'parts' => [
                            [
                                'text' => 'Resume el documento adjunto en un solo parrafo breve, claro y en español. Indica el tema principal y su objetivo.',
                            ],
                            [
                                'inline_data' => [
                                    'mime_type' => $file->getMimeType() ?: 'application/pdf',
                                    'data' => base64_encode((string) file_get_contents($file->getRealPath())),
                                ],
                            ],
                        ],
                    ],
                ],
            ]);
        } catch (Throwable $exception) {
            Log::warning('No se pudo conectar con Gemini para generar la descripcion del documento.', [
                'message' => $exception->getMessage(),
            ]);

            return null;
        }

        if (! $response->successful()) {
            Log::warning('Gemini no pudo generar la descripcion del documento.', [
                'status' => $response->status(),
                'body' => str($response->body())->limit(1000)->toString(),
            ]);

            return null;
        }

        $description = $response->json('candidates.0.content.parts.0.text');
        $description = filled($description)
            ? preg_replace('/\s+/u', ' ', trim((string) $description))
            : null;

        return filled($description) ? $description : null;
    }

    public function generateDescriptionFromPublicPath(?string $path): ?string
    {
        if (blank($path) || ! Storage::disk('public')->exists($path)) {
            return null;
        }

        $fullPath = Storage::disk('public')->path($path);

        return $this->generateDescriptionFromFile(
            new UploadedFile(
                path: $fullPath,
                originalName: basename($path),
                mimeType: Storage::disk('public')->mimeType($path) ?: 'application/pdf',
                test: true,
            ),
        );
    }

    /**
     * Genera la descripción corta usando la API de Gemini
     */
    public function generateShortDescription(string $text): string
    {
        $prompt = "Lee el siguiente texto extraído de un documento y genera una descripción corta de máximo 3 líneas indicando el tema principal y su objetivo:\n\n".$text;

        $response = Http::post("{$this->apiUrl}?key={$this->apiKey}", [
            'contents' => [
                [
                    'parts' => [
                        ['text' => $prompt],
                    ],
                ],
            ],
        ]);

        if ($response->successful()) {
            return $response->json('candidates.0.content.parts.0.text') ?? 'No se pudo generar el resumen.';
        }

        return 'Error al conectar con la IA: '.$response->body();
    }
}
