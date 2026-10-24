# nikucode · pausa

Primera implementación creada durante la hackatón. Recorrido manual, dos propuestas modificables, guía detenible, cierres diferenciados y recordatorios puntuales con control explícito.

La interfaz se actualizó con una composición editorial y un motivo gráfico propio, conservando el recorrido y los controles. La dirección visual es una hipótesis en evaluación; el análisis estático no sustituye pruebas en pantalla, teclado o lectores de pantalla. Véase [investigación de experiencia y accesibilidad](../docs/INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md).

El apodo, avatar y preferencias de acceso (contraste, movimiento reducido y escala de texto) se guardan localmente. La habilitación de avisos no se guarda como preferencia de la app. Mi panorama presenta conteos de interacciones de la sesión actual con barras rotuladas y valores textuales accesibles; esos eventos no se persisten y no miden movimiento, sedentarismo, salud ni progreso. Una vista por día u hora requeriría decidir periodo, almacenamiento y privacidad antes de implementarse.

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
- Android nativo: `MainActivity` implementa el permiso, publicación y apertura de una invitación. El temporizador sigue en memoria y requiere que el proceso de la app continúe activo hasta solicitar la notificación; el sistema puede retrasarlo al suspender la app. No hay alarma exacta, servicio en segundo plano ni garantía de entrega. Para validar un toque en arranque en frío se guarda localmente solo el ID opaco asociado a la invitación cuya publicación se solicitó; Flutter lo acepta si Android devuelve el mismo ID en el intent. Se consume al validar el intent y se elimina al cancelar, reemplazar o desactivar. No se guarda el temporizador ni se habilitan automáticamente futuros avisos. Si el proceso termina antes de solicitar la notificación, la señal puede perderse. La compilación APK y las pruebas de aviso/toque en teléfono físico no se han observado en este entorno.
- Sin recurrencia, sincronización, cuenta, registro de salud ni detección corporal. Los contadores de Mi panorama existen solo mientras vive la sesión.

Cancelar o reemplazar invalida también los IDs en espera entre Android y Dart. Una respuesta inicial tardía no abre una propuesta después de una elección manual. Un error al leer o validar la invitación deja disponible el inicio manual y muestra que no se pudo comprobar. Preparar un nuevo temporizador requiere que la retirada anterior responda sin error; un fallo no se confirma como cancelación ni como nueva programación.

## Estructura

- `lib/main.dart`: vistas adaptables y presentación.
- `lib/pause_view_model.dart`: reglas, propuestas y estados, sin medición de movimiento.
- `lib/reminder_channel.dart`: contrato del canal.
- `lib/reminder_channel_{io,web,stub}.dart`: adaptadores por destino.
- `linux/runner/my_application.cc`: activación de ventana solo al pulsar un aviso.
- `test/`: casos de lógica y widgets.
- `tool/checkpoint_smoke.dart`: verificación headless sin sockets, con canal simulado.

## Comprobar

```sh
flutter analyze --no-pub
flutter test --no-pub --concurrency=1 test/pause_view_model_test.dart test/widget_test.dart test/android_reminder_channel_test.dart
flutter build linux --debug --no-pub
flutter build web --no-pub --no-web-resources-cdn --no-wasm-dry-run
```

Revisión del 23-10 sobre `8253005` más cambios locales: formato Dart y `flutter analyze --no-pub` pasaron. El runner no pudo crear `127.0.0.1:0` (`Operation not permitted`), por lo que la suite no ejecutó casos. `flutter doctor -v` no encontró Android SDK y `flutter devices` solo detectó Linux: no se ejecutó build APK ni recorrido físico. Los tests de MethodChannel simulado no comprueban la `MainActivity` ni la entrega del sistema.

Las capturas y resultados del [primer recorrido](../docs/PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md) son históricos; no son evidencia de esta revisión. No se utilizó ese harness para sustituir la suite bloqueada.

Los binarios/builds y cachés quedan ignorados por Git. Las instrucciones no equivalen a pruebas observadas de avisos del sistema, teléfono físico, teclado/lector o efecto conductual.
