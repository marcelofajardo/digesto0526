<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use PhpOffice\PhpWord\Element\Text;
use PhpOffice\PhpWord\Exception\Exception as PhpWordException;
use PhpOffice\PhpWord\IOFactory;
use Spatie\PdfToText\Exceptions\BinaryNotFoundException;
use Spatie\PdfToText\Exceptions\CouldNotExtractText;
use Spatie\PdfToText\Exceptions\PdfNotFound;
use Spatie\PdfToText\Pdf;
use Symfony\Component\Process\Exception\ProcessTimedOutException;

class DocumentTextExtractor
{
    public function extract(mixed $file): ?string
    {
        [$path, $extension] = $this->filePathAndExtension($file);

        if (! is_string($path) || ! is_readable($path)) {
            Log::warning('No se pudo extraer texto del documento: el archivo no es legible.');

            return null;
        }

        if (! in_array($extension, ['pdf', 'doc', 'docx'], true)) {
            Log::warning('No se pudo extraer texto del documento: el formato no es compatible.', [
                'extension' => $extension,
            ]);

            return null;
        }

        try {
            $text = match ($extension) {
                'pdf' => Pdf::getText($path),
                'doc' => $this->extractWordText($path, 'MsDoc'),
                'docx' => $this->extractWordText($path, 'Word2007'),
            };
        } catch (BinaryNotFoundException|CouldNotExtractText|PdfNotFound|ProcessTimedOutException $exception) {
            Log::warning('No se pudo extraer texto del documento PDF.', [
                'message' => $exception->getMessage(),
            ]);

            return null;
        } catch (PhpWordException $exception) {
            Log::warning('No se pudo extraer texto del documento Word.', [
                'extension' => $extension,
                'exception' => $exception::class,
            ]);

            return null;
        }

        $text = preg_replace('/\s+/u', ' ', trim($text));

        if (! is_string($text) || blank($text)) {
            Log::warning('No se pudo extraer texto utilizable del documento.', [
                'extension' => $extension,
            ]);

            return null;
        }

        return $text;
    }

    /**
     * @return array{0: ?string, 1: string}
     */
    private function filePathAndExtension(mixed $file): array
    {
        if ($file instanceof UploadedFile) {
            return [$file->getRealPath() ?: null, strtolower($file->getClientOriginalExtension())];
        }

        if (is_string($file) && filled($file) && Storage::disk('public')->exists($file)) {
            return [
                Storage::disk('public')->path($file),
                strtolower(pathinfo($file, PATHINFO_EXTENSION)),
            ];
        }

        Log::warning('No se pudo extraer texto del documento: no se encontro el archivo.');

        return [null, ''];
    }

    private function extractWordText(string $path, string $reader): string
    {
        $document = IOFactory::load($path, $reader);
        $sections = [];

        foreach ($document->getSections() as $section) {
            $sections[] = $this->extractWordElements($section->getElements());
        }

        return implode(' ', $sections);
    }

    /**
     * @param  iterable<object>  $elements
     */
    private function extractWordElements(iterable $elements): string
    {
        $text = [];

        foreach ($elements as $element) {
            $text[] = $this->extractWordElement($element);
        }

        return implode(' ', array_filter($text, static fn (string $value): bool => filled($value)));
    }

    private function extractWordElement(object $element): string
    {
        if ($element instanceof Text) {
            return $element->getText();
        }

        if (method_exists($element, 'getElements')) {
            return $this->extractWordElements($element->getElements());
        }

        if (method_exists($element, 'getRows')) {
            return $this->extractWordElements($element->getRows());
        }

        if (method_exists($element, 'getCells')) {
            return $this->extractWordElements($element->getCells());
        }

        if (method_exists($element, 'getText')) {
            $text = $element->getText();

            return is_string($text) ? $text : '';
        }

        return '';
    }
}
