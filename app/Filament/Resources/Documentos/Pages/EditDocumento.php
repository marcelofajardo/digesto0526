<?php

namespace App\Filament\Resources\Documentos\Pages;

use App\Filament\Resources\Documentos\Actions\DocumentSummaryUploadAction;
use App\Filament\Resources\Documentos\DocumentoResource;
use App\Services\DocumentSummaryService;
use Filament\Actions\DeleteAction;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\EditRecord;
use Override;

class EditDocumento extends EditRecord
{
    protected static string $resource = DocumentoResource::class;

    /**
     * @param  array<string, mixed>  $data
     * @return array<string, mixed>
     */
    #[Override]
    protected function mutateFormDataBeforeSave(array $data): array
    {
        if (filled($data['descripcion'] ?? null)) {
            return $data;
        }

        $description = app(DocumentSummaryService::class)
            ->generateFromFile($data['ruta_doc'] ?? null);

        if (blank($description)) {
            Notification::make()
                ->title('No se pudo generar la descripcion')
                ->body('El documento se guardara sin resumen. Revisa el log de Laravel para ver el detalle.')
                ->warning()
                ->send();

            return $data;
        }

        $data['descripcion'] = $description;
        $this->data['descripcion'] = $description;

        $this->halt(shouldRollbackDatabaseTransaction: true);

        return $data;
    }

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
            DocumentSummaryUploadAction::make(),
        ];
    }
}
