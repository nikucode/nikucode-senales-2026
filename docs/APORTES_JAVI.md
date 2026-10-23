# Aportes de Javi

Sin resultados nuevos registrados aquí al preparar el repositorio. La investigación previa está en los documentos importados.

Por bloque: fecha/hora, pregunta/tarea, fuentes o archivos, resultado observado, límite, decisión propuesta y siguiente paso. Coordinar archivos antes de editar; el integrador actualiza registros comunes.

## 2026-10-23 10:42 -03 · Arranque y lectura mínima

- **Pregunta/tarea:** sincronizar el repositorio, comprobar el estado local y seguir la lectura mínima antes de elegir implementación.
- **Fuentes o archivos:** `AGENTS.md`, `README.md`, `docs/ESTADO_COMPARTIDO.md`, `docs/ARRANQUE_JAVI.md`, §§1–5 y 7 de `docs/GUIA_IMPLEMENTACION_Y_ACEPTACION_2026-10-23.md`, y §§1–5 de `docs/PREPARACION_TECNICA_DESTINOS_2026-10-23.md`.
- **Resultado observado:** clon local limpio y sincronizado con `origin/main` en `351c267`; la documentación ampliada está disponible. El núcleo requerido es un recorrido autónomo en computador y celular, con una sola invitación local por dispositivo, control para cambiar/posponer/rechazar/detener y estados del canal que no prometan entregas no comprobadas. No existe todavía app ni scaffold en el repositorio.
- **Límite:** stack, dispositivos/sistemas reales y reparto de archivos con Alex siguen sin confirmarse. No se ejecutó una app ni se probó el canal de avisos; por tanto, no hay evidencia de entrega fuera de primer plano ni de movimiento corporal.
- **Decisión propuesta:** acordar primero el inventario genérico de computador/celular y el reparto. Como bloque pequeño para Javi, tomar la comprobación técnica inicial: arranque mínimo en ambos destinos y prueba de programar, recibir, abrir, posponer y cancelar una señal, trabajando en archivos propios una vez definido el stack.
- **Siguiente paso:** confirmar con Alex el stack, los dispositivos de demo y la responsabilidad de archivos; después registrar versiones sin identificadores personales y ejecutar la prueba vertical antes de ampliar pantallas.

## 2026-10-23 11:06 -03 · Inventario técnico inicial

- **Pregunta/tarea:** comprobar si el computador local permite una ruta Flutter nativa para computador y Android, sin crear todavía el scaffold.
- **Fuentes o archivos:** sistema local, `flutter doctor -v` y consulta sanitizada de `adb devices`; confirmación de Javi sobre disponibilidad de un Android con depuración USB.
- **Resultado observado:** computador Omarchy x86_64; Flutter estable 3.47.7 y Dart 3.13.5 disponibles. `flutter doctor -v` aprobó los toolchains de Android (SDK 36.0.0) y Linux. Javi confirmó que habrá un celular Android real conectable por USB.
- **Límite:** ADB no detectó todavía un teléfono autorizado, no se creó ni compiló una app y no se probó ninguna notificación. Flutter Doctor no encontró Chrome, pero eso no bloquea por sí mismo la ruta nativa Linux + Android. El stack y reparto aún requieren acuerdo con Alex.
- **Decisión propuesta:** usar Flutter como candidata prioritaria para compartir interfaz y reglas, con integración de señal comprobada por separado en Linux y Android.
- **Siguiente paso:** conectar y autorizar el Android, confirmar la selección y los archivos con Alex, y solo entonces crear/ejecutar el recorrido vertical mínimo en ambos destinos.

## 2026-10-23 · Investigación de diseño y bienestar emocional

- **Pregunta/tarea:** estudiar la relación entre apariencia de interfaces, confort percibido y salud mental para orientar el diseño móvil.
- **Fuentes o archivos:** documentación visual y auditoría existentes; Perrig et al. (2023), Denison-Day et al. (2023), Elliot (2015), Garrido et al. (2024), Jonauskaite y Mohr (2025), Valentine et al. (2025), Inal et al. (2020) y WCAG 2.2. Síntesis completa en `docs/INVESTIGACION_DISENO_CONFORT_Y_BIENESTAR_2026-10-23.md`.
- **Resultado observado:** la evidencia respalda priorizar simplicidad, acabado cuidado, legibilidad, previsibilidad y control porque influyen en facilidad, confianza y aceptación percibidas. No respalda una paleta universalmente calmante ni permite inferir mejora de salud mental desde la estética. La cantidad de recursos persuasivos tampoco mostró relación significativa con eficacia o finalización en el metaanálisis revisado.
- **Límite:** revisión narrativa dirigida, no sistemática; gran parte de la evidencia es indirecta para una app de pausas. No se probaron todavía prototipos ni se observaron efectos emocionales propios.
- **Decisión propuesta:** conservar una dirección cálida y sobria como hipótesis, sin mascota, rachas o presión; comparar una variante neutra y otra cálida manteniendo idéntico flujo y contenido.
- **Siguiente paso:** producir las dos variantes móviles y ejecutar una prueba exploratoria de tareas, presión, intrusión y confort con 5–8 personas, sin datos identificables ni afirmaciones clínicas.

## 2026-10-23 12:14 -03 · Adopción, autocompasión y dolor

- **Pregunta/tarea:** responder cómo atraer a una persona, motivar una primera prueba y explorar autocompasión, concientización del dolor y consecuencias del sedentarismo desde un tono tierno.
- **Fuentes o archivos:** Biber y Ellis (2019), Zhang et al. (2025), Tannenbaum et al. (2015), Rossettini et al. (2018), Borghouts et al. (2021), Adnan et al. (2025) y documentación científica vigente del proyecto. Síntesis en `docs/ESTRATEGIA_ADOPCION_AUTOCOMPASION_2026-10-23.md`.
- **Resultado observado:** la autocompasión tiene evidencia preliminar como recurso de autorregulación y puede actuar mediante autoeficacia ante barreras, pero no se demostró que un mensaje tierno reduzca sedentarismo. Los mensajes de riesgo requieren capacidad de acción y no justifican alarmismo; en dolor, el lenguaje amenazante presenta riesgo de expectativas negativas. Para aceptación también importan utilidad, facilidad, confianza y privacidad.
- **Límite:** evidencia indirecta y heterogénea; no hay prueba propia de descarga, instalación, primera pausa o retorno. El caso del equipo no representa prevalencia poblacional y la app no es tratamiento de dolor o salud mental.
- **Decisión propuesta:** empatizar con la dificultad de interrumpir, no intensificar el dolor; combinar validación breve con una acción viable y control explícito. Permitir probar una pausa antes de pedir descarga y separar reconocimiento, prueba, instalación y retorno.
- **Siguiente paso:** comparar un mensaje de consecuencia cercana con otro de autocompasión más capacidad, manteniendo estética y CTA constantes; registrar comprensión, juicio, presión, confianza, prueba e intención posterior sin generalizar una muestra pequeña.
