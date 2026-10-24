# nikucode · pausa

Primera implementación creada durante la hackatón. Recorrido manual, dos propuestas modificables, guía detenible, cierres diferenciados y recordatorios puntuales con control explícito.

La interfaz se actualizó con una composición editorial y un motivo gráfico propio, conservando el recorrido y los controles. La dirección visual es una hipótesis en evaluación; el análisis estático no sustituye pruebas en pantalla, teclado o lectores de pantalla. Véase [investigación de experiencia y accesibilidad](../docs/INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md).

El apodo, avatar y preferencias de acceso (contraste, movimiento reducido y escala de texto) se guardan localmente. La habilitación de avisos no se guarda como preferencia de la app. Mi panorama muestra en Android el uso de apps por día de la semana cuando la persona concede acceso especial a las estadísticas de uso. Esos datos se consultan al abrir la vista y no se guardan en nikucode. Las seis categorías de interacción propias se cuentan por fecha y se guardan localmente hasta que se borre el historial. No miden movimiento, sedentarismo, salud ni progreso; el registro empieza con esta versión y no reconstruye semanas anteriores.

## Ejecutar

Desde esta carpeta, con Flutter instalado:

```sh
flutter pub get
flutter run -d linux
```

Para probar el recorrido web en el navegador del computador:

```sh
flutter run -d web-server --web-port=8080
```

Abrir la URL mostrada por el comando. Para acceso desde teléfono en la misma red se requiere servir en una interfaz accesible —por ejemplo, `--web-hostname=0.0.0.0`— y usar la IP del computador. El HTTP de una IP local no garantiza las APIs de avisos: esa ruta sirve para probar el recorrido, no para demostrar notificaciones móviles. No se desplegó un sitio público.

Versiones observadas en el entorno de Alex: Flutter3.47.7, Dart3.13.5. El pubspec conserva su requisito de SDK. No copiar paquetes compilados entre plataformas. Para otra plataforma, comprobar su toolchain antes de prometer un ejecutable.

## Avisos: alcance implementado

- Linux: `notify-send` y `busctl`, servidor de sesión con acciones y permiso/acceso efectivo. La programación usa un Timer en el proceso; cerrar la app la pierde y suspender puede retrasarla. Al pulsar el aviso se solicita activar la ventana mediante un canal nativo; el compositor puede limitarlo.
- Web: Notifications API si existe y el usuario la habilita. Requiere contexto/permisos compatibles y pestaña viva; el navegador puede retrasar timers ocultos. Algunos navegadores móviles rechazan el constructor aun con permiso: se muestra error en vez de prometer un service worker inexistente.
- Android nativo: `MainActivity` implementa el permiso y la apertura de una invitación. Sin Omarchy emparejado, el temporizador local sigue en memoria y requiere que la pantalla Flutter permanezca activa. Con Omarchy emparejado, el servicio de conexión conserva la hora elegida y publica el aviso Android aunque se cierre la pantalla; Android puede detener ese servicio. No hay alarma exacta ni garantía de entrega. El toque del aviso se valida mediante un ID opaco guardado localmente y consumido una sola vez. La compilación APK y la entrega física de esta versión compartida siguen pendientes de comprobación.
- Sin recurrencia, cuenta, registro de salud ni detección corporal.

## Pausas entre Android y Omarchy

Con los equipos emparejados, **Avisos, si los quieres** programa la misma invitación para Android y Omarchy: 5, 15 o 30 minutos, o la prueba de 10 segundos. Android guarda la hora y muestra su aviso desde el servicio de conexión; Linux guarda la señal y muestra el mismo título y texto con **Iniciar pausa** y **Posponer 10 min**. Cancelar o reemplazar desde Android retira la programación pendiente en ambos dispositivos; posponer desde Omarchy programa el siguiente aviso también en Android. La ventana de descanso reutiliza las mismas propuestas de la app y muestra un temporizador de 3 minutos, ajustable a 1 o 5. Finalizar y detener se sincronizan como interacciones, nunca como movimiento verificado.

La conexión usa TLS local. Linux anuncia el computador por Avahi y Android lo descubre por NSD. Elige el equipo en Android y compara en ambos dispositivos la clave de 16 caracteres de la conexión. Confirma en las dos pantallas antes de que venza la solicitud. Linux fija el certificado y guarda la credencial; después reconecta con la dirección y el puerto anunciados, sin volver a emparejar. El cliente Linux abre la conexión hacia Android, por lo que no se añade una regla de entrada al cortafuegos de Omarchy. Las credenciales del emparejamiento anterior continúan siendo válidas.

Android mantiene el servidor, la señal local y la cola de sincronización en un servicio de primer plano `connectedDevice` con aviso persistente y botón para detener la conexión. La app puede cerrar su pantalla y continuar mostrando su aviso y sincronizando mientras Android mantenga activo ese servicio. Las solicitudes antiguas se migran al almacén nativo al abrir la versión nueva; los resultados recibidos con la pantalla cerrada se registran en Mi panorama al volver a abrirla. Si Omarchy no está disponible, la solicitud queda pendiente en Android y se envía al reconectar; si venció hace más de un minuto, no se muestra tardíamente en el escritorio.

