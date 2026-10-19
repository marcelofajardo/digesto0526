<?php

use App\Services\DocumentTextExtractor;
use Illuminate\Http\UploadedFile;
use PhpOffice\PhpWord\IOFactory;
use PhpOffice\PhpWord\PhpWord;
use Tests\TestCase;

uses(TestCase::class);

it('extracts text from Word DOCX documents including table cells', function (): void {
    $path = tempnam(sys_get_temp_dir(), 'document-summary-');

    if (! is_string($path)) {
        throw new RuntimeException('Could not create a temporary DOCX file.');
    }

    unlink($path);
    $path .= '.docx';

    try {
        $word = new PhpWord;
        $section = $word->addSection();
        $section->addText('Texto del párrafo.');
        $section->addTable()->addRow()->addCell()->addText('Texto de la tabla.');

        IOFactory::createWriter($word, 'Word2007')->save($path);

        $file = new UploadedFile(
            $path,
            'fuente.docx',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            test: true,
        );

        $text = app(DocumentTextExtractor::class)->extract($file);

        expect($text)
            ->toContain('Texto del párrafo.')
            ->toContain('Texto de la tabla.');
    } finally {
        if (file_exists($path)) {
            unlink($path);
        }
    }
});

it('does not extract unsupported document formats', function (): void {
    $file = UploadedFile::fake()->create('fuente.txt', 1, 'text/plain');

    expect(app(DocumentTextExtractor::class)->extract($file))->toBeNull();
});

it('returns null for an unreadable Word document', function (): void {
    $file = UploadedFile::fake()->create(
        'fuente.docx',
        1,
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    );

    expect(app(DocumentTextExtractor::class)->extract($file))->toBeNull();
});
