<?php

namespace App\Filament\Resources\Documentos\Tables;

use App\Models\Documento;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Support\Enums\FontWeight;
use Filament\Tables\Columns\Layout\Split;
use Filament\Tables\Columns\Layout\Stack;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Storage;
use Spatie\Tags\Tag;

class DocumentosTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->searchable(['titulo', 'descripcion'])
            ->searchUsing(fn (Builder $query, string $search): Builder => $query->where(fn (Builder $q) => $q->where('titulo', 'like', "%{$search}%")->orWhere('descripcion', 'like', "%{$search}%")))
            ->columns([
                Split::make([
                    Stack::make([
                        TextColumn::make('titulo')
                            ->searchable()
                            ->sortable()
                            ->weight(FontWeight::SemiBold)
                            ->wrap(),
                        TextColumn::make('numero')
                            ->label('Año / Numero')
                            ->formatStateUsing(fn (Documento $record): string => "{$record->anio} / {$record->numero}")
                            ->sortable(['anio', 'numero'])
                            ->color('gray'),
                    ])
                        ->space(1)
                        ->columnSpan([
                            'xl' => 2,
                        ]),
                    Stack::make([
                        Split::make([
                            TextColumn::make('tipo.nombre')
                                ->label('Tipo')
                                ->sortable()
                                ->badge()
                                ->grow(false),
                            TextColumn::make('categoria.nombre')
                                ->label('Categoria')
                                ->sortable()
                                ->badge()
                                ->color('gray')
                                ->grow(false),
                            TextColumn::make('tags.name')
                                ->label('Tags')
                                ->badge()
                                ->separator(','),
                        ])->from('md'),
                        TextColumn::make('descripcion')
                            ->label('Descripcion')
                            ->limit(120)
                            ->wrap(),
                    ])->space(1),
                ])->from('lg'),
            ])
            ->defaultSort('created_at', 'desc')
            ->recordUrl(fn (Documento $record): string => Storage::disk('public')->url($record->ruta_doc))
            ->openRecordUrlInNewTab()
            ->filters([
                SelectFilter::make('anio')
                    ->label('Año')
                    ->options(fn (): array => Documento::query()
                        ->distinct()
                        ->orderByDesc('anio')
                        ->pluck('anio', 'anio')
                        ->all())
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, $anio): Builder => $query->where('anio', $anio),
                    )),
                SelectFilter::make('numero')
                    ->label('Número')
                    ->options(fn (): array => Documento::query()
                        ->distinct()
                        ->orderByDesc('numero')
                        ->pluck('numero', 'numero')
                        ->all())
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, $numero): Builder => $query->where('numero', $numero),
                    )),
                SelectFilter::make('tags')
                    ->label('Tags')
                    ->options(fn (): array => Tag::query()
                        ->where('type', 'documento')
                        ->ordered()
                        ->get()
                        ->mapWithKeys(fn (Tag $tag): array => [$tag->id => $tag->name])
                        ->all())
                    ->query(fn (Builder $query, array $data): Builder => $query->when(
                        $data['value'] ?? null,
                        fn (Builder $query, string $tagId): Builder => $query->whereHas(
                            'tags',
                            fn (Builder $query): Builder => $query->whereKey($tagId)->where('type', 'documento'),
                        ),
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
