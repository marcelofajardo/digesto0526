<?php

use App\Filament\Resources\Documentos\Pages\CreateDocumento;
use App\Filament\Resources\Documentos\Pages\EditDocumento;
use App\Filament\Resources\Documentos\Pages\ListDocumentos;
use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use App\Models\User;
use Filament\Facades\Filament;
use Illuminate\Foundation\Testing\RefreshDatabase;
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
});

it('puede ver el listado de documentos en filament', function (): void {
    $documentos = Documento::factory()->count(3)->create();

    Livewire::test(ListDocumentos::class)
        ->assertCanSeeTableRecords($documentos);
});

it('puede crear un documento', function (): void {
    Storage::fake('public');
    Http::fake([
        'generativelanguage.googleapis.com/*' => Http::response([]),
    ]);

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

it('genera y graba la descripcion al cargar un documento', function (): void {
    Storage::fake('public');
    Http::fake([
        'generativelanguage.googleapis.com/*' => Http::response([
            'candidates' => [
                [
                    'content' => [
                        'parts' => [
                            [
                                'text' => "Resumen generado del documento.\n\nIndica su objetivo.",
                            ],
                        ],
                    ],
                ],
            ],
        ]),
    ]);

    $tipo = TipoDocumento::factory()->create();
    $categoria = Categoria::factory()->create();

    Livewire::test(CreateDocumento::class)
        ->fillForm([
            'tipo_id' => $tipo->id,
            'categoria_id' => $categoria->id,
            'titulo' => 'Documento con resumen',
            'ruta_doc' => UploadedFile::fake()->create('resumen.pdf', 64, 'application/pdf'),
            'anio' => 2026,
        ])
        ->call('create')
        ->assertHasNoFormErrors();

    expect(Documento::query()->where('titulo', 'Documento con resumen')->value('descripcion'))
        ->toBe('Resumen generado del documento. Indica su objetivo.');
});

it('respeta la descripcion manual al cargar un documento', function (): void {
    Storage::fake('public');
    Http::fake();

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
    Http::fake([
        'generativelanguage.googleapis.com/*' => Http::response([
            'error' => [
                'message' => 'Servicio no disponible.',
            ],
        ], 503),
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

it('puede editar un documento', function (): void {
    $documento = Documento::factory()->create();

    Livewire::test(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->fillForm([
            'titulo' => 'Documento actualizado',
        ])
        ->call('save')
        ->assertHasNoFormErrors();

    expect($documento->fresh()->titulo)->toBe('Documento actualizado');
});

it('puede eliminar un documento', function (): void {
    $documento = Documento::factory()->create();

    Livewire::test(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->callAction('delete');

    expect(Documento::query()->whereKey($documento->getKey())->exists())->toBeFalse();
});
