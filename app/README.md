# nikucode · pausa

Primera implementación creada durante la hackatón. Recorrido manual, dos propuestas modificables, guía detenible, cierres diferenciados y recordatorios puntuales con control explícito.

La interfaz se actualizó con una composición editorial y un motivo gráfico propio, conservando el recorrido y los controles. La dirección visual es una hipótesis en evaluación; el análisis estático no sustituye pruebas en pantalla, teclado o lectores de pantalla. Véase [investigación de experiencia y accesibilidad](../docs/INVESTIGACION_DISENO_EXPERIENCIA_Y_MODELO_ACCESO.md).

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
- Android nativo: `MainActivity` implementa el permiso de notificaciones y la publicación/apertura de una invitación. El temporizador corre en la sesión Flutter: se requiere mantener la app abierta; no hay alarma exacta ni garantía de entrega en segundo plano. La prueba de APK y la entrega/toque en teléfono físico siguen pendientes en el entorno de Alex. En un equipo con Android SDK y dispositivo conectado, desde esta carpeta ejecutar `flutter devices` y luego `flutter run -d <device-id>`.
- Preferencias y pendientes solo en memoria. Sin recurrencia, sincronización, cuenta, registro de salud ni detección corporal.

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
flutter test --no-pub
flutter build linux --debug --no-pub
flutter build web --no-pub --no-web-resources-cdn --no-wasm-dry-run
```

El runner estándar de tests está bloqueado en la sesión de construcción por prohibición de bind local; no se afirma que su suite pasó. La verificación alternativa ejecutó el motor real offline con un canal simulado. Método, capturas y límites en [evidencia del primer recorrido](../docs/PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).

Los binarios/builds y cachés quedan ignorados por Git. Las instrucciones no equivalen a pruebas observadas de avisos del sistema, teléfono físico, teclado/lector o efecto conductual.
