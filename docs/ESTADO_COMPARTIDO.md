# Estado compartido · nikucode

Actualización: 23 de octubre de 2026. Registro compartido para integrantes y asistentes; las sesiones de trabajo no comparten memoria automáticamente.

## Estado observado

- En el checkout local de `main` se está integrando selectivamente el aporte de `origin/javi/arranque-y-coordinacion` (`934aedb`, 4 commits adelante y 3 detrás de `origin/main`). Alex confirmó que `git fetch origin` se completó desde su terminal y que esa referencia apunta a `934aedb`. No se fusionó la rama completa para conservar la experiencia Marea.
- El commit `1b1ce4b` en `alex/marea-menu-integracion` integra perfil opcional y preferencias locales mediante `shared_preferences`, resumen de interacciones limitado a la sesión, y accesos a Mi espacio, Mi panorama y ajustes en Marea. No requiere base remota.
- Seguimiento local aún sin commit en esa rama: el perfil ahora posee el ciclo de vida de su campo de texto; contraste y tamaño de texto tienen cambios visibles; Mi panorama muestra barras de eventos de software; se añadieron sprites propios 3D de vidrio líquido para las etapas de pausa; y Android tiene un canal nativo de notificaciones con permiso del sistema. `flutter analyze --no-pub` pasó. El guardado del perfil, la compilación Android, los permisos, la entrega/toque de avisos y la presentación visual de los sprites aún requieren prueba en el teléfono de Javi. El arte y los ajustes son decisiones de interfaz, no evidencia de eficacia.
- Repo público creado por el equipo: https://github.com/nikucode/nikucode-senales-2026 (enlace y pantalla aportados por Alex).
- La iteración anterior partía de `f5c513b`; la revisión Marea y sus capturas son cambios locales pendientes de integrar/publicar. El prototipo se compiló para Linux, pero esta sesión no dispone de display para abrir su ventana.
- La fase «A construir» comenzó a las 09:45, una vez terminada la bienvenida, según el programa compartido por el equipo.
- Primera app nueva en `app/`, con Flutter 3.47.7/Dart 3.13.5 como base inicial de implementación. Compilaron Linux debug y web. Android tiene scaffold, sin APK/canal nativo probado; dispositivos físicos aún por confirmar.
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
