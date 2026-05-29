<?php

namespace App\Filament\Widgets;

use App\Filament\Resources\Documentos\Tables\DocumentosTable;
use App\Models\Documento;
use Filament\Widgets\TableWidget;
use Filament\Tables\Table;

class PublicDocumentos extends TableWidget
{
    protected static ?int $sort = 0;
    
    protected static ?string $heading = 'Documentos Públicos';

    public function table(Table $table): Table
    {
        return DocumentosTable::configure(
            $table->query(fn () => Documento::query()->with(['categoria', 'tipo', 'tags']))
        )
        ->recordActions([])
        ->headerActions([])
        ->toolbarActions([])
        ->groupedBulkActions([]);
    }
}
