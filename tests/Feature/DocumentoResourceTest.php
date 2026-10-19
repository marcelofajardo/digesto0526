<?php

use App\Filament\Resources\Documentos\Pages\CreateDocumento;
use App\Filament\Resources\Documentos\Pages\EditDocumento;
use App\Filament\Resources\Documentos\Pages\ListDocumentos;
use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use App\Models\User;
use App\Services\DocumentSummaryService;
use App\Services\DocumentTextExtractor;
use Filament\Facades\Filament;
use Filament\Support\Exceptions\Halt;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Client\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Livewire\Livewire;
use Spatie\Tags\Tag;

use function Pest\Laravel\actingAs;

uses(RefreshDatabase::class);

beforeEach(function (): void {
    Filament::setCurrentPanel('admin');
    actingAs(User::factory()->create());
    Http::preventStrayRequests();
});

it('puede ver el listado de documentos en filament', function (): void {
    $documentos = Documento::factory()->count(3)->create();

    Livewire::test(ListDocumentos::class)
        ->assertCanSeeTableRecords($documentos);
});

it('puede crear un documento', function (): void {
    Storage::fake('public');
    Http::fake();

    $tipo = TipoDocumento::factory()->create();
    $categoria = Categoria::factory()->create();
    $ley = Tag::findOrCreate('ley', 'documento');
    $municipal = Tag::findOrCreate('municipal', 'documento');

    Livewire::test(CreateDocumento::class)
        ->fillForm([
            'tipo_id' => $tipo->id,
            'categoria_id' => $categoria->id,
            'titulo' => 'Documento de prueba',
            'ruta_doc' => UploadedFile::fake()->create('prueba.pdf', 64, 'application/pdf'),
            'descripcion' => 'Descripcion de prueba',
            'anio' => 2026,
            'numero' => '15',
            'tags' => [$ley->id, $municipal->id],
        ])
        ->call('create')
        ->assertHasNoFormErrors();

    $documento = Documento::query()->where('titulo', 'Documento de prueba')->first();

    expect($documento)->not->toBeNull()
        ->and($documento->hasTag('ley', 'documento'))->toBeTrue()
        ->and($documento->hasTag('municipal', 'documento'))->toBeTrue();
});

it('muestra el resumen generado y permite editarlo antes de guardar el documento', function (): void {
    Storage::fake('public');
    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->with(Mockery::on(fn (mixed $file): bool => is_string($file) && Storage::disk('public')->exists($file)))
        ->andReturn('Texto extraido del documento para resumir.');
    $this->app->instance(DocumentTextExtractor::class, $extractor);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response([
            'response' => "Resumen generado del documento.\n\nIndica su objetivo.",
        ]),
    ]);

    $tipo = TipoDocumento::factory()->create();
    $categoria = Categoria::factory()->create();

    $livewire = Livewire::test(CreateDocumento::class)
        ->fillForm([
            'tipo_id' => $tipo->id,
            'categoria_id' => $categoria->id,
            'titulo' => 'Documento con resumen',
            'ruta_doc' => UploadedFile::fake()->create('resumen.pdf', 64, 'application/pdf'),
            'anio' => 2026,
        ])
        ->call('create')
        ->assertHasNoFormErrors()
        ->assertFormSet(['descripcion' => 'Resumen generado del documento. Indica su objetivo.']);

    expect(Documento::query()->where('titulo', 'Documento con resumen')->exists())->toBeFalse();

    $livewire->fillForm(['descripcion' => 'Resumen corregido por el operador.'])
        ->call('create')
        ->assertHasNoFormErrors();

    expect(Documento::query()->where('titulo', 'Documento con resumen')->value('descripcion'))
        ->toBe('Resumen corregido por el operador.');

    Http::assertSent(fn (Request $request): bool => $request->url() === 'http://localhost:11434/api/generate'
        && $request['model'] === 'qwen2.5-coder:14b'
        && $request['stream'] === false
        && str_contains($request['prompt'], 'Texto extraido del documento para resumir.'));
});

it('loads a generated description into the create form without saving the record', function (): void {
    $summaryService = Mockery::mock(DocumentSummaryService::class);
    $summaryService->shouldReceive('generateFromFile')
        ->once()
        ->with('documentos/archivo-guardado.pdf')
        ->andReturn('Resumen generado.');
    $this->app->instance(DocumentSummaryService::class, $summaryService);

    $page = (new ReflectionClass(CreateDocumento::class))->newInstanceWithoutConstructor();
    $page->data = [
        'ruta_doc' => 'documentos/archivo-guardado.pdf',
        'descripcion' => null,
    ];
    $mutateFormData = new ReflectionMethod(CreateDocumento::class, 'mutateFormDataBeforeCreate');

    expect(fn () => $mutateFormData->invoke($page, [
        'ruta_doc' => 'documentos/archivo-guardado.pdf',
        'descripcion' => null,
    ]))->toThrow(Halt::class);

    expect($page->data['descripcion'])->toBe('Resumen generado.')
        ->and(Documento::query()->where('titulo', 'Documento con resumen')->exists())->toBeFalse();
});

it('loads a generated description into the edit form without updating the record', function (): void {
    $summaryService = Mockery::mock(DocumentSummaryService::class);
    $summaryService->shouldReceive('generateFromFile')
        ->once()
        ->with('documentos/archivo-guardado.pdf')
        ->andReturn('Resumen generado.');
    $this->app->instance(DocumentSummaryService::class, $summaryService);

    $page = (new ReflectionClass(EditDocumento::class))->newInstanceWithoutConstructor();
    $page->data = [
        'ruta_doc' => 'documentos/archivo-guardado.pdf',
        'descripcion' => null,
    ];
    $mutateFormData = new ReflectionMethod(EditDocumento::class, 'mutateFormDataBeforeSave');

    expect(fn () => $mutateFormData->invoke($page, [
        'ruta_doc' => 'documentos/archivo-guardado.pdf',
        'descripcion' => null,
    ]))->toThrow(Halt::class);

    expect($page->data['descripcion'])->toBe('Resumen generado.');
});

