<?php

namespace App\Filament\Resources\Documentos\Schemas;

use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;
use Illuminate\Database\Eloquent\Builder;
use Spatie\Tags\Tag;

class DocumentoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Documento')
                    ->schema([
                        TextInput::make('titulo')
                            ->required()
                            ->maxLength(255)
                            ->columnSpanFull(),
                        Select::make('tipo_id')
                            ->label('Tipo')
                            ->relationship('tipo', 'nombre')
                            ->searchable()
                            ->preload()
                            ->required(),
                        Select::make('categoria_id')
                            ->label('Categoria')
                            ->relationship('categoria', 'nombre')
                            ->searchable()
                            ->preload()
                            ->required(),
                        TextInput::make('anio')
                            ->label('Año')
                            ->numeric()
                            ->integer()
                            ->minValue(1900)
                            ->maxValue((int) date('Y') + 1)
                            ->required(),
                        TextInput::make('numero')
                            ->label('Numero')
                            ->maxLength(255),
                    ])
                    ->columns(2),
                Section::make('Archivo y descripcion')
                    ->schema([
                        FileUpload::make('ruta_doc')
                            ->label('Archivo')
                            ->disk('public')
                            ->directory('documentos')
                            ->acceptedFileTypes(['application/pdf'])
                            ->maxSize(10240)
                            ->downloadable()
                            ->openable()
                            ->required(),
                        Textarea::make('descripcion')
                            ->label('Descripcion')
                            ->maxLength(3000)
                            ->rows(4),
                        Select::make('tags')
                            ->label('Tags')
                            ->multiple()
                            ->relationship(
                                name: 'tags',
                                titleAttribute: 'name',
                                modifyQueryUsing: fn (Builder $query): Builder => $query->where('type', 'documento'),
                            )
                            ->getOptionLabelFromRecordUsing(fn (Tag $record): string => $record->name)
                            ->createOptionForm([
                                TextInput::make('name')
                                    ->label('Nombre')
                                    ->required()
                                    ->maxLength(255),
                            ])
                            ->createOptionUsing(fn (array $data): int => Tag::findOrCreate($data['name'], 'documento')->getKey())
                            ->searchable()
                            ->preload(),
                    ])
                    ->columns(1),
            ]);
    }
}
