# Integración OpenCode → Codex: estado de investigación y decisiones de nikucode

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Ampliación con la exportación completa:** [INTEGRACION_SESION_OPENCODE_COMPLETA_2026-10-22.md](INTEGRACION_SESION_OPENCODE_COMPLETA_2026-10-22.md). Añade trazabilidad de pruebas locales de Stretchly/Wakeout y análisis estático de Opal, y distingue la investigación visual iniciada de las lecturas efectivamente cerradas. Este documento conserva el resumen inicialmente aportado por el equipo.

## Aclaración de Makana con transcripción — 22-10-2026

La [transcripción de chat.mp3 aportada por Alex](ACLARACION_MAKANA_TRANSCRIPCION_2026-10-22.md) permite investigar, tener ideas de producto, llevar material escrito y preparar herramientas/dependencias. **El código de la app empieza después de terminar la presentación de bienvenida**, sin commits de desarrollo previos. El repositorio debe ser público; para nuestro flujo lo crearemos vacío durante el evento. Se permiten librerías open source, pero **no reutilizar desarrollo de otros proyectos personales**.

Esta precisión reemplaza restricciones históricas sobre investigar o llevar documentación y el resumen anterior que solo mencionaba repo/código. Marea es un ejercicio para aprender Flutter creado durante esta investigación, no un proyecto personal; la transcripción no resuelve expresamente la reutilización de su código. No clasificarlo como desarrollo personal prohibido ni afirmar una autorización específica no expresada. Las referencias antiguas a comenzar a las 09:00 quedan subordinadas al fin de la bienvenida. La elección de solución sigue dependiendo de la investigación.

**Trazabilidad:** se leyó la transcripción pegada por Alex; no se escuchó ni verificó aquí el audio. El documento vinculado conserva sus palabras y distingue la respuesta de nuestras decisiones prácticas.

**Fecha de integración:** 22 de octubre de 2026
**Fuente principal:** resumen de continuidad aportado por el equipo tras trabajar en OpenCode.
**Estado general:** base amplia de investigación; todavía no hay solución elegida ni eficacia propia demostrada.

## 1. Problema que se mantiene

Facilitar pausas físicas breves y voluntarias durante sesiones prolongadas de estudio/trabajo frente al computador, antes del dolor o agotamiento y sin convertir la pausa en otra obligación. No transformarlo en una aplicación genérica de productividad, un bloqueador de redes o un tratamiento clínico.

Barreras candidatas que deben permanecer como hipótesis, no como hechos medidos: olvidar/no advertir el tiempo; no querer perder el hilo de una tarea; no poder realizar el movimiento en ese momento; cansancio; y descansar usando otra pantalla.

## 2. Alternativas que siguen abiertas

- Invitación sencilla y voluntaria a pausar.
- Señal vinculada a una transición natural de tarea.
- Ayuda opcional para recordar el siguiente paso y retomar el hilo.
- Movimiento guiado o jugable.
- Gamificación, mascota y progreso.
- Microcontenido educativo.
- Señal física o cambio del entorno.
- Apoyo social/organizacional voluntario.
- Canales digitales posibles: web, extensión, plugin o aplicación nativa; ninguno elegido por evidencia suficiente aún.

**Corrección metodológica:** el marcador de reanudación y el juego son hipótesis distintas. Si se prueba el marcador, comparar la misma invitación a hacer una pausa con/sin marcador opcional. Si se prueba el juego, mantener iguales el movimiento y la invitación y cambiar solo la capa lúdica. No unir ambos en una primera prueba factorial improvisada.

## 3. Evidencia y resultados: distinguir niveles

No son equivalentes: aceptar la invitación → iniciar movimiento → completar una pausa → repetir la conducta → formar un hábito → mejorar salud. Clics, aperturas, engagement, pasos, minutos sedentarios, dolor y bienestar son resultados diferentes.

### Corrección crítica: Leppe-Zamora et al. (2025) en cuarentena cuantitativa

Referencia bibliográfica: https://doi.org/10.1186/s12966-025-01781-0.

Según la auditoría previa del equipo en OpenCode, se detectaron problemas en los agregados: (1) errores estándar de Swartz usados como desviaciones estándar, (2) orientación inconsistente de grupos según el resultado, y (3) tamaños muestrales de grupo incorrectos para el desenlace de pasos. El equipo reporta que reprodujo los agregados con esas entradas. Se suspenden los números previamente citados de −12,46 minutos y +1.030 pasos como estimaciones fiables hasta resolver las discrepancias usando tablas/datos originales.

Esta integración conserva el hallazgo reportado por el equipo, pero no afirma haber rehecho ese cálculo de forma independiente. No emplear esas cifras en pitches, documentos de decisión o argumentos de superioridad de los avisos digitales. Conservar el artículo en bibliografía para trazabilidad.

