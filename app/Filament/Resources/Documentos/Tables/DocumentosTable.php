<?php

namespace App\Filament\Resources\Documentos\Tables;

use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Grid;
use Filament\Support\Colors\Color;
use Filament\Support\Enums\FontWeight;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Storage;

class DocumentosTable
{
    public static function configure(Table $table, bool $showDescriptionTooltip = false): Table
    {
        $descriptionColumn = TextColumn::make('descripcion')
            ->label('Descripción')
            ->limit(100)
            ->wrap();

        if ($showDescriptionTooltip) {
            $descriptionColumn->tooltip(fn (?string $state): ?string => $state);
        }

        return $table
            ->extraAttributes(['class' => 'documentos-table'])
            ->modifyQueryUsing(fn (Builder $query): Builder => $query->with(['tipo', 'categoria', 'tags']))
            ->columns([
                TextColumn::make('titulo')
                    ->label('Título')
                    ->searchable()
                    ->sortable()
                    ->weight(FontWeight::SemiBold)
                    ->wrap(),
                TextColumn::make('numero')
                    ->label('Número')
                    ->searchable()
                    ->sortable()
                    ->weight(FontWeight::SemiBold)
                    ->wrap(),
                TextColumn::make('anio')
                    ->label('Año')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('tipo.nombre')
                    ->label('Tipo')
                    ->sortable('tipo.nombre')
                    ->searchable(query: fn (Builder $query, string $search): Builder => $query->whereHas('tipo', fn (Builder $query): Builder => $query->where('nombre', 'like', "%{$search}%")))
                    ->color(fn (Documento $record): array|string => $record->tipo?->color ? Color::hex($record->tipo->color) : 'gray')
                    ->badge(),

                TextColumn::make('categoria.nombre')
                    ->label('Categoría')
                    ->sortable('categoria.nombre')
                    ->searchable(query: fn (Builder $query, string $search): Builder => $query->whereHas('categoria', fn (Builder $query): Builder => $query->where('nombre', 'like', "%{$search}%")))
                    ->color(fn (Documento $record): array|string => $record->categoria?->color ? Color::hex($record->categoria->color) : 'gray')
                    ->badge(),
                $descriptionColumn,
            ])
            ->stackedOnMobile()
            ->deferFilters(false)
            ->filtersLayout(FiltersLayout::AboveContent)
            ->filtersFormColumns([
                'md' => 2,
                'lg' => 4,
            ])
            ->filtersFormSchema(fn (array $filters): array => [
                $filters['titulo'],
                Grid::make(2)
                    ->schema([
                        $filters['numero'],
                        $filters['anio'],
                    ])
                    ->columnSpan(1),
                $filters['tipo'],
                $filters['categoria'],
            ])
            ->defaultSort('created_at', 'desc')
            ->recordUrl(fn (Documento $record): string => Storage::disk('public')->url($record->ruta_doc))
            ->openRecordUrlInNewTab()
            ->filters([
                Filter::make('titulo')
                    ->label('Título')
                    ->form([
                        TextInput::make('value')
                            ->label('Buscar por título')
                            ->placeholder('Título')
                            ->live(debounce: 500),
                    ])
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        filled($data['value'] ?? null),
                        fn (Builder $query): Builder => $query->where('titulo', 'like', '%'.$data['value'].'%'),
                    )),
                Filter::make('numero')
                    ->label('Número')
                    ->form([
                        TextInput::make('value')
                            ->label('Buscar por número')
                            ->placeholder('Número')
                            ->live(debounce: 500),
                    ])
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, int|string $numero): Builder => $query->where('numero', $numero),
                    )),
                SelectFilter::make('anio')
                    ->label('Año')
                    ->options(fn (): array => Documento::query()->distinct()->orderByDesc('anio')->pluck('anio', 'anio')->all())
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, int|string $anio): Builder => $query->where('anio', $anio),
                    )),
                SelectFilter::make('tipo')
                    ->label('Tipo')
                    ->options(fn (): array => TipoDocumento::query()->orderBy('nombre')->pluck('nombre', 'id')->all())
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, int|string $tipoId): Builder => $query->where('tipo_id', $tipoId),
                    )),
                SelectFilter::make('categoria')
                    ->label('Categoría')
                    ->options(fn (): array => Categoria::query()->orderBy('nombre')->pluck('nombre', 'id')->all())
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, int|string $categoriaId): Builder => $query->where('categoria_id', $categoriaId),
                    )),
            ])
            ->recordActions([
                EditAction::make()
                    ->iconButton()
                    ->tooltip('Editar'),
                DeleteAction::make()
                    ->iconButton()
                    ->tooltip('Eliminar'),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
