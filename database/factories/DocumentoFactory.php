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
    private static int $documentCounter = 0;

    /**
     * Configure the model factory.
     */
    public function configure(): static
    {
        return $this->afterCreating(function (Documento $documento): void {
            $documento->syncTagsWithType(
                fake()->randomElements(['decreto', 'resolución', 'memorandum'], 2),
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
        $docNumber = self::$documentCounter % 10;
        self::$documentCounter++;

        return [
            'tipo_id' => fake()->randomElement(TipoDocumento::pluck('id')->toArray()),
            'categoria_id' => fake()->randomElement(Categoria::pluck('id')->toArray()),
            'titulo' => fake()->sentence(4),
            'ruta_doc' => "documentos/doc{$docNumber}.pdf",
            'descripcion' => fake()->paragraph(),
            'anio' => fake()->numberBetween(2018, (int) date('Y')),
            'numero' => (string) fake()->numberBetween(1, 9999),
        ];
    }
}
