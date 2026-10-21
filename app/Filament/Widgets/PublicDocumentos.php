<?php

namespace App\Filament\Widgets;

use App\Filament\Resources\Documentos\Tables\DocumentosTable;
use App\Models\Documento;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget;

class PublicDocumentos extends TableWidget
{
    protected static ?int $sort = 0;

    protected static ?string $heading = 'Documentos Públicos';

    protected int|string|array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        return DocumentosTable::configure(
            $table->query(fn () => Documento::query()->with(['categoria', 'tipo', 'tags'])),
            showDescriptionTooltip: true,
        )
            ->recordActions([])
            ->headerActions([])
            ->toolbarActions([])
            ->groupedBulkActions([]);
    }
}
