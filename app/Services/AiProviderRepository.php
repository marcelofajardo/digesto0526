<?php

namespace App\Services;

use App\Models\AiProvider;
use Illuminate\Database\Eloquent\Collection;

class AiProviderRepository
{
    /**
     * @return Collection<int, AiProvider>
     */
    public function enabledInPriorityOrder(): Collection
    {
        return AiProvider::query()
            ->where('enabled', true)
            ->orderBy('priority')
            ->orderBy('id')
            ->get();
    }
}
