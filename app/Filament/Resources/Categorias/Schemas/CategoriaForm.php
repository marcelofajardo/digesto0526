<?php

namespace App\Filament\Resources\Categorias\Schemas;

use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class CategoriaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Categoria')
                    ->schema([
                        TextInput::make('nombre')
                            ->required()
                            ->maxLength(255),
                        Textarea::make('descripcion')
                            ->label('Descripcion')
                            ->maxLength(2000)
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
