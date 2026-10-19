<?php

use App\Filament\Resources\AiProviders\AiProviderResource;
use App\Filament\Resources\AiProviders\Pages\CreateAiProvider;
use App\Filament\Resources\AiProviders\Pages\EditAiProvider;
use App\Filament\Resources\AiProviders\Pages\ListAiProviders;
use App\Models\AiProvider;
use App\Models\User;
use App\Services\AiProviderRepository;
use Filament\Facades\Filament;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use Livewire\Livewire;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

use function Pest\Laravel\actingAs;

uses(RefreshDatabase::class);

beforeEach(function (): void {
    Filament::setCurrentPanel('admin');

    $permissions = collect([
        'ViewAny:AiProvider',
        'View:AiProvider',
        'Create:AiProvider',
        'Update:AiProvider',
        'Delete:AiProvider',
        'DeleteAny:AiProvider',
        'Restore:AiProvider',
        'ForceDelete:AiProvider',
        'ForceDeleteAny:AiProvider',
        'RestoreAny:AiProvider',
        'Replicate:AiProvider',
        'Reorder:AiProvider',
    ])->map(fn (string $name): Permission => Permission::findOrCreate($name, 'web'));

    $role = Role::findOrCreate('ai_provider_manager', 'web');
    $role->syncPermissions($permissions);

    $user = User::factory()->create();
    $user->assignRole($role);

    actingAs($user);
    Http::preventStrayRequests();
});

it('hides and denies the resource to roles without the view permission', function (): void {
    config(['app.env' => 'local']);

    $adminRole = Role::findOrCreate('admin', 'web');
    $admin = User::factory()->create();
    $admin->assignRole($adminRole);

    actingAs($admin);

    expect(AiProviderResource::canViewAny())->toBeFalse();

    $this->get(AiProviderResource::getUrl('index'))
        ->assertForbidden();
});

it('allows roles with the Shield view permission to access the resource', function (): void {
    config(['app.env' => 'local']);

    expect(AiProviderResource::canViewAny())->toBeTrue();

    $this->get(AiProviderResource::getUrl('index'))
        ->assertSuccessful();
});

it('provides the default providers in their configured priority order', function (): void {
    $providers = app(AiProviderRepository::class)->enabledInPriorityOrder();

    expect($providers->pluck('name')->all())->toBe([
        'Ollama',
        'Z.ai',
        'Gemini',
        'OpenAI',
        'DeepSeek',
    ]);
});

it('respects changed priorities and ignores disabled providers', function (): void {
    AiProvider::query()->where('driver', 'ollama')->update([
        'enabled' => false,
    ]);
    AiProvider::query()->where('driver', 'openai_compatible')->update([
        'priority' => 1,
    ]);

    expect(app(AiProviderRepository::class)->enabledInPriorityOrder()->pluck('name')->all())
        ->toBe([
            'OpenAI',
            'Z.ai',
            'Gemini',
            'DeepSeek',
        ]);
});

it('creates an OpenAI-compatible provider and stores its API key encrypted', function (): void {
    Livewire::test(CreateAiProvider::class)
        ->fillForm([
            'name' => 'Proveedor personalizado',
            'driver' => 'openai_compatible',
            'url' => 'https://ai.example.test/v1/chat/completions',
            'model' => 'modelo-personalizado',
            'api_key' => 'custom-provider-secret',
            'priority' => 4,
            'enabled' => true,
        ])
        ->call('create')
        ->assertHasNoFormErrors();

    $provider = AiProvider::query()->where('name', 'Proveedor personalizado')->firstOrFail();

    expect($provider->api_key)->toBe('custom-provider-secret')
        ->and($provider->getRawOriginal('api_key'))->not->toBe('custom-provider-secret')
        ->and($provider->driver)->toBe('openai_compatible');
});

