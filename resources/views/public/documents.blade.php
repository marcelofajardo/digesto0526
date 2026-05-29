<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Documentos</title>
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
    <style>
        body { font-family: Inter, ui-sans-serif, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial; }
    </style>
    
</head>
<body class="antialiased bg-gray-50">
    <div class="max-w-7xl mx-auto p-4">
        
        @livewire(App\Filament\Widgets\PublicDocumentos::class)
    </div>

    @filamentScripts(withCore: true)
</body>
</html>
