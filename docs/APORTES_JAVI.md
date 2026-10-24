# Registro de contribuciones · Javier González

## 2026-10-24 · Pausas Android–Omarchy por WiFi local

- **Tarea:** implementar emparejamiento, programación puntual desde Android, aviso con iniciar/posponer en Omarchy, guía temporizada y sincronización de interacciones sin IA ni nube.
- **Archivos:** puente TLS nativo `LanPauseServer.kt`, controladores `app/lib/lan_*`, interfaz Flutter, servicio e instalador Linux, documentación y prueba de deduplicación.
- **Resultado local:** Android guarda solicitudes pendientes; el cliente Linux guarda las confirmadas y los resultados, se inicia oculto con la sesión gráfica y presenta la ventana desde la acción del aviso. El enlace usa certificado fijado, PIN temporal y token; los archivos del cliente tienen permisos de usuario. Se mantuvieron los cambios previos de Mi panorama y la rama local, sin commit ni publicación.
- **Comprobaciones observadas:** `flutter analyze --no-pub`, builds Linux debug/release y build web pasaron. El paquete Linux y la unidad quedaron copiados localmente; se creó el enlace de habilitación para la próxima sesión gráfica.
- **Límites:** Gradle no pudo iniciar por la restricción de sockets del entorno; ADB tampoco inicia y Flutter Test no puede abrir `127.0.0.1:0`. `systemctl --user` no pudo contactar el bus, así que el servicio no está arrancado en la sesión actual. Faltan compilación APK y recorrido físico de emparejamiento, acciones del aviso y sincronización.
- **Siguiente paso:** desde una terminal Omarchy sin ese bloqueo, ejecutar `systemctl --user daemon-reload && systemctl --user start nikucode-pausa.service`; después compilar/instalar Android y validar el recorrido en la misma WiFi.

### Ajuste de emparejamiento observado en el móvil

Una captura de Javi mostró `HandshakeException: Connection terminated during handshake` al pulsar Emparejar. La documentación de Android para `KeyGenParameterSpec.Builder` indica que las claves usadas por TLS suelen requerir `DIGEST_NONE`. Se creó una identidad TLS nueva con esa autorización y paddings RSA para TLS 1.2/1.3, y se agregó diagnóstico nativo `NikucodeLan` para el siguiente intento. **La causa sigue siendo una hipótesis hasta repetir la prueba física con el APK recompilado**; el código Dart volvió a pasar `flutter analyze --no-pub`.

## 2026-10-24 · Mi panorama semanal local

- **Tarea:** mostrar un histograma semanal de uso real de apps en Android, detalle del día seleccionado y conteos semanales de interacción con nikucode.
- **Archivos:** `app/lib/app_usage.dart`, `app/lib/interaction_history.dart`, `app/lib/marea_tools.dart`, `app/lib/pause_view_model.dart`, `app/lib/main.dart`, `app/android/app/src/main/AndroidManifest.xml`, `app/android/app/src/main/kotlin/cl/nikucode/nikucode_senales/MainActivity.kt`, pruebas y `app/README.md`.
- **Resultado local:** lectura bajo acceso especial de Android, consulta por semanas sin guardar el uso de otras apps, y seis conteos propios guardados por fecha con borrado explícito. La hoja conserva la apariencia Marea y muestra un estado cuando no hay acceso o cuando el destino no es Android.
- **Límite:** `flutter analyze --no-pub` pasó. La compilación APK se detuvo antes de compilar código porque Gradle no puede crear su servicio de red en este entorno. Flutter Test tampoco pudo cargar casos porque no puede abrir `127.0.0.1:0`. Falta comprobar compilación y datos reales en el teléfono. No hay commit ni publicación.
- **Siguiente paso:** detener `flutter run` y volver a iniciarlo por los cambios nativos; conceder acceso al uso desde «Mi panorama» y comparar la tendencia con los ajustes de Android.

No se registraron contribuciones en este archivo al preparar el repositorio. La investigación y los acuerdos previos constan en los documentos de referencia; registrar aquí los avances futuros de este integrante.

Para cada contribución, registrar pregunta/tarea, fuentes o archivos, resultado observado, límite y siguiente paso. Coordinar archivos antes de editarlos; el registro común de estado lo actualiza quien integra.
