<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>{{ config('app.name') }} - Documentos</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    @filamentStyles
    @livewireStyles
    {!! filament()->getTheme()->getHtml() !!}
    {!! filament()->getFontPreloadHtml() !!}
    {!! filament()->getMonoFontPreloadHtml() !!}
    {!! filament()->getSerifFontPreloadHtml() !!}
    {!! filament()->getFontHtml() !!}
    {!! filament()->getMonoFontHtml() !!}
    {!! filament()->getSerifFontHtml() !!}
    <link rel="icon" type="image/png" href="{{ asset('images/Logo-a-color-chico.png') }}">
    <style>
        body { font-family: Inter, ui-sans-serif, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial; }
    </style>
    
</head>
<body class="antialiased bg-gray-50">
    <!-- Encabezado -->
    <header class="shadow-sm border-b border-gray-200" style="background-color: #E0D9CC;">
        <div class="max-w-7xl mx-auto px-4 py-4">
            <div class="flex items-center justify-between gap-4">
                <!-- Logo a la izquierda -->
                <div class="flex-shrink-0">
                    <img src="{{ asset('storage/logo.webp') }}" alt="Logo" class="h-10 w-auto object-contain">
                </div>

                <!-- Título en el centro -->
                <div class="flex-1 text-center">
                    <h1 class="text-6xl font-black" style="font-family: 'Arial Black', serif; color: #333;">Digesto Institucional - Universidad Nacional de Villa Mercedes</h1>
                </div>

                <!-- Botón de ayuda a la derecha -->
                <div class="flex-shrink-0">
                    <a href="{{ asset('storage/manual.pdf') }}" target="_blank" rel="noopener noreferrer" 
                       class="inline-flex items-center justify-center px-4 py-2 text-white font-semibold rounded-lg transition-colors duration-200 shadow-sm hover:shadow-md" 
                       style="background-color: #b5a788;" 
                       onmouseover="this.style.backgroundColor='#9d9074'" 
                       onmouseout="this.style.backgroundColor='#b5a788'"
                       title="Descargar manual de ayuda">
                        Ayuda
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Contenido principal -->
    <main class="max-w-7xl mx-auto p-4">
        @livewire(App\Filament\Widgets\PublicDocumentos::class)
    </main>

    @filamentScripts(withCore: true)
</body>
</html>
