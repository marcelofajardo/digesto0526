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
        Schema::table('categorias', function (Blueprint $table) {
            $table->string('color')->default('#f59e0b');
        });

        Schema::table('tipo_documentos', function (Blueprint $table) {
            $table->text('descripcion')->nullable();
            $table->dropColumn('icon');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('categorias', function (Blueprint $table) {
            $table->dropColumn('color');
        });

        Schema::table('tipo_documentos', function (Blueprint $table) {
            $table->string('icon')->default('heroicon-o-document-text');
            $table->dropColumn('descripcion');
        });
    }
};