Mantener por separado:
- Parés-Salomón et al. (2024): intervenciones digitales multicomponente en trabajadores de oficina; el paquete no permite atribuir efecto a una pieza individual.
- Teuber et al. (2022), N=57 universitarios: mensajes motivacionales diarios no produjeron efecto estadísticamente significativo sobre pausas activas (p=0,42 según la revisión previa del equipo).
- Wafi et al. (2024), N=77 estudiantes de medicina: el cambio entre grupos en tiempo sedentario no fue significativo.
- HeartSteps/JITAI: algunos efectos próximos pueden ser favorables, pero no prueban aumento neto de actividad diaria ni superioridad general de la personalización frente a una señal sencilla.

## 4. Correcciones de competencia

Se revisaron documentalmente 14 competidores/sustitutos, sin instalar/probar las catorce aplicaciones:

- Wakeout anuncia pausas de movimiento/juegos corporales y una extensión de Chrome; además reporta más de 10 millones de “Wakeouts” completados. Eso no significa 10 millones de usuarios únicos ni eficacia/retención probadas.
- Stretchly ya ofrece recordatorios anticipados; Workrave ya trabaja pausas de escritorio.
- Forest incorpora funciones asociadas a descansos y foco.
- Wakeout es antecedente directo de micro-movimiento lúdico; por tanto, «pausas breves», «avisar antes» o «hacerlo con juego» no son por sí solos diferenciadores suficientes.
- No se verificaron métricas públicas independientes y comparables de retención D1/D7/D30/churn para esas aplicaciones individuales.

La diferencia potencial sigue como hipótesis: resolver una fricción específica (p. ej., transición/retorno al trabajo sin culpa) de modo más adecuado para el contexto descrito, si las pruebas muestran que esa barrera importa. No presentarla como diferenciador validado.

## 5. Estado de revisión de fuentes

- 19 de 24 fichas críticas reportadas como completadas.
- Cinco fuentes originales siguen bloqueadas/no disponibles en la revisión anterior: Leroy/Glomb, Bahnsen, Feil, O’Brien y Rouyard.
- Se recuperaron 22 anexos; no se reanalizaron exhaustivamente todos los cálculos suplementarios.
- La revisión añadida sobre TikTok y “ganchos” está parcialmente contrastada y todavía necesita integración documental completa.
- Correcciones reportadas en ese frente: Aldenaini reúne 170 trabajos, no 80; el 76 % no demuestra eficacia aislada de recompensas variables; McDonough no encontró reducción significativa del sedentarismo; Roberts/David trató telepresencia relacionada con ansiedad/depresión; Jaafar es piloto pre-post, no RCT causal; Mamede no aisló un “gancho compulsivo” como ingrediente causal.

No usar las afirmaciones de este apartado como si este documento hubiera reabierto cada fuente primaria: constituye un registro del estado de la auditoría anterior y de lo que aún falta completar.

## 6. Preparación técnica

Resumen informado por el equipo:
- Flutter pasó análisis, un test y compilaciones para Linux/web en el proyecto/laboratorio llamado Marea.
- Se probaron tres avisos visibles con respuesta por clic en Omarchy, con «No molestar» desactivado.
- Un laboratorio Flutter independiente compila, pero aún no se confirmó su funcionamiento gráfico de extremo a extremo.
- Se instaló el plugin oficial Dart/Flutter de Codex y se crearon tres skills de investigación/revisión de evidencia/competencia. Su utilidad real aún debe evaluarse.

Antes de reutilizar código de Marea/laboratorios, verificar que se trata de práctica técnica neutral y no trasladar código de solución competitiva que no esté permitido. No escoger Flutter solo porque el entorno ya esté preparado; la necesidad del producto sigue abierta.

## 7. Próxima secuencia de decisión

1. **Depurar afirmaciones de evidencia:** mantener en cuarentena las cifras Leppe-Zamora; conservar resultados nulos y separar evidencia directa de analogías.
2. **Matriz de alternativas:** comparar opciones digitales, físicas, ambientales y organizativas según mecanismo, coste, fricción, riesgos y calidad de evidencia.
3. **Diagnóstico mínimo de episodios:** centrarse en una ocasión reciente, qué impidió pausar y qué hubiera sido viable; no preguntar solo “qué app te gustaría”.
4. **Elegir una incertidumbre principal:** no probar a la vez recordatorio, marcador, estética y gamificación.
5. **Predefinir criterio de decisión:** comprensión, facilidad, autonomía, interferencia y acción observable pertinente; no equiparar aceptación con eficacia.
6. **MVP solo después de decidir barrera y canal:** usar la solución técnica más simple que permita probar el mecanismo elegido.

## 8. Guardarraíles de interpretación

- No hay solución validada.
- No hay prueba de que el marcador de reanudación aumente pausas físicas.
- No hay prueba de que añadir juego sea superior al mismo movimiento sin juego.
- No presentar popularidad de competidores como retención ni como eficacia.
- No afirmar prevención de dolor, cambio de hábito duradero o eficacia clínica por una demo.
- No optimizar dependencia psicológica ni minutos dentro del producto como resultado principal.
