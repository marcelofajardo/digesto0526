<?php

namespace App\Filament\Resources\TipoDocumentos\Schemas;

use Filament\Forms\Components\ColorPicker;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class TipoDocumentoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Tipo de documento')
                    ->schema([
                        TextInput::make('nombre')
                            ->required()
                            ->maxLength(255),
                        ColorPicker::make('color')
                            ->required()
                            ->default('#f59e0b'),
                        TextInput::make('icon')
                            ->label('Icono')
                            ->required()
                            ->maxLength(255)
                            ->default('heroicon-o-document-text'),
                    ])
                    ->columns(2),
            ]);
    }
}
