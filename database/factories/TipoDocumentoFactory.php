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
        ['nombre' => 'Decreto', 'color' => '#FF6B6B', 'descripcion' => 'Disposición dictada por una autoridad ejecutiva.'],
        ['nombre' => 'Resolución', 'color' => '#4ECDC4', 'descripcion' => 'Decisión formal emitida por una autoridad.'],
        ['nombre' => 'Memorandum', 'color' => '#45B7D1', 'descripcion' => 'Comunicación administrativa interna.'],
        ['nombre' => 'Acuerdo', 'color' => '#FFA07A', 'descripcion' => 'Decisión adoptada de común acuerdo.'],
        ['nombre' => 'Ordenanza', 'color' => '#98D8C8', 'descripcion' => 'Norma aprobada por una autoridad local.'],
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
