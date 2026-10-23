# Primer recorrido y defensa del checkpoint de las 12:00

23-10-2026. Implementación escrita nueva durante el evento, en `app/`. Flutter es la elección de trabajo inicial del asistente para avanzar con las herramientas disponibles; no acredita compatibilidad de todos los dispositivos del equipo. Marca de trabajo: nikucode · pausa.

## Qué se implementó

Inicio → propuesta → cambiar → guía → terminar/detener → volver; rechazo sin reprogramación. Dos propuestas: caminar si resulta adecuado y movimiento habitual elegido. Vistas adaptables a ancho disponible, controles etiquetados y sin animación o seguimiento obligatorio.

Avisos habilitados explícitamente, programación puntual en memoria, reemplazo/cancelación y generación vigente. Adaptadores Linux y navegador separados. Al toque se solicita activar ventana/pestaña y abrir propuesta; llegada sola no toma foco. Sin servicio Android nativo implementado, persistencia, background independiente del proceso, recurrencia o sincronización.

## Evidencia observada

| Comprobación | Resultado / alcance |
|---|---|
| Dependencias | `flutter pub get --offline` pasó con caché existente, sin paquetes externos de producto añadidos |
| Análisis | `flutter analyze --no-pub` pasó sin incidencias tras correcciones |
| Linux | Build debug compiló; lanzamiento de ventana en esta sesión falla `cannot open display: :0` |
| Web | Build release compiló, con recursos web locales; aviso no fatal de fuente Cupertino ausente, sin fallo de compilación |
| Runner de tests | Bloqueado antes de suites por bind127.0.0.1 no permitido. Casos de lógica/widgets escritos, no declarados pasados |
| Motor Flutter offline | Harness ejecutado con VMservice deshabilitado: 19 comprobaciones, siete capturas y cero errores Flutter, con canal fake; [resultado](evidencia/checkpoint_smoke_result.json) |
| Vista de escritorio/móvil | Capturas del motor a1200 y390 de ancho inspeccionadas; no equivalen a dispositivo móvil físico |
| Avisos reales | No verificados: acceso a bus del escritorio bloqueado en sesión; permiso/navegador/apertura desde aviso requieren prueba del equipo |
| Movimiento/hábito | No medidos ni inferidos de la guía |

Se corrigieron dos riesgos de revisión estática: activación solicitada solo tras toque explícito y descripción de suspensión como posible retraso, sin afirmar que cancela un Timer. Ambos requieren comprobación de comportamiento en destino; compilar no demuestra que el compositor otorgue foco.

## Ver las capturas

- [Inicio en escritorio](evidencia/desktop_home.png).
- [Propuesta en tamaño móvil](evidencia/mobile_proposal.png).
- [Vista390×844 con texto al200%](evidencia/mobile_home_200_percent.png): escala2.0 comprobada en RenderParagraph; requiere desplazamiento para llegar a acciones. No es una prueba de gesto/lector.

Son capturas reales de render headless, no mockups ni fotografías del teléfono. El resultado JSON identifica canal simulado y transiciones dirigidas por el modelo. No se anuncian como tests de gestos/lector/avisos SO.

## Reproducir la comprobación offline

El método permite ejecutar sin el socket del runner de tests:

```sh
cd app
flutter build bundle --target=tool/checkpoint_smoke.dart --target-platform=linux-x64 --asset-dir=build/checkpoint_assets --no-pub
```

Después ejecutar el `flutter_tester` del SDK local con los argumentos siguientes, sustituyendo `<SDK_FLUTTER>` por la ruta de instalación y estando dentro de `app/`:

```sh
<SDK_FLUTTER>/bin/cache/artifacts/engine/linux-x64/flutter_tester --run-forever --disable-vm-service --enable-software-rendering --icu-data-file-path=<SDK_FLUTTER>/bin/cache/artifacts/engine/linux-x64/icudtl.dat --flutter-assets-dir=build/checkpoint_assets build/checkpoint_assets/kernel_blob.bin
```

El harness guarda en `build/checkpoint_evidence/` y termina por exit explícito. Las copias en `docs/evidencia/` son un snapshot, no se actualizan solas. Para pruebas normales en un entorno sin esa restricción usar `flutter test`; no llamar a este harness sustituto completo de su suite.

## Guion de un minuto para las 12:00

> Elegimos la dificultad de iniciar pausas durante el estudio y el trabajo con dispositivos. En nuestro caso, incluso cuando notamos que necesitamos movernos seguimos con la tarea, y algunos recordatorios o registros terminan como otra obligación.
>
> Nuestra lectura es que no basta con añadir información: queremos actuar sobre la transición a una pausa viable, considerando preparación y control del momento. Es una hipótesis de diseño, no una causa ya medida.
>
> Por eso construimos este primer recorrido: propuesta concreta/modificable, posibilidad de rechazar o posponer y una guía que permite apartarse de la pantalla. Lo dejamos sin cuentas, rachas ni funciones extra para concentrarnos en ese paso.
>
> Ya compila para Linux y web y comprobamos el render/estados con un canal simulado. Nos falta probar los avisos en los dispositivos reales y evaluar si facilita iniciar la acción con poca carga. No contamos un botón o una guía terminada como movimiento.

## Antes de mostrarlo

Una persona ejecuta `flutter run -d linux` en su terminal normal y recorre abrir/cambiar/empezar/detener/rechazar. Comprobar permisos y aviso de prueba solo si el canal funciona allí. Si falla un aviso, mostrar el recorrido y declarar ese límite. El checkpoint1 evalúa problema y elección; no sustituir esa explicación por una lista de funciones.

Siguiente bloque con Javi: confirmar destinos y reparto, probar activación/cancelación reales y escoger si el siguiente trabajo es canal Android o corregir fricción observada. No editar simultáneamente `main.dart`/modelo/contratos. Respaldo científico ya disponible en el índice; la siguiente evidencia necesaria es de uso y funcionamiento.
