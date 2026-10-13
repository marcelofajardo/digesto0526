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
        ['nombre' => 'Administración', 'descripcion' => 'Documentos relacionados con administración general.'],
        ['nombre' => 'Educación', 'descripcion' => 'Documentos sobre educación e instituciones educativas.'],
        ['nombre' => 'Salud', 'descripcion' => 'Documentos relacionados con salud pública.'],
        ['nombre' => 'Infraestructura', 'descripcion' => 'Documentos sobre obras e infraestructura.'],
        ['nombre' => 'Recursos Humanos', 'descripcion' => 'Documentos sobre personal y recursos humanos.'],
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
