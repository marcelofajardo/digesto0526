<?php

namespace App\Filament\Resources\Documentos\Actions;

use App\Services\DocumentSummaryService;
use Filament\Actions\Action;
use Filament\Forms\Components\FileUpload;
use Filament\Notifications\Notification;
use Livewire\Component;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;

class DocumentSummaryUploadAction
{
    public static function make(): Action
    {
        return Action::make('generateDescriptionFromAlternateFile')
            ->label('Resumir desde otro archivo')
            ->schema([
                FileUpload::make('source_document')
                    ->label('Documento para resumir')
                    ->helperText('Admite PDF, DOC y DOCX. La carga es temporal y no reemplaza el archivo principal.')
                    ->acceptedFileTypes([
                        'application/pdf',
                        'application/msword',
                        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                    ])
                    ->maxSize(10240)
                    ->storeFiles(false)
                    ->required(),
            ])
            ->modalHeading('Generar descripción desde otro documento')
            ->modalDescription('Sube un PDF, DOC o DOCX. También puedes cancelar y escribir la descripción manualmente.')
            ->modalSubmitActionLabel('Generar descripción')
            ->modalCancelActionLabel('Seguir escribiendo')
            ->action(function (array $data, Component $livewire): void {
                $sourceDocument = $data['source_document'];

                try {
                    $description = app(DocumentSummaryService::class)
                        ->generateFromFile($sourceDocument);
                } finally {
                    if ($sourceDocument instanceof TemporaryUploadedFile) {
                        $sourceDocument->delete();
                    }
                }

                if (blank($description)) {
                    Notification::make()
                        ->title('No se pudo generar la descripción')
                        ->body('Revisa el archivo o el proveedor de IA. Puedes volver a intentarlo o escribir manualmente.')
                        ->warning()
                        ->send();

                    return;
                }

                data_set($livewire, 'data.descripcion', $description);

                Notification::make()
                    ->title('Descripción generada')
                    ->success()
                    ->send();
            });
    }
}