it('does not replace an operator-provided summary with an AI-generated description', function (): void {
    $summaryService = Mockery::mock(DocumentSummaryService::class);
    $summaryService->shouldNotReceive('generateFromFile');
    $this->app->instance(DocumentSummaryService::class, $summaryService);

    $page = (new ReflectionClass(CreateDocumento::class))->newInstanceWithoutConstructor();
    $data = [
        'ruta_doc' => 'documentos/archivo-guardado.pdf',
        'descripcion' => 'Resumen corregido por el operador.',
    ];
    $mutateFormData = new ReflectionMethod(CreateDocumento::class, 'mutateFormDataBeforeCreate');

    expect($mutateFormData->invoke($page, $data))
        ->toBe($data);
});

it('preserves the generated summary if the operator edits it before saving', function (): void {
    $summaryService = Mockery::mock(DocumentSummaryService::class);
    $summaryService->shouldNotReceive('generateFromFile');
    $this->app->instance(DocumentSummaryService::class, $summaryService);

    $page = (new ReflectionClass(EditDocumento::class))->newInstanceWithoutConstructor();
    $data = [
        'ruta_doc' => 'documentos/archivo-guardado.pdf',
        'descripcion' => 'Resumen corregido por el operador.',
    ];
    $mutateFormData = new ReflectionMethod(EditDocumento::class, 'mutateFormDataBeforeSave');

    expect($mutateFormData->invoke($page, $data))
        ->toBe($data);
});

it('respeta la descripcion manual al cargar un documento', function (): void {
    Storage::fake('public');
    Http::fake();

    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldNotReceive('extract');
    $this->app->instance(DocumentTextExtractor::class, $extractor);

    $tipo = TipoDocumento::factory()->create();
    $categoria = Categoria::factory()->create();

    Livewire::test(CreateDocumento::class)
        ->fillForm([
            'tipo_id' => $tipo->id,
            'categoria_id' => $categoria->id,
            'titulo' => 'Documento con descripcion manual',
            'descripcion' => 'Descripción escrita manualmente.',
            'ruta_doc' => UploadedFile::fake()->create('manual.pdf', 64, 'application/pdf'),
            'anio' => 2026,
        ])
        ->call('create')
        ->assertHasNoFormErrors();

    expect(Documento::query()->where('titulo', 'Documento con descripcion manual')->value('descripcion'))
        ->toBe('Descripción escrita manualmente.');

    Http::assertNothingSent();
});

it('permite guardar un documento cuando falla la generacion de la descripcion', function (): void {
    Storage::fake('public');
    config([
        'services.gemini.key' => null,
        'services.openai.key' => null,
    ]);
    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->andReturn('Texto extraido del documento para resumir.');
    $this->app->instance(DocumentTextExtractor::class, $extractor);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response(['error' => 'Servicio no disponible.'], 503),
    ]);

    $tipo = TipoDocumento::factory()->create();
    $categoria = Categoria::factory()->create();

    Livewire::test(CreateDocumento::class)
        ->fillForm([
            'tipo_id' => $tipo->id,
            'categoria_id' => $categoria->id,
            'titulo' => 'Documento sin resumen',
            'ruta_doc' => UploadedFile::fake()->create('sin-resumen.pdf', 64, 'application/pdf'),
            'anio' => 2026,
        ])
        ->call('create')
        ->assertHasNoFormErrors()
        ->assertNotified('No se pudo generar la descripcion');

    expect(Documento::query()->where('titulo', 'Documento sin resumen')->value('descripcion'))
        ->toBeNull();
});

it('genera la descripcion al reemplazar el archivo en un documento existente', function (): void {
    Storage::fake('public');
    $documento = Documento::factory()->create(['descripcion' => null]);

    $extractor = Mockery::mock(DocumentTextExtractor::class);
    $extractor->shouldReceive('extract')
        ->once()
        ->andReturn('Texto nuevo extraido del documento.');
    $this->app->instance(DocumentTextExtractor::class, $extractor);

    Http::fake([
        'http://localhost:11434/api/generate' => Http::response([
            'response' => 'Resumen nuevo del documento.',
        ]),
    ]);

    $livewire = Livewire::test(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->fillForm([
            'ruta_doc' => UploadedFile::fake()->create('actualizado.pdf', 64, 'application/pdf'),
        ])
        ->call('save')
        ->assertHasNoFormErrors()
        ->assertFormSet(['descripcion' => 'Resumen nuevo del documento.']);

    expect($documento->fresh()->descripcion)->toBeNull();

    $livewire->fillForm(['descripcion' => 'Resumen corregido en edicion.'])
        ->call('save')
        ->assertHasNoFormErrors();

    expect($documento->fresh()->descripcion)->toBe('Resumen corregido en edicion.');
});

it('puede editar un documento', function (): void {
    $documento = Documento::factory()->create();
    Http::fake();

    Livewire::test(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->fillForm([
            'titulo' => 'Documento actualizado',
        ])
        ->call('save')
        ->assertHasNoFormErrors();

    expect($documento->fresh()->titulo)->toBe('Documento actualizado');

    Http::assertNothingSent();
});

it('puede eliminar un documento', function (): void {
    $documento = Documento::factory()->create();

    Livewire::test(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->callAction('delete');

    expect(Documento::query()->whereKey($documento->getKey())->exists())->toBeFalse();
});