La identidad emparejada y la cola de Omarchy se guardan bajo `~/.local/share/nikucode-pausa/` (o `XDG_DATA_HOME`) con permisos solo para la cuenta de usuario. Desvincular en un dispositivo retira sus datos locales; si el otro está desconectado, desvincúlalo también allí.

Los cambios nativos requieren reinstalar Android mediante `flutter run`; hot reload no actualiza Kotlin. Los fallos TLS y NSD aparecen con la etiqueta `NikucodeLan` en `adb logcat`. Si la red aísla clientes WiFi o Android detiene el servicio, la interfaz mostrará falta de conexión y se puede reactivar desde **Pausas en Omarchy**.

Para preparar el servicio en Omarchy, desde `app/`:

```sh
bash linux/install-companion.sh
```

Este script compila Linux, copia el paquete a `~/.local/lib/nikucode-pausa` e instala y reinicia `nikucode-pausa.service` como servicio de usuario de la sesión gráfica. Requiere `avahi-daemon`, `avahi-browse`, `avahi-publish-service` y `notify-send`. En Android abre **Pausas en Omarchy**, elige el computador y compara la clave. En Linux pulsa **Revisar clave** en la notificación o abre la app y confirma. Después puedes cerrar la ventana Linux: el servicio seguirá atendiendo avisos; al pulsar la tarjeta de una señal o elegir **Iniciar pausa**, se abrirá la app con la propuesta de pausa.

La red debe permitir que ambos dispositivos se alcancen; algunas redes de invitados aíslan clientes WiFi. El servicio se inicia tras entrar en la sesión gráfica, no cuando el computador está apagado. Una pausa que haya vencido hace más de 30 minutos durante suspensión o apagado se marca como perdida. El instalador y el recorrido real deben verificarse en el Omarchy y móvil de destino.

Cancelar o reemplazar invalida también los IDs en espera entre Android y Dart. Una respuesta inicial tardía no abre una propuesta después de una elección manual. Un error al leer o validar la invitación deja disponible el inicio manual y muestra que no se pudo comprobar. Preparar un nuevo temporizador requiere que la retirada anterior responda sin error; un fallo no se confirma como cancelación ni como nueva programación.

Las solicitudes simultáneas de permiso desde Dart comparten una respuesta nativa, para no sobrescribir el resultado pendiente en `MainActivity`. Una respuesta con un tipo inesperado no se interpreta como permiso concedido. Esta protección del adaptador no demuestra la recepción de un aviso en Android.

Las preferencias de contraste, tamaño de texto y movimiento reducido se aplican por encima del navegador de pantallas. Las hojas abiertas reciben el tema actualizado; las categorías de Mi panorama tienen nodos semánticos propios. Con movimiento reducido activo, las nuevas hojas y el diálogo de avisos se crean sin transición animada. El estilo de una ventana se fija al abrirla: si se cambia la preferencia mientras está abierta, su transición de cierre puede conservar el estilo anterior. No se ha validado accesibilidad en dispositivo.

## Estructura

- `lib/main.dart`: vistas adaptables y presentación.
- `lib/pause_view_model.dart`: reglas, propuestas y estados, sin medición de movimiento.
- `lib/reminder_channel.dart`: contrato del canal.
- `lib/reminder_channel_{io,web,stub}.dart`: adaptadores por destino.
- `linux/runner/my_application.cc`: activación de ventana solo al pulsar un aviso.
- `lib/lan_{android,linux}.dart` y `android/.../LanPauseServer.kt`: cola local, enlace TLS, notificaciones y sincronización.
- `linux/install-companion.sh`: instalación del servicio de usuario de Omarchy.
- `test/`: casos de lógica y widgets.
- `tool/checkpoint_smoke.dart`: verificación headless sin sockets, con canal simulado.

## Comprobar

```sh
flutter analyze --no-pub
flutter test --no-pub --concurrency=1
flutter build linux --debug --no-pub
flutter build web --no-pub --no-web-resources-cdn --no-wasm-dry-run
```

Revisión de cierre del 23-10 preparada sobre `2dd5154`; los resultados siguientes corresponden a los archivos de esta entrega. Formato Dart y `flutter analyze --no-pub` pasaron. El runner no pudo crear `127.0.0.1:0` (`Operation not permitted`), por lo que la suite no ejecutó casos. `flutter doctor -v` no encontró Android SDK y `flutter devices` solo detectó Linux: no se ejecutó build APK ni recorrido físico. Los tests de MethodChannel simulado no comprueban la `MainActivity` ni la entrega del sistema.

Las capturas y resultados del [primer recorrido](../docs/PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) son históricos; no son evidencia de esta revisión. No se utilizó ese harness para sustituir la suite bloqueada.

Los binarios/builds y cachés quedan ignorados por Git. Las instrucciones no equivalen a pruebas observadas de avisos del sistema, teléfono físico, teclado/lector o efecto conductual.
