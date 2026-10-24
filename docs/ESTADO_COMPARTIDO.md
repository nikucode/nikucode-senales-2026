# Estado compartido · nikucode

Actualización: 23 de octubre de 2026. Registro compartido para integrantes y asistentes; las sesiones de trabajo no comparten memoria automáticamente.

## Estado observado

- Base revisada para esta entrega: checkout `/home/minimodecoro/Projects/nikucode-senales-2026`, rama `alex/marea-menu-integracion`, commit `2dd5154` (`fix: invalidate stale reminder opens and report channel failures`). El hash exacto de la entrega se obtiene con `git log -1 --oneline`. Al comenzar solo estaba modificado `AGENTS.md`; ese cambio previo se conserva fuera del commit de esta tarea. No se usa `main` como referencia de esta versión.
- El prototipo en `app/` conserva el apodo, avatar y preferencias de acceso en el dispositivo. La habilitación de avisos no se persiste. Mi panorama contiene conteos de interacciones de la sesión en memoria, sin historial por fecha; no mide movimiento, sedentarismo, salud ni progreso.
- La guía ofrece caminar condicionalmente o elegir un movimiento habitual propio, en tres pasos visibles, sin duración, repeticiones, metas ni temporizador obligatorio. Se puede dejar la pantalla, volver o detenerse; terminar la guía no se registra como movimiento.
- Android: el temporizador sigue solo en memoria, puede retrasarse al suspender la app y puede perderse al cerrar el proceso antes de solicitar la notificación. La implementación guarda un único ID opaco asociado a la petición de publicación para validar el toque, incluso con intent inicial; el ID se consume o invalida al abrir, cancelar, reemplazar o desactivar. No guarda el temporizador ni reactiva avisos futuros. La recepción Android no se ha probado físicamente en este checkout.
- Contratos ya implementados en la base: cancelar/reemplazar invalida IDs en espera; el modelo descarta un intent inicial tardío tras una elección manual. El intent inicial y `onNewIntent` usan una entrada común de IDs validados nativamente. Los fallos de lectura/validación conservan la apertura manual. La cancelación espera la respuesta del canal y, si falla, no prepara otro temporizador. Esta revisión de código no equivale a una prueba física de esos contratos.
- Cambios de esta entrega: las peticiones simultáneas de permiso comparten una única llamada nativa desde el adaptador Dart; una respuesta mal formada no concede permiso. El tema y las preferencias de acceso se aplican por encima del navegador para evitar que las hojas conserven un tema local capturado antes del cambio. Las nuevas ventanas respetan movimiento reducido y cada categoría de Mi panorama tiene un nodo semántico propio. El contenido de las guías y el alcance de datos se conservan. Una ventana abierta antes de cambiar movimiento reducido puede completar su cierre con el estilo anterior.
- Evidencia de esta revisión: formato Dart y `flutter analyze --no-pub` pasaron. La suite `flutter test --no-pub --concurrency=1 test/pause_view_model_test.dart test/widget_test.dart test/android_reminder_channel_test.dart` no ejecutó casos: el runner no pudo crear `127.0.0.1:0` (`Operation not permitted`). `flutter doctor -v` no encontró Android SDK; por esa razón no se ejecutó `flutter build apk --debug --no-pub`. `flutter devices` mostró solo Linux. No se ejecutó el harness headless, no se compiló Kotlin/Android ni se observó app, aviso o apertura en teléfono durante esta revisión.
- Las capturas, builds Linux/web y 20 checks headless mencionados en los registros anteriores son históricos y no validan este HEAD ni el puente Android actualizado. Véase [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).
- El repo público del equipo es https://github.com/nikucode/nikucode-senales-2026.

## Fundamento aplicado a esta entrega

La [auditoría científica, §1](AUDITORIA_CIENTIFICA_MVP_2026-10-23.md) y la [ficha del MVP](FICHA_MVP_PROPUESTA_2026-10-23.md) distinguen funcionamiento, carga de uso y conducta física. La [matriz, AUD23-04 y VIS-01](MATRIZ_EVIDENCIA_Y_VALIDACION.md) recoge aceptabilidad como marco y resultados mixtos de estética/desempeño: no demuestra una interfaz óptima ni eficacia de Marea. La [investigación de diseño](INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md) orienta consistencia, legibilidad y control; aplicar las preferencias a las ventanas existentes es una decisión técnica ligada a AC10 de la guía, no un resultado científico propio.

