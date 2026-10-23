# Estado compartido · nikucode

Actualización23-10-2026. Entrada común para Codex/OpenCode; no supone memoria compartida entre sesiones.

## Estado observado

- Repo público creado por el equipo: https://github.com/nikucode/nikucode-senales-2026 (enlace y pantalla aportados por Alex).
- Primer commit `ff5ef84` publicado según confirmación de Alex; `origin/main` local apunta al mismo commit. API de esta sesión sigue sin conexión DNS. No se afirma una lectura remota nueva de GitHub.
- Ampliación documental `351c267` ya está en main/origin/main local, tras sincronización del equipo. La nueva implementación se registra por separado; verificar su commit/publicación antes de asumir que la otra sesión tiene el código.
- Fase «A construir» ya confirmada desde09:45. No falta autorización temporal para desarrollo del evento.
- Primera app nueva en `app/`, con Flutter3.47.7/Dart3.13.5 como base inicial de implementación. Compilaron Linux debug y web. Android tiene scaffold, sin APK/canal nativo probado; destinos físicos del equipo aún por confirmar.
- Recorrido/estado/render comprobados con motor Flutter headless, 19 checks, siete capturas, cero errores Flutter y canal simulado. Las suites estándar están escritas pero bloqueadas por bind local; avisos SO/gestos/lector/teléfono real no verificados. Ver [evidencia](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).
- Preparados: investigación A–N, especificación, fuentes, aceptación, rutas técnicas, checkpoint12:00, guion/defensa y borrador de cinco diapositivas.

## Decisiones y propuestas

Confirmado: computador y celular; caso del propio equipo; un repo público para código/documentación/entrega.
Propuesto: recorrido breve, C1/C2, programación puntual sin recurrencia inicial, controles para cambiar/posponer/rechazar/detener; sin cuentas/sync/rachas/IA/cámara en núcleo. Revisar recorte brevemente antes de construir, sin reiniciar investigación general.

Contratos: abrir propuesta consume/invalida invitación y cancela programación propia; hora programada no es caducidad; validez por generación. No garantizar impedir banner ya entregado por el SO. No contar guía como movimiento.

## Tareas activas

| Tarea | Responsable | Estado | Cierre esperado |
|---|---|---|---|
| Publicar documentación inicial | Alex | Publicado según confirmación y ref local ff5ef84 | Primer bloque disponible; no repetir inicialización |
| Completar respaldo y arranque para Javi | Sesión Alex | Completado; commit351c267 en refs locales main/origin | Índice/arranque y respaldos disponibles tras sincronizar |
| Primera implementación | Sesión Alex / worker núcleo | Código, builds y evidencia preparados | Compartir commit y ejecutar en escritorio real |
| Confirmar destinos reales | Equipo | Pendiente | Stack inicial Flutter; registrar computador/teléfono sin identificadores personales |
| Prueba de canal real | Equipo, por repartir | Pendiente | Comprobar permiso/entrega/toque/cancelación; el fake no lo sustituye |
| Checkpoint1 de12:00 | Ambos | Guion preparado | Explicar problema, intentos previos y elección |
| Checkpoint2 de17:15 | Ambos | Base implementada, comprobación en destino pendiente | Algo central funcionando en la demo real |

## Cómo empezar

Lee la guía para la tarea acordada. Reparte archivos y ramas con el otro integrante. Registra tus hallazgos en tu archivo de aportes; un integrador actualiza matriz/decisiones/estado. Sincroniza y relee antes de tareas dependientes. No asumir que los archivos de otra rama ya están integrados.

Próximo paso: compartir el commit de app y ejecutar `cd app` / `flutter run -d linux` en la terminal normal. La sesión de construcción no accede al display ni bus de usuario, pero sí ejecutó el motor headless sin VMservice. Repartir con Javi la prueba real del canal/destino; no reescribir a la vez main/modelo/adaptadores. Para las12:00 usar el [guion del primer recorrido](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md). Javi necesita acceso de colaborador para publicar directamente; leer/clonar no lo exige.
