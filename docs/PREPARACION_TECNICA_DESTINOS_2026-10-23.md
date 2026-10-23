# Preparación técnica: computador, celular y señales

Fecha: 23-10-2026. Investigación documental y comprobaciones locales breves. No hay código competitivo, repositorio nuevo, compilación, instalación, cambio de configuración ni prueba de notificaciones en este bloque. Documento para decidir y comprobar al comenzar el evento, después de la bienvenida.

## 1. Decisión candidata para ahorrar trabajo

**Confirmar los dos dispositivos reales y probar el canal antes de decorar pantallas.** El alcance sigue siendo computador y celular; stack y sistemas no están elegidos. La ruta depende de ese inventario y de la prueba observable.

Si hay teléfono Android disponible y el computador es el Linux actual, **Flutter es una candidata razonable para un recorrido compartido**, con adaptadores de señal distintos. La propuesta técnica mínima es móvil con programación local del sistema cuando se compruebe, y escritorio con proceso vivo/minimizado durante la sesión. Esto no acredita operación después de cerrar el proceso ni durante suspensión. No es una selección definitiva ni garantiza menor esfuerzo que otras tecnologías.

Si el teléfono es iPhone y no hay Mac con herramientas preparadas, investigar una vía web para el recorrido evita asumir una compilación iOS local imposible en este computador. Su canal de aviso debe comprobarse aparte; no prometer que una pestaña proporciona posposición fiable cuando está cerrada. La alternativa puede conservar el recorrido en ambos destinos y declarar un alcance de señales limitado, revisando la promesa conductual. No ocultar esa reducción como si el problema de iniciación estuviera resuelto.

**Descartar como atajo:** cuenta, sincronización, backend de IA, captura de actividad y sensores. No son necesarios para demostrar un recorrido autónomo y controlable; añadirlos requeriría una necesidad y comprobación adicionales. Mantener preferencias y pendientes por dispositivo, sin promesa de deduplicación entre aparatos.

## 2. Hallazgos documentales decisivos

