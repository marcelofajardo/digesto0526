# Resumen automático de documentos con Ollama

## Objetivo

Generar una descripción de un solo párrafo en español a partir del texto de los PDF cargados en el Resource de documentos de Filament y guardar el resultado en `descripcion` antes de persistir el registro.

## Diseño aprobado

- La generación se ejecutará en los hooks `beforeCreate` y `beforeSave`.
- Solo se generará un resumen si `descripcion` está vacía y se proporcionó un archivo nuevo. Una descripción escrita manualmente se conserva.
- Se extraerá texto plano de PDF mediante `Spatie\PdfToText`; el servidor debe tener instalado el ejecutable `pdftotext`.
- El texto se enviará por HTTP POST a `http://localhost:11434/api/generate` usando el modelo `qwen2.5-coder:14b`. El prompt solicitará un único párrafo breve y claro en español.
- Si el PDF no produce texto utilizable, la extracción falla o Ollama devuelve un error, se guardará el documento sin resumen y se mostrará una advertencia, manteniendo el comportamiento tolerante actual.
- Los PDF escaneados que no contengan texto seleccionable quedan fuera de alcance; no se agregará OCR.
- Se evitará la generación duplicada desde el evento de actualización del campo de archivo del formulario; la generación ocurrirá antes de guardar mediante los hooks de página.

## Validación

Las pruebas de Filament simularán la respuesta HTTP para comprobar la generación y persistencia del párrafo, que se respete una descripción manual, que la edición de otros campos no regenere el resumen y que los fallos permitan guardar sin descripción.
