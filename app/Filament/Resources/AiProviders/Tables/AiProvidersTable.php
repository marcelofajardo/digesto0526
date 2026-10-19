<?php

namespace App\Filament\Resources\AiProviders\Tables;

use App\Models\AiProvider;
use App\Services\AiProviderConnectionTester;
use Filament\Actions\Action;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Notifications\Notification;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class AiProvidersTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('name')
                    ->label('Proveedor')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('driver')
                    ->label('Tipo')
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'ollama' => 'Ollama',
                        'gemini' => 'Google Gemini',
                        'openai_compatible' => 'OpenAI-compatible',
                        'deepseek' => 'DeepSeek',
                        'zai' => 'Z.ai (GLM)',
                        default => $state,
                    })
                    ->badge(),
                TextColumn::make('model')
                    ->label('Modelo')
                    ->searchable(),
                TextColumn::make('priority')
                    ->label('Prioridad')
                    ->sortable(),
                TextColumn::make('credential_status')
                    ->label('Credencial')
                    ->getStateUsing(fn (AiProvider $record): string => filled($record->effectiveApiKey())
                        ? 'Configurada'
                        : 'No configurada')
                    ->badge()
                    ->color(fn (string $state): string => $state === 'Configurada' ? 'success' : 'warning'),
                IconColumn::make('enabled')
                    ->label('Habilitado')
                    ->boolean(),
            ])
            ->defaultSort('priority')
            ->filters([])
            ->recordActions([
                Action::make('testConnection')
                    ->label('Probar conexión')
                    ->icon(Heroicon::OutlinedBolt)
                    ->action(function (AiProvider $record): void {
                        $result = app(AiProviderConnectionTester::class)->test($record);

                        Notification::make()
                            ->title($result->successful
                                ? 'Prueba de conexión exitosa'
                                : 'Falló la prueba de conexión')
                            ->body($result->message)
                            ->color($result->successful ? 'success' : 'danger')
                            ->send();
                    }),
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
