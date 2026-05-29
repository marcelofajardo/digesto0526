<?php

namespace Database\Seeders;

use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use Illuminate\Database\Seeder;

class DocumentoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $ley = TipoDocumento::query()->where('nombre', 'Ley')->firstOrFail();
        $decreto = TipoDocumento::query()->where('nombre', 'Decreto')->firstOrFail();

        $categoriaNormativa = Categoria::query()->where('nombre', 'Normativa')->firstOrFail();
        $categoriaAdministrativa = Categoria::query()->where('nombre', 'Administrativa')->firstOrFail();

        $leyAcceso = Documento::query()->updateOrCreate(
            ['titulo' => 'Ley de acceso a la informacion publica'],
            [
                'tipo_id' => $ley->id,
                'categoria_id' => $categoriaNormativa->id,
                'ruta_doc' => 'documentos/ley-acceso-informacion.pdf',
                'descripcion' => 'Documento de ejemplo para normativa de acceso a informacion.',
                'anio' => 2024,
                'numero' => '101',
            ],
        );

        $leyAcceso->syncTagsWithType(['ley', 'transparencia'], 'documento');

        $decretoOrganizacion = Documento::query()->updateOrCreate(
            ['titulo' => 'Decreto de organizacion administrativa'],
            [
                'tipo_id' => $decreto->id,
                'categoria_id' => $categoriaAdministrativa->id,
                'ruta_doc' => 'documentos/decreto-organizacion-administrativa.pdf',
                'descripcion' => 'Documento de ejemplo para administracion interna.',
                'anio' => 2025,
                'numero' => '42',
            ],
        );

        $decretoOrganizacion->syncTagsWithType(['decreto', 'administracion'], 'documento');
    }
}