| ID técnico local | Fuente primaria consultada y acceso | Hallazgo y efecto sobre el plan |
|---|---|---|
| T23-01 | [Flutter: plataformas soportadas](https://docs.flutter.dev/reference/supported-platforms), tabla de Flutter 3.47 y fecha editorial 22-09-2026 | Soportar Android, iOS, escritorio y web no hace idénticas sus integraciones. La tabla enumera Debian/Ubuntu para Linux; el Arch/Omarchy local no queda acreditado por esa lista. Debe compilarse y probarse el destino real. |
| T23-02 | [Documentación del mantenedor de flutter_local_notifications](https://pub.dev/documentation/flutter_local_notifications/latest/), secciones Supported platforms y Limitations | Incluye web actualmente, pero programación/repetición web no soportadas. Linux no ofrece programación/pendientes mediante este plugin; acciones dependen del servidor y el callback necesita app viva salvo integración D-Bus adicional. Windows tiene límites de cancelación si no existe identidad MSIX. No trasladar capacidades de Android a todos los destinos ni fijar aún una versión de dependencia. |
| T23-03 | [Android: permiso de notificaciones](https://developer.android.com/develop/ui/compose/notifications/notification-permission), permiso y elección del usuario | Android 13+ exige POST_NOTIFICATIONS para avisos no exentos. Denegar bloquea esos avisos. Permiso concedido no garantiza percepción ni oportunidad. El estado visible debe reflejar la configuración efectiva. |
| T23-04 | [Android: alarmas](https://developer.android.com/develop/background-work/services/alarms), alarmas inexactas/exactas, cancelación y reinicio | Programación del sistema puede operar fuera de la vida de la app, con restricciones energéticas. Las alarmas inexactas no sirven para prometer segundos precisos; exactas requieren justificación/permisos según versión. Al apagar se cancelan alarmas por defecto; persistir y reprogramar exige trabajo explícito. Diferenciar cancelar una alarma de retirar un aviso ya entregado. |
| T23-05 | [Freedesktop: diseño](https://specifications.freedesktop.org/notification/latest/basic-design.html) y [protocolo D-Bus](https://specifications.freedesktop.org/notification/latest/protocol.html), leídos | El servidor de avisos es de sesión y puede no estar disponible. GetCapabilities describe funciones opcionales; acciones/activación no deben asumirse. CloseNotification retira una entrega por identificador; el cliente necesita distinguir ese identificador de su propio pendiente futuro. No hay garantía universal de foco o botones. |
| T23-06 | [MDN: uso de Notifications API](https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API/Using_the_Notifications_API), uso/permisos y móvil | Permiso solicitado con interacción explícita; móviles requieren la vía de service worker en lugar de asumir constructor de escritorio. Debe detectarse la capacidad y probar navegador real. Mostrar un aviso y conseguir ejecutarlo en el futuro son problemas diferentes. |
| T23-07 | [MDN: contextos seguros](https://developer.mozilla.org/en-US/docs/Web/Security/Defenses/Secure_Contexts), ejemplos de orígenes | HTTPS y loopback pueden ser contextos confiables. Que funcione en localhost del computador no garantiza APIs restringidas al abrir una IP local por HTTP desde el teléfono. Verificar origen, certificado y capacidad en el móvil. |
| T23-08 | [Chrome: temporizadores en pestañas ocultas](https://developer.chrome.com/blog/timer-throttling-in-chrome-88), anuncio/mecanismo documentado | Los timers encadenados de páginas ocultas se ralentizan bajo condiciones concretas. No usar un timer de pestaña como garantía de señal precisa en segundo plano; el artículo explica un mecanismo, no una medición del navegador local actual. |
| T23-09 | [WebKit: Web Push en iOS/iPadOS](https://webkit.org/blog/13878/web-push-for-web-apps-on-ios-and-ipados/) y [Apple: Web Push](https://developer.apple.com/documentation/usernotifications/sending-web-push-notifications-in-web-apps-and-browsers?language=objc), texto accesible | En iOS/iPadOS 16.4+ se describe Web Push para apps añadidas a pantalla de inicio, con permiso tras gesto y participación del servidor push. No confundirlo con calendario local offline de navegador. Instalar/autorizar forma parte del recorrido y añade fricción. |
| T23-10 | [Flutter: preparar iOS](https://docs.flutter.dev/platform-integration/ios/setup), herramientas Xcode | Construcción/ejecución iOS requiere toolchain de Xcode; no se ha observado Mac/Xcode en el equipo. Tener Flutter en Linux no acredita poder entregar una app iOS nativa. |
| T23-11 | [Flutter: preparar Linux](https://docs.flutter.dev/platform-integration/linux/setup), requisitos y verificación | La documentación pide toolchain de compilación, GTK y comprobación de entorno. Comandos de paquetes Debian no se trasladan literalmente a Arch. Se verificó presencia de herramientas, no un build. |

Se consultó además [Service Worker API](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API), descripción general. No se deriva de ella un scheduler universal. La página Apple de programación local nativa devolvió una carcasa JavaScript y su enlace Markdown no se pudo recuperar: no se afirma lectura de ese contenido.

## 3. Matriz para elegir al llegar

| Situación real | Ruta candidata | Primera comprobación | Promesa que no hacer aún |
|---|---|---|---|
| Linux + Android real con depuración autorizada | Flutter común para interfaz/estados, integración por destino | Arranque en ambos; permiso y señal móvil fuera de primer plano; escritorio minimizado | Entrega exacta siempre, supervivencia al cierre/suspensión o compatibilidad con todo Linux |
| Computador + teléfono con navegador compatible | Recorrido web adaptable; canal por separado | Origen seguro real en teléfono, autorización, pestaña oculta/instalación y ruta al tocar aviso | PWA instalada equivale a scheduler offline fiable |
| iPhone sin Mac/toolchain verificado | Web como candidata para recorrido; evaluar Web Push solo si su coste cabe | Instalación/permiso y entrega real; dependencia de conexión/servicio | iOS nativo construido desde el Linux actual, avisos locales garantizados |
| Mac/Xcode o Windows real disponibles | Reconsiderar destino nativo según herramientas ya preparadas | Build inicial y capacidades/cancelación en ese sistema | Copiar resultados del Linux actual |
| Ningún canal fuera de primer plano resulta viable | Mantener recorrido autónomo manual en ambos, describiendo límite | Que se comprende/adapta/rechaza/detiene sin fallo | Que abrir manualmente demuestra iniciación espontánea durante trabajo |

El último caso es un fallback honesto, pero debilita la solución al problema original: requiere revisar narrativa y prioridad, no solo esconder un botón. Una notificación de prueba enviada desde otro servicio o comando puede aislar si el sistema muestra avisos; no cuenta como implementación de la app.

## 4. Contratos que debe respetar cualquier stack

Los siguientes son criterios de diseño/aceptación derivados de la ficha, no funciones observadas:

1. Estado de canal: disponible/no disponible, habilitado/deshabilitado, permiso concedido/denegado/desconocido. «Programado» solo tras confirmación de la integración elegida.
2. Una interacción activa por dispositivo. Llegar desde señal válida abre su propuesta, sin otro embudo de Inicio. Abrir propuesta manual o desde aviso consume/invalida esa invitación y cancela su programación pendiente; salir no la restaura. No tomar foco/bloquear escritura por la mera llegada; verificar en escritorio. No se garantiza impedir un banner que el SO ya hubiera entregado.
3. Un pendiente local como máximo. Nueva posposición reemplaza la anterior; identificador propio estable, cancelación y confirmación visible. No tratar un timestamp guardado como prueba de programación del sistema.
4. Empezar/rechazar/desactivar cancela el pendiente correspondiente conforme a la ficha. Retirar entregas propias cuando sea soportado. Nunca borrar avisos ajenos.
5. Con canal apagado/denegado/no implementado, «Más tarde» no programa ni reactiva implícitamente. Explicar el límite y dejar salir.
6. Persistir solo preferencias/invitación necesarias. Separar hora programada, entrega conocida/desconocida y validez por identificador/generación. Pasar la hora no invalida por sí solo un aviso entregado; cancelar/reemplazar/consumir/desactivar sí. Sin caducidad temporal adicional inicial. Reconciliar al reabrir sin reprogramar atrasados ni producir ráfagas. Cerrar/finalizar guía no acredita movimiento.
7. Guía detenible, sin exigir sostener teléfono o mirar pantalla. Comprobar teclado, lector, texto ampliado, foco y contraste en ambas implementaciones.
8. Política recurrente solo si está definida y probada; no agregarla porque existe un método de API. Una posposición de demostración no implica una frecuencia saludable universal.
9. Reloj relativo frente a fecha civil: elegir según contrato. Probar cambio de hora/zona antes de prometer horarios civiles; una sesión breve puede limitar explícitamente ese alcance.

Para reducir esfuerzo mañana, la separación conceptual candidata es: contenido estático, estado de interacción y adaptador de señal por plataforma. Preferencias locales sin historial clínico. Esto es una especificación documental; no se generó scaffold, interfaz de código ni archivos fuente.

## 5. Prueba temprana de descarte del canal

Después de terminar la bienvenida y crear el repo vacío según reglas, hacer una prueba pequeña de integración antes de ampliar diseño. Ventana de trabajo sugerida: 30–45 minutos para decidir; es una decisión de gestión del evento, no estimación científica ni duración saludable.

| Paso | Resultado observable que registrar | Si falla |
|---|---|---|
| Identificar sistemas, versiones y dispositivos | Nombres genéricos/versiones, sin números de serie en material público | No suponer Android/iOS ni bloquear otras tareas de contenido/pitch |
| Arrancar recorrido mínimo en ambos | Ventana/pantalla real y controles de entrada/salida | Resolver toolchain o revisar modalidad antes de más pantallas |
| Habilitar canal por acción explícita | Estado real y permiso comprobado | Mostrar salida accesible; no repetir coercitivamente petición |
| Programar una señal de prueba | Pendiente, hora/alcance y confirmación del canal | No afirmar «te avisaremos»; aislar scheduler vs visualización |
| Pasar a otra app/minimizar | Aviso llega bajo contexto probado, sin robar foco | Ajustar canal/alcance, no extrapolar primer plano |
| Tocar aviso | Abre propuesta correcta una sola vez | Corregir identificador/ruta; no simularla desde Inicio |
| Posponer y después cancelar | No llega esa entrega; no queda indicador pendiente | Bloquear esa función hasta corregir contrato |
| Denegar/desactivar | No hay programación oculta; explicación y salida | Priorizarlo como defecto de control |
| Cerrar/reabrir y, si se promete, suspender/reiniciar | Estado real reconciliado; no pausa completada ni ráfaga | Limitar promesa de vida útil explícitamente |
| Pendiente → abrir propuesta manual → otra app antes de su hora | Invitación consumida y programación cancelada; sin duplicación de interfaz | Registrar carrera de banner ya entregado y capacidad real de retirada |
| Tocar después de hora; luego probar aviso cancelado/reemplazado | El primero puede abrir si sigue vigente; el segundo no reactiva interacción | Corregir validez por generación, sin usar solo reloj |

Si la prueba consume la ventana sin resultado verificable, registrar el fallo concreto y decidir el fallback con el equipo; no migrar a un backend o plugin nuevo indefinidamente. Conservar el estado funcional y comprobar nuevamente solo después de un cambio pertinente.

## 6. Herramientas observadas y límites

Comprobación realizada ahora, lectura/versión con timeout breve:

| Elemento | Observado el 23-10 | No observado |
|---|---|---|
| Flutter | 3.47.7 stable; Dart 3.13.5; DevTools 2.60.0 | Build del futuro proyecto, compatibilidad de dependencias o acceso MCP a app |
| Dart | 3.13.5 linux_x64 | Análisis/tests de la app futura |
| Git | 2.56.0 | Repo competitivo, remoto, permisos de publicación |
| adb | 1.0.41, platform-tools 37.0.0p1 | Teléfono conectado, autorizado o instalable; no se ejecutó devices |
| Chromium | 154.0.8037.97 | APIs/permisos efectivos de notificación, rendimiento o accesibilidad |
| Linux toolchain | clang, cmake, ninja, pkg-config y busctl en PATH; GTK3 3.24.52 y GTK4 4.24.1 resueltas por pkg-config | Compilación, servidor D-Bus o capacidad de acciones/foco de la sesión |

No se ejecutaron `flutter doctor`, builds, instalaciones ni pruebas del servidor de avisos. Las verificaciones previas del perfil de agentes están en [flujo de herramientas](investigacion/FLUJO_AGENTES_HERRAMIENTAS_APP_Y_PITCH_2026-10-22.md): no se repitieron. La sesión actual y el perfil de evento no tienen garantizadas las mismas herramientas/MCP.

Comandos ilustrativos para la comprobación al llegar; **no ejecutados aquí**. Cada uno debe usarse para una duda concreta, sin copiar su salida pública si contiene identificadores de dispositivos:

```sh
flutter devices
adb devices -l
flutter doctor -v
busctl --user call org.freedesktop.Notifications /org/freedesktop/Notifications org.freedesktop.Notifications GetCapabilities
```

`adb devices` puede iniciar el daemon de adb y requiere autorización del teléfono; `doctor` puede tardar. No son condiciones para dormir ni órdenes programadas. El último consulta capacidades del servidor de sesión, no envía una pausa ni demuestra el canal de la app.

## 7. Distribución de trabajo mañana

- Principal/integrador: confirma destinos, conserva contratos y posee configuración compartida, navegación, dependencias y estado común.
- Worker, una vez acordado el contrato: una integración de plataforma o un módulo con archivos exclusivos. No repartir móvil/escritorio si ambos editarán los mismos archivos centrales.
- Revisor solo lectura: examina diff estable contra casos de §5; distingue APIs configuradas de comportamiento visto.
- Auditor de evidencia/pitch: verifica que cada frase coincide con alcance demostrado. No realiza una revisión general de todos los papers otra vez.
- Equipo humano: una persona reproduce la demo y anota fricciones mientras otra conserva versión funcional/guion; ambos explican límites y respuesta al problema. Reparto definitivo según disponibilidad, sin asignar por supuestas capacidades.

Como máximo dos subagentes simultáneos; no empezar pruebas de componentes inexistentes. No hace falta instalar un orquestador, cambiar de cuenta o añadir agentes al producto. Las skills Flutter pertinentes se leerán al implementar si se selecciona ese stack; en esta investigación no se aplicaron skills de construcción de código.

## 8. Búsqueda realizada y criterio de cierre

Fuentes consultadas el 23-10-2026 mediante búsqueda web y apertura directa; no se consultó una base científica para estas preguntas de APIs. Cadenas reales principales:

- `site.pub.dev/packages/flutter_local_notifications Linux scheduled notifications limitations`.
- `site.developer.android.com notifications notification permission Android 13 schedule exact alarms reboot`.
- `site.developer.mozilla.org Notifications API secure context service worker mobile`.
- `site.webkit.org web push web apps home screen iOS iPadOS 16.4 permission`.
- `site.specifications.freedesktop.org notification spec persistence capabilities CloseNotification`.
- `site.developer.chrome.com timer throttling hidden pages service worker event driven terminated`.
- `site.docs.flutter.dev ios setup macOS Xcode required`.
- `site.developer.apple.com scheduling local notifications app not running remove pending notification requests`.

Se abrieron las páginas oficiales citadas, con énfasis en secciones de limitaciones, permisos y ciclo de vida. Se excluyeron respuestas de foros/tutoriales como fundamento de las decisiones. Los datos de paquete son de su documentación `latest` al consultar, no una dependencia bloqueada del futuro repo.

Cierre documental: hay fundamento para no equiparar responsive con avisos nativos ni aceptar un scheduler común por el nombre del plugin. La elección final y funcionamiento se cierran con dispositivos y prueba real; otra búsqueda general no sustituye ese paso.