La [investigación sobre autocompasión](INVESTIGACION_AUTOCOMPASION_Y_ACERCAMIENTO.md) mantiene el tono respetuoso como hipótesis y descarta un formulario obligatorio sobre dolor para este prototipo. El [archivo de carga digital](investigacion/INVESTIGACION_CARGA_DIGITAL_Y_PAUSAS.md) conserva resultados nulos sobre mensajes y la cuarentena de cifras auditadas; no justifica añadir más avisos, tareas o contenido. Por eso esta entrega corrige el recorrido existente y no incorpora una rutina, recompensas ni nuevas funciones. Lo observado aquí se limita al análisis y a los bloqueos de verificación descritos arriba.

## Decisiones y propuestas

Confirmado: computador y celular; caso del propio equipo; un repo público para código/documentación/entrega.
Propuesto: recorrido breve, C1/C2, programación puntual sin recurrencia inicial, controles para cambiar/posponer/rechazar/detener; sin cuentas, sincronización, rachas, IA o cámara en el núcleo. La expansión comercial y los efectos del diseño visual se mantienen como hipótesis descritas en [la investigación de experiencia y acceso](INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md) y [el análisis de referentes visuales/SDD](INVESTIGACION_REFERENTES_VISUALES_Y_SDD_2026-10-23.md).

Contratos: abrir propuesta consume/invalida invitación y cancela programación propia; hora programada no es caducidad; validez por ID vigente. Un ID cancelado/reemplazado/consumido no debe abrir otra propuesta. El intent inicial Android y `onNewIntent` están implementados; pruebas Flutter del puente y de las reglas no equivalen a prueba del Activity en Android real. No garantizar entrega del SO ni impedir un banner ya presentado. No contar guía como movimiento.

## Tareas activas

| Tarea | Responsable | Estado | Cierre esperado |
|---|---|---|---|
| Repositorio y documentación inicial | Equipo | Commits `ff5ef84` y `351c267` integrados en la historia de `main` | Mantener documentación pública coherente con la implementación vigente |
| Primera implementación e iteración de interfaz | Equipo | Marea implementada; análisis estático pasó. La suite no ejecutó por bloqueo de socket y el build APK se omitió al no haber SDK configurado | Ejecutar pruebas en un entorno Flutter habilitado y compilar en una máquina con SDK |
| Confirmar destinos reales | Equipo | Flutter detecta solo Linux aquí; el permiso habilitado en Android informado anteriormente por el equipo no se volvió a comprobar | Registrar el destino Android y su resultado sin generalizar a otros dispositivos |
| Prueba de canal real | Equipo, por repartir | Todos pendientes en esta revisión: permiso; recepción; toque con app activa; toque en segundo plano; toque con proceso cerrado; aviso cancelado/reemplazado | Registrar cada caso por separado en el teléfono y versión probados |
| Checkpoint 1 · 12:00 | Equipo | Realizado; Alex informa que el checkpoint salió bien y recomienda investigar cómo acercar la propuesta a la persona | Integrar el aprendizaje sobre autocompasión sin inducir culpa ni exagerar el efecto |
| Checkpoint 2 · 17:15 | Equipo | Base implementada, comprobación en destino pendiente | Demostrar una función central en un destino real |

## Continuidad del trabajo

Lee la guía para la tarea acordada. Reparte archivos y ramas con el otro integrante. Registra tus hallazgos en tu archivo de aportes; un integrador actualiza matriz/decisiones/estado. Sincroniza y relee antes de tareas dependientes. No asumir que los archivos de otra rama ya están integrados.

Siguiente paso: ejecutar la nueva suite en un entorno donde Flutter Test pueda abrir su socket y probar APK/avisos en el teléfono Android del equipo. El harness Flutter headless, las pruebas simuladas del puente y el análisis estático no sustituyen estas comprobaciones físicas. Consulta la [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) como registro histórico y la [guía técnica](GUIA_COLABORACION_TECNICA.md).
