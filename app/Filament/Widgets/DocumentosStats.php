<?php

namespace App\Filament\Widgets;

use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class DocumentosStats extends StatsOverviewWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $categoriaPrincipal = Categoria::query()
            ->withCount('documentos')
            ->orderByDesc('documentos_count')
            ->first();

        $tipoPrincipal = TipoDocumento::query()
            ->withCount('documentos')
            ->orderByDesc('documentos_count')
            ->first();

        return [
            Stat::make('Total de documentos', Documento::query()->count())
                ->icon('heroicon-o-document-text')
                ->color('primary'),
            Stat::make('Documentos por categoria', $categoriaPrincipal?->documentos_count ?? 0)
                ->description($categoriaPrincipal?->nombre ?? 'Sin categorias')
                ->icon('heroicon-o-folder')
                ->color('info'),
            Stat::make('Documentos por tipo', $tipoPrincipal?->documentos_count ?? 0)
                ->description($tipoPrincipal?->nombre ?? 'Sin tipos')
                ->icon('heroicon-o-document-duplicate')
                ->color('success'),
        ];
    }
}
