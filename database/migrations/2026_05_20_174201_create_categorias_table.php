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
        if (Schema::hasTable('categorias')) {
            Schema::table('categorias', function (Blueprint $table) {
                $table->foreign('tipo_id')->references('id')->on('tipo_documentos')->cascadeOnDelete();
                $table->index(['tipo_id', 'nombre']);
            });

            return;
        }

        Schema::create('categorias', function (Blueprint $table) {
            $table->id();
            $table->foreignId('tipo_id')->constrained('tipo_documentos')->cascadeOnDelete();
            $table->string('nombre');
            $table->text('descripcion')->nullable();
            $table->timestamps();

            $table->index(['tipo_id', 'nombre']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('categorias');
    }
};
