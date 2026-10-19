<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;

#[Fillable(['name', 'driver', 'url', 'model', 'api_key', 'priority', 'enabled'])]
class AiProvider extends Model
{
    protected function casts(): array
    {
        return [
            'api_key' => 'encrypted',
            'enabled' => 'boolean',
            'priority' => 'integer',
        ];
    }

    public function effectiveApiKey(): ?string
    {
        if (filled($this->api_key)) {
            return $this->api_key;
        }

        if ($this->driver === 'deepseek') {
            return config('services.deepseek.key');
        }

        return match ([$this->driver, $this->getAttribute('env_key')]) {
            ['gemini', 'GEMINI_API_KEY'] => config('services.gemini.key'),
            ['openai_compatible', 'GEMINI_API_KEY'] => config('services.gemini.key'),
            ['openai_compatible', 'OPENAI_API_KEY'] => config('services.openai.key'),
            default => null,
        };
    }

    public function hasStoredApiKey(): bool
    {
        return filled($this->getRawOriginal('api_key'));
    }
}
