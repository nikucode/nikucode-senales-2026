# Primer recorrido y defensa del checkpoint de las 12:00

23-10-2026. Implementación escrita nueva durante el evento, en `app/`. Flutter es la elección de trabajo inicial del asistente para avanzar con las herramientas disponibles; no acredita compatibilidad de todos los dispositivos del equipo. Marca de trabajo: nikucode · pausa.

## Qué se implementó

Inicio → propuesta → cambiar → guía → terminar/detener → volver; rechazo sin reprogramación. Dos propuestas: caminar si resulta adecuado y movimiento habitual elegido. Vistas adaptables a ancho disponible, controles etiquetados y sin animación o seguimiento obligatorio.

**Iteración visual Marea, 23-10-2026:** la superficie clara anterior se sustituyó por fondo azul profundo, luz ambiental tenue y una ilustración acuática central con reflejos y una esfera tipo vidrio. El motivo y el contenido cambian por etapa; la transición de 360 ms respeta movimiento reducido. Texto breve, acciones etiquetadas y botones principales sólidos mantienen legibilidad y salida clara. Se trata de una hipótesis visual, no evidencia de calma ni de mejora conductual. La base científica y sus límites están en [investigación de referentes](INVESTIGACION_REFERENTES_VISUALES_Y_SDD_2026-10-23.md).

Avisos habilitados explícitamente, programación puntual en memoria, reemplazo/cancelación y generación vigente. Adaptadores Linux y navegador separados. Al toque se solicita activar ventana/pestaña y abrir propuesta; llegada sola no toma foco. Sin servicio Android nativo implementado, persistencia, background independiente del proceso, recurrencia o sincronización.

## Evidencia observada

| Comprobación | Resultado / alcance |
|---|---|
| Dependencias | `flutter pub get --offline` pasó con caché existente, sin paquetes externos de producto añadidos |
| Análisis | `flutter analyze --no-pub` pasó sin incidencias tras correcciones |
| Linux | Build debug compiló; lanzamiento de ventana en esta sesión falla `cannot open display: :0` |
| Web | Build release compiló, con recursos web locales; aviso no fatal de fuente Cupertino ausente, sin fallo de compilación |
| Runner de tests | Bloqueado antes de suites por bind127.0.0.1 no permitido. Casos de lógica/widgets escritos, no declarados pasados |
| Motor Flutter offline | Tras la iteración Marea, harness ejecutado con VMservice deshabilitado: 20 comprobaciones, ocho capturas y cero errores Flutter, con canal fake; [resultado](evidencia/checkpoint_smoke_result.json) |
| Recompilación tras compactar la interfaz | `flutter analyze --no-pub`, Linux debug y web release compilaron. La compilación web conserva un aviso no fatal por fuente Cupertino no incluida; la app compila. |
| Vista de escritorio/móvil | Capturas Marea del motor a 1200 y 390 px inspeccionadas; no equivalen a dispositivo físico. Título, acción y opciones de propuesta caben en 390×844 al 200 %. |
| Avisos reales | No verificados: acceso a bus del escritorio bloqueado en sesión; permiso/navegador/apertura desde aviso requieren prueba del equipo |
| Movimiento/hábito | No medidos ni inferidos de la guía |

Se corrigieron dos riesgos de revisión estática: activación solicitada solo tras toque explícito y descripción de suspensión como posible retraso, sin afirmar que cancela un Timer. Ambos requieren comprobación de comportamiento en destino; compilar no demuestra que el compositor otorgue foco.

## Ver las capturas

- [Inicio en escritorio](evidencia/desktop_home.png).
- [Propuesta en escritorio](evidencia/desktop_proposal.png) y [guía](evidencia/desktop_guide.png).
- [Propuesta en tamaño móvil](evidencia/mobile_proposal.png).
- [Vista390×844 de inicio al200%](evidencia/mobile_home_200_percent.png): escala 2.0 comprobada en RenderParagraph.
- [Propuesta390×844 al200%](evidencia/mobile_proposal_200_percent.png): texto ampliado con CTA y opciones visibles.

Las capturas enlazadas son snapshots del render Flutter headless Marea, no mockups ni fotografías de un teléfono. El resultado JSON identifica canal simulado y transiciones dirigidas por el modelo. No se anuncian como pruebas de gestos, teclado, lector o avisos del sistema. El lanzamiento de la ventana Linux desde esta sesión no pudo abrirse (`cannot open display: :0`); en una terminal gráfica del equipo se puede iniciar con `cd app && flutter run -d linux`.

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

Siguiente bloque del equipo: confirmar destinos y reparto, probar activación/cancelación reales y escoger si el siguiente trabajo es canal Android o corregir fricción observada. No editar simultáneamente `main.dart`, el modelo o sus contratos sin coordinación. El [mapa documental](MAPA_DOCUMENTAL.md) reúne el respaldo; la siguiente evidencia necesaria es de funcionamiento en dispositivos reales y, posteriormente, de uso.
