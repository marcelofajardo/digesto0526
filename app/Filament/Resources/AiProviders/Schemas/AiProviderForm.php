<?php

namespace App\Filament\Resources\AiProviders\Schemas;

use App\Models\AiProvider;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class AiProviderForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Configuración del proveedor')
                    ->schema([
                        TextInput::make('name')
                            ->label('Nombre')
                            ->required()
                            ->maxLength(255),
                        Select::make('driver')
                            ->label('Tipo de API')
                            ->options([
                                'ollama' => 'Ollama',
                                'gemini' => 'Google Gemini',
                                'openai_compatible' => 'OpenAI-compatible (incluye OpenAI)',
                                'deepseek' => 'DeepSeek',
                                'zai' => 'Z.ai (GLM)',
                            ])
                            ->required()
                            ->native(false),
                        TextInput::make('url')
                            ->label('Endpoint')
                            ->url()
                            ->required()
                            ->helperText('Z.ai usa https://api.z.ai/api/paas/v4/chat/completions. Gemini: https://generativelanguage.googleapis.com/v1beta/models para su API nativa, o https://generativelanguage.googleapis.com/v1beta/openai como base OpenAI-compatible. Ollama admite /api/generate o base /v1. OpenAI-compatible acepta una base /v1 o la URL completa /chat/completions. DeepSeek usa https://api.deepseek.com/chat/completions. El host debe ser accesible desde el servidor Laravel. Guarda antes de probar.'),
                        TextInput::make('model')
                            ->label('Modelo')
                            ->required()
                            ->maxLength(255),
                        TextInput::make('api_key')
                            ->label('Clave API')
                            ->password()
                            ->autocomplete('new-password')
                            ->formatStateUsing(fn (?string $state): ?string => null)
                            ->dehydrated(fn (?string $state): bool => filled($state))
                            ->hint(fn (?AiProvider $record): string => $record?->hasStoredApiKey()
                                ? 'Ya hay una clave cifrada guardada. Deja el campo vacío para conservarla.'
                                : 'Requerida para Z.ai. Las claves guardadas se cifran; es opcional para endpoints que no requieren autenticación.'),
                        TextInput::make('priority')
                            ->label('Prioridad (menor primero)')
                            ->integer()
                            ->minValue(1)
                            ->required()
                            ->default(1),
                        Toggle::make('enabled')
                            ->label('Habilitado')
                            ->default(true)
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }
}
