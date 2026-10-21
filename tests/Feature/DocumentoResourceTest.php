<?php

use App\Filament\Resources\Categorias\Pages\ListCategorias;
use App\Filament\Resources\Categorias\Schemas\CategoriaForm;
use App\Filament\Resources\Categorias\Tables\CategoriasTable;
use App\Filament\Resources\Documentos\Pages\CreateDocumento;
use App\Filament\Resources\Documentos\Pages\EditDocumento;
use App\Filament\Resources\Documentos\Pages\ListDocumentos;
use App\Filament\Resources\Documentos\Tables\DocumentosTable;
use App\Filament\Resources\TipoDocumentos\Pages\ListTipoDocumentos;
use App\Filament\Resources\TipoDocumentos\Schemas\TipoDocumentoForm;
use App\Filament\Resources\TipoDocumentos\Tables\TipoDocumentosTable;
use App\Filament\Widgets\PublicDocumentos;
use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use App\Models\User;
use App\Services\DocumentSummaryService;
use App\Services\DocumentTextExtractor;
use Filament\Facades\Filament;
use Filament\Forms\Components\Field;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Concerns\InteractsWithSchemas;
use Filament\Schemas\Contracts\HasSchemas;
use Filament\Schemas\Schema;
use Filament\Support\Colors\Color;
use Filament\Support\Exceptions\Halt;
use Filament\Tables\Columns\ColorColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Client\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Schema as DatabaseSchema;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
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

it('usa el color del tipo de documento en el badge de tipo', function (): void {
    $tipo = TipoDocumento::factory()->create(['color' => '#123456']);
    $documento = Documento::factory()->create(['tipo_id' => $tipo->id]);
    $column = DocumentosTable::configure(Table::make(new ListDocumentos))
        ->getColumn('tipo.nombre')
        ->record($documento);

    expect($column->getColor($tipo->nombre))->toBe(Color::hex($tipo->color));
});

it('usa el color de la categoría en el badge de categoría', function (): void {
    $categoria = Categoria::factory()->create(['color' => '#654321']);
    $documento = Documento::factory()->create(['categoria_id' => $categoria->id]);
    $column = DocumentosTable::configure(Table::make(new ListDocumentos))
        ->getColumn('categoria.nombre')
        ->record($documento);

    expect($column->getColor($categoria->nombre))->toBe(Color::hex($categoria->color));
});

it('expone nombre, color y descripción en los formularios y listados de metadatos', function (): void {
    $livewire = new class extends Component implements HasSchemas
    {
        use InteractsWithSchemas;
    };
    $categoriaFields = collect(CategoriaForm::configure(Schema::make($livewire))->getFlatFields())
        ->keyBy(fn (Field $field): ?string => $field->getName());
    $tipoFields = collect(TipoDocumentoForm::configure(Schema::make($livewire))->getFlatFields())
        ->keyBy(fn (Field $field): ?string => $field->getName());
    $categoriasTable = CategoriasTable::configure(Table::make(new ListCategorias));
    $tiposTable = TipoDocumentosTable::configure(Table::make(new ListTipoDocumentos));

    expect($categoriaFields->keys()->all())->toContain('nombre', 'color', 'descripcion')
        ->and($tipoFields->keys()->all())->toContain('nombre', 'color', 'descripcion')
        ->and($categoriasTable->getColumn('color'))->toBeInstanceOf(ColorColumn::class)
        ->and($categoriasTable->getColumn('descripcion'))->toBeInstanceOf(TextColumn::class)
        ->and($tiposTable->getColumn('color'))->toBeInstanceOf(ColorColumn::class)
        ->and($tiposTable->getColumn('descripcion'))->toBeInstanceOf(TextColumn::class)
        ->and($tiposTable->getColumn('icon'))->toBeNull()
        ->and(DatabaseSchema::hasColumn('categorias', 'color'))->toBeTrue()
        ->and(DatabaseSchema::hasColumn('tipo_documentos', 'descripcion'))->toBeTrue()
        ->and(DatabaseSchema::hasColumn('tipo_documentos', 'icon'))->toBeFalse();
});

it('guarda color y descripción para categorías y tipos de documento', function (): void {
    $categoria = Categoria::factory()->create([
        'color' => '#123456',
        'descripcion' => 'Categoría de prueba',
    ]);
    $tipo = TipoDocumento::factory()->create([
        'color' => '#654321',
        'descripcion' => 'Tipo de prueba',
    ]);

    expect($categoria->refresh()->color)->toBe('#123456')
        ->and($categoria->descripcion)->toBe('Categoría de prueba')
        ->and($tipo->refresh()->color)->toBe('#654321')
        ->and($tipo->descripcion)->toBe('Tipo de prueba')
        ->and(Categoria::query()->create(['nombre' => 'Categoría sin color'])->color)->toBe('#f59e0b')
        ->and(TipoDocumento::query()->create(['nombre' => 'Tipo sin color'])->color)->toBe('#f59e0b');
});

it('expone los filtros de título, año, tipo y categoría en la tabla', function (): void {
    Livewire::test(ListDocumentos::class)
        ->assertTableFilterExists('titulo')
        ->assertTableFilterExists('anio')
        ->assertTableFilterExists('tipo')
        ->assertTableFilterExists('categoria');
});

it('agrupa número y año en una columna y comparte ambos filtros con la tabla pública', function (): void {
    $table = DocumentosTable::configure(Table::make(new ListDocumentos));
    $numberAndYearGrid = collect($table->getFiltersFormSchema())
        ->first(fn ($component): bool => $component instanceof Grid);
    $widget = new PublicDocumentos;
    $publicTable = $widget->table(Table::make($widget));

    expect($numberAndYearGrid)->toBeInstanceOf(Grid::class)
        ->and($numberAndYearGrid->getDefaultChildComponents())->toHaveCount(2)
        ->and($numberAndYearGrid->getAllColumns()['lg'])->toBe(2)
        ->and($numberAndYearGrid->getColumnSpan()['default'])->toBe(1)
        ->and($publicTable->getColumn('numero'))->not->toBeNull()
        ->and($publicTable->getFilter('numero'))->not->toBeNull()
        ->and($publicTable->getFilter('anio'))->not->toBeNull();
});

it('oculta la acción de resetear filtros solo en la tabla de documentos', function (): void {
    $table = DocumentosTable::configure(Table::make(new ListDocumentos));

    expect($table->getExtraAttributes()['class'])->toContain('documentos-table');
});

it('muestra la descripción completa al pasar sobre la tabla pública', function (): void {
    $widget = new PublicDocumentos;
    $table = $widget->table(Table::make($widget));
    $description = str_repeat('Descripción completa del documento. ', 8);

    expect($widget->getColumnSpan())->toBe('full')
        ->and($table->getColumn('descripcion')->getTooltip($description))->toBe($description);
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
