<?php

namespace Database\Seeders;

use App\Models\Categoria;
use Illuminate\Database\Seeder;

class CategoriaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        collect([
            ['nombre' => 'General', 'descripcion' => 'Categoria general para documentos.'],
            ['nombre' => 'Administrativa', 'descripcion' => 'Documentos administrativos.'],
            ['nombre' => 'Normativa', 'descripcion' => 'Documentos normativos.'],
        ])->each(fn (array $categoria): Categoria => Categoria::query()->firstOrCreate(
            ['nombre' => $categoria['nombre']],
            $categoria,
        ));
    }
}
