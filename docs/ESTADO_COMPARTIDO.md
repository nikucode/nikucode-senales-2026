# Estado compartido · nikucode

Actualización: 23 de octubre de 2026. Registro compartido para integrantes y asistentes; las sesiones de trabajo no comparten memoria automáticamente.

## Estado observado

- Repo público creado por el equipo: https://github.com/nikucode/nikucode-senales-2026 (enlace y pantalla aportados por Alex).
- Al iniciar esta revisión, `main` y `origin/main` apuntaban a `b6c3318`, que incluye la primera app y la actualización visual. La iteración de interfaz descrita abajo está en cambios locales aún no publicados.
- La fase «A construir» comenzó a las 09:45, una vez terminada la bienvenida, según el programa compartido por el equipo.
- Primera app nueva en `app/`, con Flutter 3.47.7/Dart 3.13.5 como base inicial de implementación. Compilaron Linux debug y web. Android tiene scaffold, sin APK/canal nativo probado; dispositivos físicos aún por confirmar.
- Recorrido/estado/render comprobados con motor Flutter headless: 20 checks, ocho capturas, cero errores Flutter y canal simulado. `flutter analyze --no-pub` y builds Linux debug/web release pasaron. La ventana Linux no pudo abrirse en esta sesión porque no hay display disponible. Gestos, lector de pantalla, avisos del SO y teléfono real siguen sin verificar. Ver [evidencia](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).
- En propuesta, guía y cierre se quitó la introducción repetida; además, el encabezado interno se compacta y el adorno se reduce con el recorrido abierto. A 200 % la acción principal aparece al borde inferior y los demás controles requieren desplazamiento. Las capturas actuales están en `docs/evidencia/`; esto no es una evaluación de interacción ni certificación de accesibilidad.
- Preparados: investigación, especificación, fuentes, aceptación, rutas técnicas, guion de checkpoint, defensa y borrador de cinco diapositivas.

## Decisiones y propuestas

Confirmado: computador y celular; caso del propio equipo; un repo público para código/documentación/entrega.
Propuesto: recorrido breve, C1/C2, programación puntual sin recurrencia inicial, controles para cambiar/posponer/rechazar/detener; sin cuentas, sincronización, rachas, IA o cámara en el núcleo. La expansión comercial y el diseño visual se mantienen como hipótesis descritas en [la investigación de experiencia y acceso](INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md).

Contratos: abrir propuesta consume/invalida invitación y cancela programación propia; hora programada no es caducidad; validez por generación. No garantizar impedir banner ya entregado por el SO. No contar guía como movimiento.

## Tareas activas

| Tarea | Responsable | Estado | Cierre esperado |
|---|---|---|---|
| Repositorio y documentación inicial | Equipo | Commits `ff5ef84` y `351c267` integrados en la historia de `main` | Mantener documentación pública coherente con la implementación vigente |
| Primera implementación e iteración de interfaz | Equipo | App en `main`; ajuste compacto local probado con 19 checks y ocho capturas | Recompilar Linux/web y revisar interacción/asistencia en equipos reales |
| Confirmar destinos reales | Equipo | Pendiente | Stack inicial Flutter; registrar computador/teléfono sin identificadores personales |
| Prueba de canal real | Equipo, por repartir | Pendiente | Comprobar permiso/entrega/toque/cancelación; el fake no lo sustituye |
| Checkpoint 1 · 12:00 | Equipo | Realizado; Alex informa que el checkpoint salió bien y recomienda investigar cómo acercar la propuesta a la persona | Integrar el aprendizaje sobre autocompasión sin inducir culpa ni exagerar el efecto |
| Checkpoint 2 · 17:15 | Equipo | Base implementada, comprobación en destino pendiente | Demostrar una función central en un destino real |

## Continuidad del trabajo

Lee la guía para la tarea acordada. Reparte archivos y ramas con el otro integrante. Registra tus hallazgos en tu archivo de aportes; un integrador actualiza matriz/decisiones/estado. Sincroniza y relee antes de tareas dependientes. No asumir que los archivos de otra rama ya están integrados.

Siguiente paso: comprobar el recorrido y el canal en dispositivos reales del equipo, registrar los destinos disponibles y repartir los archivos antes de modificar módulos compartidos. El motor Flutter headless confirmó estados y capturas con un canal simulado; no sustituye una prueba de avisos ni una evaluación con usuarios. Consulta la [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) y la [guía técnica](GUIA_COLABORACION_TECNICA.md).
