# Estado compartido · nikucode

Actualización: 23 de octubre de 2026. Registro compartido para integrantes y asistentes; las sesiones de trabajo no comparten memoria automáticamente.

## Estado observado

- Repo público creado por el equipo: https://github.com/nikucode/nikucode-senales-2026 (enlace y pantalla aportados por Alex).
- La rama principal local y `origin/main` apuntan a `193db7a`, que contiene la primera app Flutter. El historial público conserva los commits previos de preparación documental.
- La fase «A construir» comenzó a las 09:45, una vez terminada la bienvenida, según el programa compartido por el equipo.
- Primera app nueva en `app/`, con Flutter 3.47.7/Dart 3.13.5 como base inicial de implementación. Compilaron Linux debug y web. Android tiene scaffold, sin APK/canal nativo probado; dispositivos físicos aún por confirmar.
- Recorrido/estado/render comprobados con motor Flutter headless, 19 checks, siete capturas, cero errores Flutter y canal simulado. Las suites estándar están escritas pero bloqueadas por bind local; avisos SO/gestos/lector/teléfono real no verificados. Ver [evidencia](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).
- Iteración visual aplicada después de esas capturas; se conservan allí como registro de la primera versión. `flutter analyze --no-pub` pasó tras el cambio. Falta generar evidencia visual nueva y revisar accesibilidad con tecnologías asistivas.
- Preparados: investigación, especificación, fuentes, aceptación, rutas técnicas, guion de checkpoint, defensa y borrador de cinco diapositivas.

## Decisiones y propuestas

Confirmado: computador y celular; caso del propio equipo; un repo público para código/documentación/entrega.
Propuesto: recorrido breve, C1/C2, programación puntual sin recurrencia inicial, controles para cambiar/posponer/rechazar/detener; sin cuentas, sincronización, rachas, IA o cámara en el núcleo. La expansión comercial y el diseño visual se mantienen como hipótesis descritas en [la investigación de experiencia y acceso](INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md).

Contratos: abrir propuesta consume/invalida invitación y cancela programación propia; hora programada no es caducidad; validez por generación. No garantizar impedir banner ya entregado por el SO. No contar guía como movimiento.

## Tareas activas

| Tarea | Responsable | Estado | Cierre esperado |
|---|---|---|---|
| Repositorio y documentación inicial | Equipo | Commits `ff5ef84` y `351c267` integrados en la historia de `main` | Mantener documentación pública coherente con la implementación vigente |
| Primera implementación | Equipo | `193db7a` presente en `main` y `origin/main`; builds y evidencia registrados | Ejecutar y probar el recorrido en los dispositivos del equipo |
| Confirmar destinos reales | Equipo | Pendiente | Stack inicial Flutter; registrar computador/teléfono sin identificadores personales |
| Prueba de canal real | Equipo, por repartir | Pendiente | Comprobar permiso/entrega/toque/cancelación; el fake no lo sustituye |
| Checkpoint 1 · 12:00 | Equipo | Guion preparado | Explicar problema, intentos previos y elección |
| Checkpoint 2 · 17:15 | Equipo | Base implementada, comprobación en destino pendiente | Demostrar una función central en un destino real |

## Continuidad del trabajo

Lee la guía para la tarea acordada. Reparte archivos y ramas con el otro integrante. Registra tus hallazgos en tu archivo de aportes; un integrador actualiza matriz/decisiones/estado. Sincroniza y relee antes de tareas dependientes. No asumir que los archivos de otra rama ya están integrados.

Siguiente paso: comprobar el recorrido y el canal en dispositivos reales del equipo, registrar los destinos disponibles y repartir los archivos antes de modificar módulos compartidos. El motor Flutter headless confirmó estados y capturas con un canal simulado; no sustituye una prueba de avisos ni una evaluación con usuarios. Consulta la [evidencia del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) y la [guía técnica](GUIA_COLABORACION_TECNICA.md).
