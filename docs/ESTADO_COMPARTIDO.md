# Estado compartido · nikucode

Actualización: 23 de octubre de 2026. Registro compartido para integrantes y asistentes; las sesiones de trabajo no comparten memoria automáticamente.

## Estado observado

- Revisión actual: checkout `/home/minimodecoro/Projects/nikucode-senales-2026`, rama `alex/marea-menu-integracion`, HEAD base `f31d922`. Hay cambios locales sin commit de esta iteración; se conserva aparte un cambio previo de `AGENTS.md`.
- El prototipo en `app/` conserva el apodo, avatar y preferencias de acceso en el dispositivo. La habilitación de avisos no se persiste. Mi panorama contiene conteos de interacciones de la sesión en memoria, sin historial por fecha; no mide movimiento, sedentarismo, salud ni progreso.
- La guía ofrece caminar condicionalmente o elegir un movimiento habitual propio, en tres pasos visibles, sin duración, repeticiones, metas ni temporizador obligatorio. Se puede dejar la pantalla, volver o detenerse; terminar la guía no se registra como movimiento.
- Android: el temporizador sigue solo en memoria, puede retrasarse al suspender la app y puede perderse al cerrar el proceso antes de solicitar la notificación. La implementación guarda un único ID opaco asociado a la petición de publicación para validar el toque, incluso con intent inicial; el ID se consume o invalida al abrir, cancelar, reemplazar o desactivar. No guarda el temporizador ni reactiva avisos futuros. La recepción Android no se ha probado físicamente en este checkout.
- Evidencia de esta revisión: `dart format` terminó; `flutter analyze --no-pub` pasó sin incidencias. La suite `flutter test --no-pub --concurrency=1 test/pause_view_model_test.dart test/widget_test.dart test/android_reminder_channel_test.dart` no llegó a ejecutar casos porque el runner no pudo crear `127.0.0.1:0` (`Operation not permitted`). `flutter build apk --debug --no-pub` no empezó: no se encontró Android SDK. `flutter devices` mostró solo Linux; aunque `adb` está instalado, su daemon no pudo abrir el listener local (`Operation not permitted`). No se observó app, aviso ni apertura en teléfono durante esta revisión.
- Las capturas, builds Linux/web y 20 checks headless mencionados en los registros anteriores son históricos y no validan este HEAD ni el puente Android actualizado. Véase [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).
- El repo público del equipo es https://github.com/nikucode/nikucode-senales-2026.

## Decisiones y propuestas

Confirmado: computador y celular; caso del propio equipo; un repo público para código/documentación/entrega.
Propuesto: recorrido breve, C1/C2, programación puntual sin recurrencia inicial, controles para cambiar/posponer/rechazar/detener; sin cuentas, sincronización, rachas, IA o cámara en el núcleo. La expansión comercial y los efectos del diseño visual se mantienen como hipótesis descritas en [la investigación de experiencia y acceso](INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md) y [el análisis de referentes visuales/SDD](INVESTIGACION_REFERENTES_VISUALES_Y_SDD_2026-10-23.md).

Contratos: abrir propuesta consume/invalida invitación y cancela programación propia; hora programada no es caducidad; validez por ID vigente. Un ID cancelado/reemplazado/consumido no debe abrir otra propuesta. El intent inicial Android y `onNewIntent` están implementados; pruebas Flutter del puente y de las reglas no equivalen a prueba del Activity en Android real. No garantizar entrega del SO ni impedir un banner ya presentado. No contar guía como movimiento.

## Tareas activas

| Tarea | Responsable | Estado | Cierre esperado |
|---|---|---|---|
| Repositorio y documentación inicial | Equipo | Commits `ff5ef84` y `351c267` integrados en la historia de `main` | Mantener documentación pública coherente con la implementación vigente |
| Primera implementación e iteración de interfaz | Equipo | Marea implementada; en esta revisión `flutter analyze --no-pub` pasó. La suite no ejecutó por bloqueo de socket y APK no se pudo compilar por falta de Android SDK | Ejecutar pruebas en un entorno Flutter habilitado y compilar en una máquina con SDK |
| Confirmar destinos reales | Equipo | Flutter detecta solo Linux en este entorno; el equipo informó antes haber habilitado permisos en un Android, sin probar entrega/toque. El daemon ADB no pudo arrancar aquí | Registrar el destino Android y su resultado sin generalizar a otros dispositivos |
| Prueba de canal real | Equipo, por repartir | Pendiente; esta revisión no pudo enumerar ni conectar un Android | Comprobar permiso, entrega/toque con app activa, en segundo plano, en arranque en frío, y cancelación/reemplazo |
| Checkpoint 1 · 12:00 | Equipo | Realizado; Alex informa que el checkpoint salió bien y recomienda investigar cómo acercar la propuesta a la persona | Integrar el aprendizaje sobre autocompasión sin inducir culpa ni exagerar el efecto |
| Checkpoint 2 · 17:15 | Equipo | Base implementada, comprobación en destino pendiente | Demostrar una función central en un destino real |

## Continuidad del trabajo

Lee la guía para la tarea acordada. Reparte archivos y ramas con el otro integrante. Registra tus hallazgos en tu archivo de aportes; un integrador actualiza matriz/decisiones/estado. Sincroniza y relee antes de tareas dependientes. No asumir que los archivos de otra rama ya están integrados.

Siguiente paso: ejecutar la nueva suite en un entorno donde Flutter Test pueda abrir su socket y probar APK/avisos en el teléfono Android del equipo. El harness Flutter headless, las pruebas simuladas del puente y el análisis estático no sustituyen estas comprobaciones físicas. Consulta la [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) como registro histórico y la [guía técnica](GUIA_COLABORACION_TECNICA.md).
