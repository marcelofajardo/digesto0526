<?php

namespace Database\Factories;

use App\Models\Categoria;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Categoria>
 */
class CategoriaFactory extends Factory
{
    private static int $categoriaCounter = 0;

    private static array $categoriasPredifinidas = [
        ['nombre' => 'Administración', 'color' => '#2563eb', 'descripcion' => 'Documentos relacionados con administración general.'],
        ['nombre' => 'Educación', 'color' => '#16a34a', 'descripcion' => 'Documentos sobre educación e instituciones educativas.'],
        ['nombre' => 'Salud', 'color' => '#f59e0b', 'descripcion' => 'Documentos relacionados con salud pública.'],
        ['nombre' => 'Infraestructura', 'color' => '#7c3aed', 'descripcion' => 'Documentos sobre obras e infraestructura.'],
        ['nombre' => 'Recursos Humanos', 'color' => '#db2777', 'descripcion' => 'Documentos sobre personal y recursos humanos.'],
    ];

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $categoria = self::$categoriasPredifinidas[self::$categoriaCounter % 5];
        self::$categoriaCounter++;

        return $categoria;
    }
}
