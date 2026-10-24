# Registro de contribuciones · Javier González

## 2026-10-24 · Una señal en Android y Omarchy

- **Tarea:** al elegir «Probar señal en 10 segundos» en Android, recibir la misma invitación en el móvil y Omarchy.
- **Cambio local:** el control de avisos de Android programa una única hora en la cola LAN y en el servicio nativo del móvil. Omarchy recibe esa hora, muestra el mismo título y texto, y puede posponer la siguiente señal en ambos equipos. Cancelar o reemplazar desde Android retira la programación anterior de los dos lados. Los controles LAN de intervalos separados desaparecieron de la interfaz.
- **Comprobación:** `flutter analyze --no-pub`, compilación Linux release, compilación aislada de Kotlin y `git diff --check` pasaron. Se agregó una prueba del modelo para la señal compartida y su cancelación, pero Flutter Test no pudo iniciarse porque este entorno no permite abrir su socket local.
- **Pendiente en dispositivos:** reinstalar Android, actualizar el servicio Linux y observar el aviso de 10 segundos en ambos. Los cambios no se subieron a Git.
- **Clic en Omarchy:** se añadió la acción `default` a la notificación Linux. El clic en su tarjeta abre la ventana y muestra la propuesta de pausa, igual que «Iniciar pausa». El análisis Flutter y la compilación Linux release pasaron; falta comprobar el clic en la sesión gráfica real tras reinstalar el complemento.

## 2026-10-24 · Corrección del handshake TLS Android–Omarchy

- **Evidencia física:** Avahi publicó la solicitud dirigida al identificador correcto de Omarchy; el servicio Linux registró `HandshakeException: Connection terminated during handshake`. El logcat del móvil mostró `RSA routines:OPENSSL_internal:internal error` dentro de Conscrypt durante `SSLServerSocket.startHandshake()`.
- **Causa y cambio:** la clave RSA v2 de AndroidKeystore autorizaba firma, pero no `ENCRYPTION_PADDING_NONE`. [La documentación de Android](https://developer.android.com/reference/android/security/keystore/KeyGenParameterSpec.Builder#setEncryptionPaddings(java.lang.String...)) y [un caso de Conscrypt con el mismo error](https://github.com/google/conscrypt/issues/718) indican que esta autorización se requiere para la operación RSA del handshake. La nueva identidad v3 la incluye. Se mantiene la identidad v2 si ya existe una credencial emparejada; una instalación todavía sin emparejar crea v3 y retira la clave fallida.
- **Comprobación y límite:** los archivos Kotlin compilaron por separado con Android API 36, Flutter embedding y el compilador 2.2.21 en caché. Falta reinstalar el APK y repetir el emparejamiento físico; esta compilación no equivale a un build APK. Los cambios siguen locales.

## 2026-10-24 · Diagnóstico del emparejamiento en Omarchy

- **Observado en el equipo:** Android publicó la solicitud temporal por Avahi con `target` igual al identificador local de Omarchy y un `nonce` de 32 caracteres. El anuncio ya llega por IPv4, pero aún no se ha confirmado la conexión TLS ni el emparejamiento.
- **Ajuste local:** Linux espera hasta 6 segundos por la resolución de Avahi y registra en el journal los errores de conexión. El instalador prepara el paquete completo en un directorio nuevo, detiene el servicio y cambia de versión conservando los archivos anteriores para ventanas aún abiertas. El journal había mostrado cierres `SIGBUS` durante las actualizaciones del paquete; copiar una biblioteca mapeada mientras el proceso sigue activo es una causa probable, todavía no confirmada por el core.
- **Comprobación:** `flutter analyze --no-pub`, `flutter build linux --release --no-pub`, `bash -n linux/install-companion.sh` y `git diff --check` pasaron. Falta repetir el emparejamiento con el servicio Linux actualizado y revisar su journal si vuelve a fallar. Los cambios siguen locales.

## 2026-10-24 · Emparejamiento local inspirado en Flux

- **Tarea:** sustituir IP/puerto/PIN manuales por descubrimiento de Omarchy desde Android, clave de comparación en ambas pantallas y reconexión sin repetir el emparejamiento.
- **Implementación local:** Avahi anuncia el computador; NSD lo descubre en Android. Una solicitud dirigida al identificador del computador hace que Linux abra TLS hacia el móvil. Ambos calculan una clave de 16 caracteres para esa conexión y confirman antes de guardar la credencial. El cliente Linux fija el certificado y consulta el puerto anunciado; la ventana y el servicio comparten estado por socket Unix privado. Android mueve su servidor y cola a un servicio de primer plano `connectedDevice`, con aviso persistente, migración de solicitudes previas y resultados para Mi panorama al abrir la app. Se conservaron las credenciales previas.
- **Comprobaciones observadas:** `flutter analyze --no-pub` y la compilación Linux debug pasaron; un comprobador Dart de anuncios Avahi pasó. Los archivos Kotlin compilaron de forma independiente con un compilador en caché, Android API 36 y el embedding Flutter; esta comprobación no equivale a generar un APK.
- **Límites:** Gradle sigue sin iniciar por la restricción de sockets del entorno; Flutter Test y ADB tampoco pueden abrir sus sockets. No se ha ejecutado el nuevo flujo en el teléfono ni se ha observado una pausa con la pantalla Android cerrada. Falta verificar NSD, Avahi, el aviso de primer plano y la restauración tras reinicio en los dispositivos reales.
- **Estado Git:** cambios nuevos locales sobre `javi/panorama-pausas-locales`; no se han publicado.

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
