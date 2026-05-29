<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Spatie\Tags\Tag;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::table('documentos')
            ->whereNotNull('tags')
            ->select(['id', 'tags'])
            ->orderBy('id')
            ->get()
            ->each(function (object $documento): void {
                $tags = json_decode((string) $documento->tags, true);

                if (! is_array($tags) || $tags === []) {
                    return;
                }

                $tagIds = Tag::findOrCreate($tags, 'documento')
                    ->pluck('id')
                    ->all();

                DB::table('taggables')->insertOrIgnore(
                    collect($tagIds)
                        ->map(fn (int $tagId): array => [
                            'tag_id' => $tagId,
                            'taggable_type' => 'App\\Models\\Documento',
                            'taggable_id' => $documento->id,
                        ])
                        ->all()
                );
            });

        Schema::table('documentos', function (Blueprint $table) {
            $table->dropColumn('tags');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('documentos', function (Blueprint $table) {
            $table->json('tags')->nullable()->after('numero');
        });
    }
};
