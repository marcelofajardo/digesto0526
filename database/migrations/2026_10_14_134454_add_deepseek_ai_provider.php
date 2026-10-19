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
        if (DB::table('ai_providers')->where('driver', 'deepseek')->exists()) {
            return;
        }

        DB::table('ai_providers')->insert([
            'name' => 'DeepSeek',
            'driver' => 'deepseek',
            'url' => config('services.deepseek.url'),
            'model' => config('services.deepseek.model'),
            'env_key' => 'deepseek_api_key',
            'priority' => 4,
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
            ->where('name', 'DeepSeek')
            ->where('driver', 'deepseek')
            ->where('env_key', 'deepseek_api_key')
            ->delete();
    }
};
