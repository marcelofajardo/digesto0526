<?php

namespace Database\Factories;

use App\Models\Categoria;
use App\Models\Documento;
use App\Models\TipoDocumento;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Documento>
 */
class DocumentoFactory extends Factory
{
    /**
     * Configure the model factory.
     */
    public function configure(): static
    {
        return $this->afterCreating(function (Documento $documento): void {
            $documento->syncTagsWithType(
                fake()->randomElements(['ley', 'decreto', 'resolucion', 'municipal', 'provincial'], 2),
                'documento',
            );
        });
    }

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'tipo_id' => TipoDocumento::factory(),
            'categoria_id' => Categoria::factory(),
            'titulo' => fake()->sentence(4),
            'ruta_doc' => 'documentos/'.fake()->uuid().'.pdf',
            'descripcion' => fake()->paragraph(),
            'anio' => fake()->numberBetween(2018, (int) date('Y')),
            'numero' => (string) fake()->numberBetween(1, 9999),
        ];
    }
}
