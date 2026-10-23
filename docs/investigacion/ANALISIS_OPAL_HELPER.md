# OpalHelper: seguimiento estático con REA/Hopper

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


Investigación previa: 22-10-2026, hora de Chile. El ejecutable no se ejecutó.
Hopper analiza bytes; puede generar pseudocódigo, no recupera código fuente original.

## Identidad
- Archivo original: seleccion_paquete/Library/LoginItems/OpalHelper.app/Contents/MacOS/OpalHelper.
- SHA-256: a5fe909639bb4fb9badb76d8bcc9c823a6c6d56e2d08cdef540d06888707c322.
- Mach-O universal; REA seleccionó x86_64 y verificó la porción temporal contra
  el original. Offset original 16384, longitud 2332016, dos arquitecturas en origen.
- Perfil de análisis nativo: b9d001d9d8b25f14a206dac8107ebf59f48e37c29616007bd66eeb6e7027459c.
- Hopper identificado por hash de launcher, no por una versión inventada en
  el registro REA. El gestor de paquetes informa hopper 6.6.0-1 en este equipo.

## Inventario completado
Evidence ID: ev_68093528c1ea185769b7ab376bc3542b04e62117a890542dc7fb0d4353baa63a.
Operación binary_overview; 9500 procedimientos, 1983 cadenas, cinco segmentos
incluyendo External Symbols. Recuentos del analizador, no funcionalidades de usuario.

## Búsqueda literal y referencias
Evidence ID: ev_438521d33472809fc80359e26ff6b071c54933c780d0d96700363abb90d198bd.
Operación trace_feature, query literal «tell application», sin distinción de mayúsculas.

| Cadena en espacio de direcciones x86_64 | Referencia observada | Procedimiento contenedor |
|---|---|---|
| 0x1001b1ec0: tell application seguido de comilla | 0x10005c921 | sub_10005c850, entrada 0x10005c850 |
| 0x1001b1f70: fragmento con tell application | 0x10005cce4 | sub_10005cbc0, entrada 0x10005cbc0 |

También se encontraron cadenas de consulta del documento de Safari en 0x1001b1f10
y de cambio de URL de pestaña de Safari en 0x1001b1ff0. La salida de esta consulta
no muestra referencias a esas dos cadenas; no interpretar eso como código muerto.

Las direcciones son del espacio analizado, no offsets directos del archivo.
sub_* son nombres generados por el analizador; no se conocen nombres originales.
Hopper no expone rangos completos de cuerpo de función por esta API. La consulta
no fue truncada, pero eso no acredita cobertura exhaustiva de referencias de la app.

## Pregunta focalizada siguiente
Se solicitó un dossier de 0x10005cbc0 para contrastar si construye AppleScript
para redirigir y si lo ejecuta directamente o lo entrega a otra rutina. No deducir
ejecución real, permisos ni frecuencia solo por la cadena o su referencia.
Salida prevista: rea-helper-redirect-function.json. Pendiente al redactar.

## Dossier del constructor de script: completado
Evidence ID: ev_c7fefd6cdeae0b9efd28720e0f256cdbaf40af62efd13df697eaca67f33daf69.
Operación analyze_function en 0x10005cbc0. Pseudocódigo, ensamblador, referencias
y bloques básicos disponibles en `rea-helper-redirect-function.json`.

Se observa comparación con `com.apple.Safari` y llamadas a primitivas Swift de
comparación/crecimiento/concatenación de cadenas. El procedimiento construye una
cadena usando fragmentos de AppleScript y entradas; hay una ruta específica de
Safari. La interpretación de construcción de una orden de redirección se apoya
en esos fragmentos y referencias, no en ejecución del navegador.

No tratar la firma `int sub_...(int, ...)` inferida por Hopper como API Swift
original ni los registros/variables temporales como nombres originales. El
pseudocódigo muestra fragmentos de cadenas largos de forma imperfecta y usa
intrinsics; no es una reconstrucción fuente lista para compilar. Los bytes y el
ensamblador conservados tienen prioridad para preguntas de detalle.

El dossier identifica un llamador en **0x10005cd20**, con referencia directa desde
**0x10005cd41** al constructor. Las llamadas reportadas por el constructor son
operaciones de cadenas; no se demuestra ejecución AppleScript en ese procedimiento.
Se solicitó el dossier del llamador para seguir la cadena, sin ejecutar Opal.
Salida: `rea-helper-redirect-caller.json`, pendiente al escribir esta actualización.

## Dossier del llamador: completado
Evidence ID: ev_174cbff60af3a9e1da90f8435c2a62cbae820f0ca37d276589da7ed6988d03c2.
Procedimiento: sub_10005cd20. El pseudocódigo y referencias muestran:
1. Llamada al constructor sub_10005cbc0.
2. Creación de un objeto NSAppleScript y envío initWithSource:.
3. Envío compileAndReturnError: y tratamiento de un error devuelto.
4. Retorno del objeto preparado si sigue la ruta correspondiente.

**Conclusión estática acotada:** hay una ruta de código para construir y compilar
un AppleScript de redirección de navegador; no son únicamente textos aislados.
La compilación no es ejecución del script. Este procedimiento no muestra una
llamada de ejecución del script; no afirmar por ello que se produjo una
redirección, se concedieron permisos o se verificó todo el bloqueo.

El dossier identifica otro llamador, sub_10005b390. No se siguió en esta pasada:
el punto de ejecución, cacheo y condiciones completas de activación siguen abiertos.
Tampoco se rastrearon las demoras de Snooze ni el pase de emergencia.

Las direcciones, pseudocódigo y referencias son de Hopper sobre x86_64. No se
validó equivalencia con arm64 ni se recuperaron tipos Swift originales.

## Resultado de esta pasada
Inventario, rastreo y dos dossiers completados, sin ejecutar Opal y sin instalar
otro motor. El timeout sigue limitado al intento del ejecutable principal.
No hace falta que el usuario vea una ventana para que REA/Hopper esté funcionando:
el adaptador Linux usa un display privado. La causa exacta del timeout del
principal todavía no está demostrada.

## Reproducción y estado
Comandos en comando-hopper-helper.json, comando-helper-trace.json y
comando-helper-redirect-function.json. Snapshot reutilizado: helper-hopper.snapshot.json.
La sesión CLI abre/cierra su imagen y documento propios. No se instaló otro motor,
no se aumentaron permisos y no se alteraron bytes originales; hashes verificados.
