<?php

use App\Filament\Resources\Documentos\Pages\CreateDocumento;
use App\Filament\Resources\Documentos\Pages\EditDocumento;
use App\Filament\Resources\Documentos\Pages\ListDocumentos;
use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Spatie\Tags\Tag;

use function Pest\Laravel\actingAs;
use function Pest\Livewire\livewire;

uses(RefreshDatabase::class);

beforeEach(function (): void {
    actingAs(User::factory()->create());
});

it('puede ver el listado de documentos en filament', function (): void {
    $documentos = Documento::factory()->count(3)->create();

    livewire(ListDocumentos::class)
        ->assertCanSeeTableRecords($documentos);
});

it('puede crear un documento', function (): void {
    Storage::fake('public');

    $tipo = TipoDocumento::factory()->create();
    $categoria = Categoria::factory()->for($tipo, 'tipo')->create();
    $ley = Tag::findOrCreate('ley', 'documento');
    $municipal = Tag::findOrCreate('municipal', 'documento');

    livewire(CreateDocumento::class)
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

it('puede editar un documento', function (): void {
    $documento = Documento::factory()->create();

    livewire(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->fillForm([
            'titulo' => 'Documento actualizado',
        ])
        ->call('save')
        ->assertHasNoFormErrors();

    expect($documento->fresh()->titulo)->toBe('Documento actualizado');
});

it('puede eliminar un documento', function (): void {
    $documento = Documento::factory()->create();

    livewire(EditDocumento::class, ['record' => $documento->getRouteKey()])
        ->callAction('delete');

    expect(Documento::query()->whereKey($documento->getKey())->exists())->toBeFalse();
});
