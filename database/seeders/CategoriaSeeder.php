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
            ['nombre' => 'General', 'color' => '#2563eb', 'descripcion' => 'Categoria general para documentos.'],
            ['nombre' => 'Administrativa', 'color' => '#16a34a', 'descripcion' => 'Documentos administrativos.'],
            ['nombre' => 'Normativa', 'color' => '#f59e0b', 'descripcion' => 'Documentos normativos.'],
        ])->each(fn (array $categoria): Categoria => Categoria::query()->firstOrCreate(
            ['nombre' => $categoria['nombre']],
            $categoria,
        ));
    }
}
