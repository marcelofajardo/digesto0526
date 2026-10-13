<?php

namespace Database\Factories;

use App\Models\TipoDocumento;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<TipoDocumento>
 */
class TipoDocumentoFactory extends Factory
{
    private static int $tipoCounter = 0;

    private static array $tiposPredifinidos = [
        ['nombre' => 'Decreto', 'color' => '#FF6B6B', 'icon' => 'heroicon-o-document-text'],
        ['nombre' => 'Resolución', 'color' => '#4ECDC4', 'icon' => 'heroicon-o-scale'],
        ['nombre' => 'Memorandum', 'color' => '#45B7D1', 'icon' => 'heroicon-o-clipboard-document-list'],
        ['nombre' => 'Acuerdo', 'color' => '#FFA07A', 'icon' => 'heroicon-o-document-text'],
        ['nombre' => 'Ordenanza', 'color' => '#98D8C8', 'icon' => 'heroicon-o-scale'],
    ];

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $tipo = self::$tiposPredifinidos[self::$tipoCounter % 5];
        self::$tipoCounter++;

        return $tipo;
    }
}
