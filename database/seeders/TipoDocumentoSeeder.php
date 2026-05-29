<?php

namespace Database\Seeders;

use App\Models\TipoDocumento;
use Illuminate\Database\Seeder;

class TipoDocumentoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        collect([
            ['nombre' => 'Ley', 'color' => '#2563eb', 'icon' => 'heroicon-o-scale'],
            ['nombre' => 'Decreto', 'color' => '#16a34a', 'icon' => 'heroicon-o-document-text'],
            ['nombre' => 'Resolucion', 'color' => '#f59e0b', 'icon' => 'heroicon-o-clipboard-document-list'],
        ])->each(fn (array $tipo): TipoDocumento => TipoDocumento::query()->firstOrCreate(
            ['nombre' => $tipo['nombre']],
            $tipo,
        ));
    }
}
