<?php

namespace App\Filament\Resources\Documentos\Pages;

use App\Filament\Resources\Documentos\DocumentoResource;
use App\Services\GeminiService;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;
use Override;

class CreateDocumento extends CreateRecord
{
    protected static string $resource = DocumentoResource::class;

    /**
     * @param  array<string, mixed>  $data
     * @return array<string, mixed>
     */
    #[Override]
    protected function mutateFormDataBeforeCreate(array $data): array
    {
        if (blank($data['descripcion'] ?? null) && filled($data['ruta_doc'] ?? null)) {
            $data['descripcion'] = app(GeminiService::class)->generateDescriptionFromPublicPath((string) $data['ruta_doc']);

            if (blank($data['descripcion'] ?? null)) {
                Notification::make()
                    ->title('No se pudo generar la descripcion')
                    ->body('El documento se guardara sin resumen. Revisa el log de Laravel para ver el detalle.')
                    ->warning()
                    ->send();
            }
        }

        return $data;
    }
}
