# Configuración de proveedores de IA desde Filament

## Objetivo

Administrar desde el panel los proveedores que generan resúmenes de documentos, incluyendo modelos, endpoints, credenciales y prioridad, y poder comprobar la conexión antes de usarlos.

## Diseño aprobado

- Crear un Resource Filament para administrar una fila por proveedor, persistida en la base de datos.
- Incluir proveedores Ollama, Gemini y OpenAI-compatible. Los dos últimos tipos usarán sus adaptadores API específicos conocidos; OpenAI-compatible permitirá configurar proveedores adicionales usando una URL completa de chat completions.
- Cada fila tendrá nombre, tipo, URL, modelo, clave API, estado habilitado y prioridad. Los tres proveedores conocidos tendrán configuración inicial compatible con los valores actuales.
- Cifrar las claves guardadas mediante el cast cifrado de Laravel. Ocultar el valor en Filament, no incluir secretos en logs y usar la clave configurada en el entorno si la fila no tiene una credencial almacenada.
- Generar resúmenes consultando proveedores habilitados por prioridad ascendente. Ante errores de conexión, HTTP, credenciales/modelo, o contenido vacío/inválido, registrar el proveedor y continuar con el siguiente.
- Incorporar una acción “Probar conexión” para validar un proveedor desde el panel sin crear ni modificar documentos.
- Si ninguno genera un resumen, conservar el comportamiento tolerante actual: permitir guardar el documento sin resumen y mostrar la advertencia existente.

## Validación

Agregar pruebas para orden y activación de proveedores, fallback entre tipos, adaptador OpenAI-compatible, cifrado y ocultamiento de claves, prueba de conexión exitosa/fallida, agotamiento de proveedores y ausencia de secretos en los logs.
