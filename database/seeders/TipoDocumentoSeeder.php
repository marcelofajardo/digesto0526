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
            ['nombre' => 'Ley', 'color' => '#2563eb', 'descripcion' => 'Norma jurídica aprobada por una autoridad legislativa.'],
            ['nombre' => 'Decreto', 'color' => '#16a34a', 'descripcion' => 'Disposición dictada por una autoridad ejecutiva.'],
            ['nombre' => 'Resolucion', 'color' => '#f59e0b', 'descripcion' => 'Decisión formal emitida por una autoridad.'],
        ])->each(fn (array $tipo): TipoDocumento => TipoDocumento::query()->firstOrCreate(
            ['nombre' => $tipo['nombre']],
            $tipo,
        ));
    }
}
