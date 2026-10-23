# Estado compartido · nikucode

Actualización: 23 de octubre de 2026. Registro compartido para integrantes y asistentes; las sesiones de trabajo no comparten memoria automáticamente.

## Estado observado

- Checkout revisado para esta iteración: rama `alex/marea-menu-integracion`, base HEAD `5981386` (`fix: clarify pause flow and reflow accessibility layout`); hay cambios de trabajo locales sin commit para saludo, guía y panorama. Incluye el prototipo Flutter, pruebas automatizadas y adaptadores para Android, Linux, navegador y destino no disponible. No se cambió de rama ni se modificaron los avisos nativos durante esta iteración.
- El commit `1b1ce4b` en `alex/marea-menu-integracion` integra perfil opcional y preferencias locales mediante `shared_preferences`, resumen de interacciones limitado a la sesión, y accesos a Mi espacio, Mi panorama y ajustes en Marea. No requiere base remota.
- La implementación actual presenta dos opciones sin prescribir movimientos: caminar condicionalmente o elegir un movimiento habitual propio. Cada guía se divide en tres pasos visibles; permite dejar la pantalla y no exige duración, repeticiones ni completar un temporizador. «Configurar aviso» abre ajustes; la programación requiere activar explícitamente el canal y elegir un intervalo. El intervalo es una decisión técnica, no una recomendación sanitaria.
- El apodo del perfil es local y opcional. Inicio lo muestra como «Hola, [apodo]» cuando tiene contenido no vacío y vuelve al texto neutral si se borra o queda en blanco. Mi panorama muestra conteos de interacción de la sesión: no persiste eventos ni distribuye datos por día u hora; tampoco mide movimiento, sedentarismo, salud o progreso. Un historial temporal requeriría una decisión separada sobre periodo, persistencia y privacidad.
- El estado del flujo distingue temporizador local pendiente, solicitud de mostrar y fallo; no confirma que el aviso haya sido entregado ni que hubiera movimiento. El equipo informó que pudo habilitar avisos en un celular Android: esto confirma la habilitación en ese equipo, no la entrega ni apertura del aviso, y no se generaliza a otros teléfonos o sistemas. Esta sesión no compiló Android ni volvió a observar ese teléfono.
- Repo público creado por el equipo: https://github.com/nikucode/nikucode-senales-2026 (enlace y pantalla aportados por Alex).
- Las capturas y compilaciones de iteraciones anteriores documentadas abajo son evidencia histórica; no describen por sí solas el estado visual de este HEAD. La sesión actual no abrió la app en una ventana ni en un teléfono.
- La fase «A construir» comenzó a las 09:45, una vez terminada la bienvenida, según el programa compartido por el equipo.
- Primera app nueva en `app/`, con Flutter 3.47.7/Dart 3.13.5 como base inicial de implementación. Hay adaptadores y código Android en el checkout, pero esta sesión no generó APK ni comprobó canal nativo; dispositivos físicos aún por confirmar.
- Verificación de esta iteración: formato Dart y `flutter analyze --no-pub` pasaron. El harness `tool/checkpoint_smoke.dart`, construido y ejecutado con `flutter_tester --disable-vm-service`, pasó 20 comprobaciones y produjo ocho capturas sin errores Flutter; usa un canal simulado y no cubre los nuevos casos de apodo/panorama ni sustituye la suite. `flutter test --no-pub --concurrency=1 test/pause_view_model_test.dart test/widget_test.dart` no pudo iniciar aquí: el sandbox rechazó crear `127.0.0.1:0` (`Operation not permitted`). No se probó Linux gráfico, navegador ni teléfono físico en esta iteración.
- Recorrido/estado/render comprobados con motor Flutter headless: 20 checks, ocho capturas, cero errores Flutter y canal simulado. `flutter analyze --no-pub` y builds Linux debug/web release pasaron. La ventana Linux no pudo abrirse en esta sesión porque no hay display disponible. Gestos, lector de pantalla, avisos del SO y teléfono real siguen sin verificar. Ver [evidencia](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).
- El flujo conserva composición central y sin tarjeta, ahora con «Marea»: fondo oscuro azul profundo, ilustración 3D acuática original de 72 KB, flotación leve, botones translúcidos ovalados y transición del contenido que respeta movimiento reducido. `flutter analyze --no-pub` pasó y el harness headless produjo 20 comprobaciones, ocho capturas y cero errores; no sustituye una prueba gráfica real. La propuesta al 200 % mantiene título, CTA, alternativas y salida en 390×844. Los contrastes finales, controles con lector/teclado y prueba en dispositivos siguen pendientes. Las capturas actuales están en [evidencia](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md). Ver [investigación visual y SDD](INVESTIGACION_REFERENTES_VISUALES_Y_SDD_2026-10-23.md).
- La guía incorpora SDD ligero por cambio, sin instalar herramientas: requisito observable enlazado a AC, revisión antes de implementar, evidencia por destino y cierre del estado.
- Preparados: investigación, especificación, fuentes, aceptación, rutas técnicas, guion de checkpoint, defensa y borrador de cinco diapositivas.

