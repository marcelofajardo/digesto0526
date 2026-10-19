<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (DB::table('ai_providers')->where('driver', 'zai')->exists()) {
            return;
        }

        DB::table('ai_providers')
            ->where('priority', '>', 1)
            ->increment('priority');

        DB::table('ai_providers')->insert([
            'name' => 'Z.ai',
            'driver' => 'zai',
            'url' => 'https://api.z.ai/api/paas/v4/chat/completions',
            'model' => 'glm-4.5-flash',
            'priority' => 2,
            'enabled' => true,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::table('ai_providers')
            ->where('name', 'Z.ai')
            ->where('driver', 'zai')
            ->delete();

        DB::table('ai_providers')
            ->where('priority', '>', 2)
            ->decrement('priority');
    }
};
