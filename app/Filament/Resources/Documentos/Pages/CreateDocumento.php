<?php

namespace App\Filament\Resources\Documentos\Pages;

use App\Filament\Resources\Documentos\Actions\DocumentSummaryUploadAction;
use App\Filament\Resources\Documentos\DocumentoResource;
use App\Services\DocumentSummaryService;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;
use Override;

class CreateDocumento extends CreateRecord
{
    protected static string $resource = DocumentoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DocumentSummaryUploadAction::make(),
        ];
    }

    /**
     * @param  array<string, mixed>  $data
     * @return array<string, mixed>
     */
    #[Override]
    protected function mutateFormDataBeforeCreate(array $data): array
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
}
