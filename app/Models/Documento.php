<?php

namespace App\Models;

use Database\Factories\DocumentoFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Spatie\Tags\HasTags;

#[Fillable(['categoria_id', 'tipo_id', 'titulo', 'ruta_doc', 'descripcion', 'anio', 'numero', 'tags'])]
class Documento extends Model
{
    /** @use HasFactory<DocumentoFactory> */
    use HasFactory, HasTags;

    /**
     * @return BelongsTo<Categoria, $this>
     */
    public function categoria(): BelongsTo
    {
        return $this->belongsTo(Categoria::class);
    }

    /**
     * @return BelongsTo<TipoDocumento, $this>
     */
    public function tipo(): BelongsTo
    {
        return $this->belongsTo(TipoDocumento::class, 'tipo_id');
    }
}
