<?php

use App\Filament\Resources\Documentos\Actions\DocumentSummaryUploadAction;
use App\Filament\Resources\Documentos\Pages\CreateDocumento;
use App\Filament\Resources\Documentos\Pages\EditDocumento;
use App\Services\DocumentSummaryService;
use Filament\Actions\Action;
use Filament\Forms\Components\FileUpload;
use Filament\Schemas\Schema;
use Illuminate\Http\UploadedFile;
use Livewire\Component;
use Tests\TestCase;

uses(TestCase::class);

it('fills the description from a temporary file without changing the main document path', function (): void {
    $file = UploadedFile::fake()->create(
        'fuente.docx',
        64,
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    );

    $summaryService = Mockery::mock(DocumentSummaryService::class);
    $summaryService->shouldReceive('generateFromFile')
        ->once()
        ->with($file)
        ->andReturn('Descripción generada desde el archivo alternativo.');
    $this->app->instance(DocumentSummaryService::class, $summaryService);

    $livewire = new class extends Component
    {
        public array $data = [
            'ruta_doc' => 'documentos/documento-original.pdf',
            'descripcion' => null,
        ];
    };

    $action = DocumentSummaryUploadAction::make();
    $callback = $action->getActionFunction();

    expect($callback)->toBeInstanceOf(Closure::class);
    $callback(['source_document' => $file], $livewire);

    expect($livewire->data)->toBe([
        'ruta_doc' => 'documentos/documento-original.pdf',
        'descripcion' => 'Descripción generada desde el archivo alternativo.',
    ]);
});

it('registers a temporary PDF and Word upload action on both document pages', function (): void {
    $createPage = (new ReflectionClass(CreateDocumento::class))->newInstanceWithoutConstructor();
    $editPage = (new ReflectionClass(EditDocumento::class))->newInstanceWithoutConstructor();

    $createActions = (new ReflectionMethod(CreateDocumento::class, 'getHeaderActions'))
        ->invoke($createPage);
    $editActions = (new ReflectionMethod(EditDocumento::class, 'getHeaderActions'))
        ->invoke($editPage);

    expect(array_map(fn (Action $action): string => $action->getName(), $createActions))
        ->toContain('generateDescriptionFromAlternateFile')
        ->and(array_map(fn (Action $action): string => $action->getName(), $editActions))
        ->toContain('generateDescriptionFromAlternateFile');

    $action = DocumentSummaryUploadAction::make();
    $schema = $action->getSchema(Schema::make());
    $upload = $schema?->getComponents()[0];

    expect($upload)
        ->toBeInstanceOf(FileUpload::class)
        ->and($upload->getAcceptedFileTypes())
        ->toBe([
            'application/pdf',
            'application/msword',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        ])
        ->and($upload->getMaxSize())->toBe(10240)
        ->and($upload->shouldStoreFiles())->toBeFalse()
        ->and($action->getModalCancelActionLabel())->toBe('Seguir escribiendo')
        ->and($action->getModalSubmitActionLabel())->toBe('Generar descripción');
});
