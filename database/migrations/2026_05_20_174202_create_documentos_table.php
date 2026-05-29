<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('documentos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('categoria_id')->constrained('categorias')->cascadeOnDelete();
            $table->foreignId('tipo_id')->constrained('tipo_documentos')->cascadeOnDelete();
            $table->string('titulo');
            $table->string('ruta_doc');
            $table->text('descripcion')->nullable();
            $table->unsignedSmallInteger('anio');
            $table->string('numero')->nullable();
            $table->json('tags')->nullable();
            $table->timestamps();

            $table->index('titulo');
            $table->index(['tipo_id', 'categoria_id']);
            $table->index(['anio', 'numero']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('documentos');
    }
};
