<?php

namespace App\Services;

final readonly class AiProviderConnectionResult
{
    public function __construct(
        public bool $successful,
        public string $message,
    ) {}
}