## Decisiones y propuestas

Confirmado: computador y celular; caso del propio equipo; un repo público para código/documentación/entrega.
Propuesto: recorrido breve, C1/C2, programación puntual sin recurrencia inicial, controles para cambiar/posponer/rechazar/detener; sin cuentas, sincronización, rachas, IA o cámara en el núcleo. La expansión comercial y los efectos del diseño visual se mantienen como hipótesis descritas en [la investigación de experiencia y acceso](INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md) y [el análisis de referentes visuales/SDD](INVESTIGACION_REFERENTES_VISUALES_Y_SDD_2026-10-23.md).

Contratos: abrir propuesta consume/invalida invitación y cancela programación propia; hora programada no es caducidad; validez por generación. No garantizar impedir banner ya entregado por el SO. No contar guía como movimiento.

## Tareas activas

| Tarea | Responsable | Estado | Cierre esperado |
|---|---|---|---|
| Repositorio y documentación inicial | Equipo | Commits `ff5ef84` y `351c267` integrados en la historia de `main` | Mantener documentación pública coherente con la implementación vigente |
| Primera implementación e iteración de interfaz | Equipo | Marea implementada y compilada localmente; análisis estático y 20 comprobaciones headless pasaron | Abrir en terminal gráfica y revisar interacción/asistencia en equipos reales |
| Confirmar destinos reales | Equipo | Pendiente | Stack inicial Flutter; registrar computador/teléfono sin identificadores personales |
| Prueba de canal real | Equipo, por repartir | Pendiente | Comprobar permiso/entrega/toque/cancelación; el fake no lo sustituye |
| Checkpoint 1 · 12:00 | Equipo | Realizado; Alex informa que el checkpoint salió bien y recomienda investigar cómo acercar la propuesta a la persona | Integrar el aprendizaje sobre autocompasión sin inducir culpa ni exagerar el efecto |
| Checkpoint 2 · 17:15 | Equipo | Base implementada, comprobación en destino pendiente | Demostrar una función central en un destino real |

## Continuidad del trabajo

Lee la guía para la tarea acordada. Reparte archivos y ramas con el otro integrante. Registra tus hallazgos en tu archivo de aportes; un integrador actualiza matriz/decisiones/estado. Sincroniza y relee antes de tareas dependientes. No asumir que los archivos de otra rama ya están integrados.

Siguiente paso: comprobar el recorrido y el canal en dispositivos reales del equipo, registrar los destinos disponibles y repartir los archivos antes de modificar módulos compartidos. El motor Flutter headless confirmó estados y capturas con un canal simulado; no sustituye una prueba de avisos ni una evaluación con usuarios. Consulta la [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) y la [guía técnica](GUIA_COLABORACION_TECNICA.md).
