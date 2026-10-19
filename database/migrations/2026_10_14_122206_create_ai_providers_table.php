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
        Schema::create('ai_providers', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('driver', 32);
            $table->text('url');
            $table->string('model');
            $table->text('api_key')->nullable();
            $table->string('env_key')->nullable();
            $table->unsignedInteger('priority')->default(1);
            $table->boolean('enabled')->default(true);
            $table->timestamps();
            $table->index(['enabled', 'priority']);
        });

        DB::table('ai_providers')->insert([
            [
                'name' => 'Ollama',
                'driver' => 'ollama',
                'url' => config('services.ollama.url'),
                'model' => config('services.ollama.model'),
                'env_key' => null,
                'priority' => 1,
                'enabled' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Gemini',
                'driver' => 'gemini',
                'url' => config('services.gemini.url'),
                'model' => config('services.gemini.model'),
                'env_key' => 'GEMINI_API_KEY',
                'priority' => 2,
                'enabled' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'OpenAI',
                'driver' => 'openai_compatible',
                'url' => config('services.openai.url'),
                'model' => config('services.openai.model'),
                'env_key' => 'OPENAI_API_KEY',
                'priority' => 3,
                'enabled' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ai_providers');
    }
};
