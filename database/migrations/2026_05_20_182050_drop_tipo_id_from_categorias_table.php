<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (! Schema::hasColumn('categorias', 'tipo_id')) {
            return;
        }

        DB::table('categorias')
            ->select('nombre', DB::raw('MIN(id) as keep_id'))
            ->groupBy('nombre')
            ->havingRaw('COUNT(*) > 1')
            ->get()
            ->each(function (object $duplicate): void {
                $duplicateIds = DB::table('categorias')
                    ->where('nombre', $duplicate->nombre)
                    ->where('id', '!=', $duplicate->keep_id)
                    ->pluck('id');

                DB::table('documentos')
                    ->whereIn('categoria_id', $duplicateIds)
                    ->update(['categoria_id' => $duplicate->keep_id]);

                DB::table('categorias')
                    ->whereIn('id', $duplicateIds)
                    ->delete();
            });

        Schema::table('categorias', function (Blueprint $table) {
            $table->dropForeign(['tipo_id']);
            $table->dropIndex(['tipo_id', 'nombre']);
            $table->dropColumn('tipo_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('categorias', function (Blueprint $table) {
            $table->foreignId('tipo_id')
                ->nullable()
                ->after('id')
                ->constrained('tipo_documentos')
                ->nullOnDelete();

            $table->index(['tipo_id', 'nombre']);
        });
    }
};
