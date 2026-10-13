<?php

namespace App\Filament\Resources\Documentos\Schemas;

use App\Services\GeminiService;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Notifications\Notification;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Components\Utilities\Get;
use Filament\Schemas\Components\Utilities\Set;
use Filament\Schemas\Schema;
use Illuminate\Database\Eloquent\Builder;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;
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
                            ->preserveFilenames()
                            ->maxSize(10240)
                            ->downloadable()
                            ->openable()
                            ->required()
                            ->live()
                            ->afterStateUpdated(function (Get $get, Set $set, mixed $state): void {
                                if (filled($get('descripcion'))) {
                                    return;
                                }

                                $description = self::generateDescriptionFromUploadState($state);

                                if (filled($description)) {
                                    $set('descripcion', $description);

                                    return;
                                }

                                Notification::make()
                                    ->title('No se pudo generar la descripcion')
                                    ->body('Revisa la clave de Gemini o el log de Laravel para ver el detalle.')
                                    ->warning()
                                    ->send();
                            }),
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

    /**
     * @param  array<array-key, mixed>|mixed  $state
     */
    private static function generateDescriptionFromUploadState(mixed $state): ?string
    {
        if ($state instanceof TemporaryUploadedFile) {
            return app(GeminiService::class)->generateDescriptionFromFile($state);
        }

        if (is_string($state)) {
            return app(GeminiService::class)->generateDescriptionFromPublicPath($state);
        }

        if (! is_array($state)) {
            return null;
        }

        foreach ($state as $file) {
            $description = self::generateDescriptionFromUploadState($file);

            if (filled($description)) {
                return $description;
            }
        }

        return null;
    }
}