it('creates a DeepSeek provider from the resource', function (): void {
    Livewire::test(CreateAiProvider::class)
        ->fillForm([
            'name' => 'DeepSeek alternativo',
            'driver' => 'deepseek',
            'url' => 'https://api.deepseek.com/chat/completions',
            'model' => 'deepseek-chat',
            'priority' => 5,
            'enabled' => true,
        ])
        ->call('create')
        ->assertHasNoFormErrors();

    expect(AiProvider::query()->where('name', 'DeepSeek alternativo')->value('driver'))
        ->toBe('deepseek');
});

it('creates a Z.ai provider with its API key stored encrypted', function (): void {
    Livewire::test(CreateAiProvider::class)
        ->fillForm([
            'name' => 'Z.ai alternativo',
            'driver' => 'zai',
            'url' => 'https://api.z.ai/api/paas/v4/chat/completions',
            'model' => 'glm-4.5-flash',
            'api_key' => 'zai-provider-secret',
            'priority' => 6,
            'enabled' => true,
        ])
        ->call('create')
        ->assertHasNoFormErrors();

    $provider = AiProvider::query()->where('name', 'Z.ai alternativo')->firstOrFail();

    expect($provider->driver)->toBe('zai')
        ->and($provider->api_key)->toBe('zai-provider-secret')
        ->and($provider->getRawOriginal('api_key'))->not->toBe('zai-provider-secret');
});

it('does not display or erase a saved API key when editing other settings', function (): void {
    $provider = AiProvider::query()->create([
        'name' => 'Proveedor seguro',
        'driver' => 'openai_compatible',
        'url' => 'https://ai.example.test/v1/chat/completions',
        'model' => 'modelo-seguro',
        'api_key' => 'existing-provider-secret',
        'priority' => 4,
        'enabled' => true,
    ]);

    Livewire::test(EditAiProvider::class, ['record' => $provider->getRouteKey()])
        ->assertFormSet(['api_key' => null])
        ->fillForm(['name' => 'Proveedor renombrado'])
        ->call('save')
        ->assertHasNoFormErrors();

    expect($provider->fresh()->name)->toBe('Proveedor renombrado')
        ->and($provider->fresh()->api_key)->toBe('existing-provider-secret');
});

it('saves a replacement API key when it is entered in the edit form', function (): void {
    $provider = AiProvider::query()->create([
        'name' => 'Proveedor con clave antigua',
        'driver' => 'openai_compatible',
        'url' => 'https://ai.example.test/v1/chat/completions',
        'model' => 'modelo-seguro',
        'api_key' => 'old-provider-secret',
        'priority' => 4,
        'enabled' => true,
    ]);

    Livewire::test(EditAiProvider::class, ['record' => $provider->getRouteKey()])
        ->fillForm(['api_key' => 'new-provider-secret'])
        ->call('save')
        ->assertHasNoFormErrors();

    expect($provider->fresh()->api_key)->toBe('new-provider-secret')
        ->and($provider->fresh()->getRawOriginal('api_key'))->not->toBe('new-provider-secret');
});

it('tests provider connectivity from the resource table', function (): void {
    $provider = AiProvider::query()->where('driver', 'ollama')->firstOrFail();

    Http::fake([
        $provider->url => Http::response(['response' => 'OK']),
    ]);

    Livewire::test(ListAiProviders::class)
        ->callTableAction('testConnection', $provider)
        ->assertNotified('Prueba de conexión exitosa');

    Http::assertSent(fn (Request $request): bool => $request->url() === $provider->url
        && str_contains($request['prompt'], 'confirmar que el servicio está disponible.'));
});

it('notifies when a provider connection test fails', function (): void {
    $provider = AiProvider::query()->where('driver', 'ollama')->firstOrFail();

    Http::fake([
        $provider->url => Http::response(['error' => 'No autorizado'], 401),
    ]);

    Livewire::test(ListAiProviders::class)
        ->callTableAction('testConnection', $provider)
        ->assertNotified('Falló la prueba de conexión');
});
