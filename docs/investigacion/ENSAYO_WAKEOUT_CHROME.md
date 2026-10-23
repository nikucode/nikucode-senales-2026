# Wakeout Chrome 1.1.0 — prueba funcional automatizada

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Fecha:** 22-10-2026. **Resultado:** tres comprobaciones funcionales completadas
en el tercer intento, con limitaciones descritas abajo. No es evaluación humana,
prueba de eficacia, ni evidencia runtime producida por REA.

## Entorno y acciones
- Chromium 154.0.8037.97, Playwright core 1.58.2, Linux, modo headless.
- Perfil, HOME y configuración nuevos; sin cuentas ni datos personales.
- Extensión cargada desde paquete público 1.1.0, sin editar sus scripts.
- Cámara/micrófono: sin permisos concedidos, sin uso ni entrada corporal.
- Bloqueador configurado mediante controles normales: se añadieron example.com
  y después example.org; se desactivó limitar por horario para que la prueba no
  dependiera del reloj. No se prueban aquí los horarios predeterminados.
- No se manipularon temporizadores ni se pulsó el atajo interno de finalización.
  Las consultas evaluate de storage y reglas fueron de lectura.
- El ID local sin empaquetar fue gikbcgpofeloaleklclbcjofmbihdepk, distinto del ID
  de tienda. El ID local no representa una comprobación criptográfica de firma.

## Resultados observados

| Comprobación | Evidencia observada | Resultado |
|---|---|---|
| Reemplazo de nueva pestaña | chrome://newtab/ acabó en newtab.html de la extensión; service worker detectado | Comprobado |
| Bloqueo de navegación | Visitar https://example.com/ redirigió a blocked.html con la URL de retorno | Comprobado |
| Inicio de rutina | Se pulsó Energy; apareció player.html y contador de cuatro ejercicios | Comprobado |
| Finalización y retorno | La página volvió a https://example.com/ tras unos 67,491 s desde el registro de inicio del reproductor | Comprobado |
| Contabilización | Estadísticas locales: totalWakeouts=4, totalSessions=1, historial de una sesión | Comprobado sin entrada corporal |
| Acceso temporal | Se guardó desbloqueo de example.com y desaparecieron sus reglas de redirección | Comprobado; no se esperaron los 15 min de expiración |
| Snooze | example.org se bloqueó; se pulsó Snooze 5m y volvió a https://example.org/ | Comprobado sin pasar por rutina |
| Expiración de Snooze | Se guardó desbloqueo de example.org | No se esperaron los 5 min para verificar rebloqueo |
| Cierre | context.close completó; no se encontraron procesos Chromium con las rutas de perfiles de estos ensayos en la comprobación posterior | Cierre de navegador respaldado, sin señales al grupo |

**Conclusión acotada:** en este recorrido, reproducir/esperar el temporizador fue
suficiente para contabilizar una sesión y conceder acceso. La aplicación no exigió
entrada corporal en el ensayo automatizado. No extrapolar a los juegos con cámara
de la app Apple. El acceso por Snooze es un control previsto del producto, no un
ataque ni vulnerabilidad demostrada.

## Texto observado
- Pantalla de bloqueo: «example.com can wait. Your back is yelling.»
- Al usar Snooze: «Snoozing? Bold choice.»
- La pantalla inicial decía «Snooze if you must — Wakefield will judge you a little».

Estas observaciones corroboran el tono encontrado estáticamente. No demuestran
culpa, motivación, dependencia o perjuicio psicológico.

## Intentos fallidos del harness, no bugs atribuidos al producto
- `runtime/`: timeout al intentar pulsar configuración con el onboarding delante.
- `runtime-02/`: el script cerró un panel que onboarding ya había abierto.
- `runtime-03/`: cerró onboarding con su botón y verificó el estado del panel;
  completó las tres aserciones previstas.
- Cada intento usó un perfil nuevo y se cerró por context.close. Los fallos
  anteriores se conservan, no se sustituyen por un resultado favorable.

## Medios y red: lo que no se puede concluir
Se registraron peticiones a vídeos CloudFront y carga sucesiva de cuatro URLs de
ejercicios. No aparecieron eventos pageerror; hubo 24 requestfailed de tipo
net::ERR_ABORTED. Cancelar cargas al navegar o cambiar vídeos puede producir esos
eventos; no se determinó su causa individual y no se etiqueta como 24 vídeos
rotos. No se midieron frames decodificados ni se inspeccionó visualmente cada
vídeo, así que no se certifica calidad de reproducción o instrucciones.

El registro del contexto no garantiza cobertura completa del service worker ni
del navegador. No permite resolver por sí solo la discrepancia de analítica de
los documentos, ni afirmar ausencia de telemetría. Tampoco se midieron foco,
notificaciones, accesibilidad, molestia visual o experiencia en navegador visible.

## Integridad y conservación
Tras las cargas faltaba _metadata/verified_contents.json en la copia extraída;
los scripts y el manifiesto presentes no cambiaron de hash. Se conservó este hecho
y se restauró ese único miembro desde el CRX original, sin sobrescribir archivos
existentes. Después coincidían de nuevo los 28 hashes del inventario original.
`verificacion_runtime.json` registra la comprobación.

El harness se ajustó después para cargar una copia de ejecución separada en
futuras corridas y proteger la extracción original. Esa mejora posterior no se
presenta como ejecutada en el ensayo 3 ni como alteración del código de Wakeout.

## Archivos de evidencia
- `runtime-03/resultado.json`: pasos, horas, tres aserciones, estados, estadísticas,
  mensaje Snooze y cierre.
- `runtime-03/eventos.json`: solicitudes, consola y errores observados.
- `runtime/` y `runtime-02/`: intentos parciales anteriores.
- `probar_extension.cjs`: harness local; `PROTOCOLO_RUNTIME.md`: condiciones.
- No hay Evidence ID REA para esta operación; los IDs de la ficha pertenecen
  exclusivamente al análisis estático anterior.
