<?php

namespace Database\Factories;

use App\Models\TipoDocumento;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<TipoDocumento>
 */
class TipoDocumentoFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'nombre' => fake()->unique()->words(2, true),
            'color' => fake()->hexColor(),
            'icon' => fake()->randomElement([
                'heroicon-o-document-text',
                'heroicon-o-scale',
                'heroicon-o-clipboard-document-list',
            ]),
        ];
    }
}
