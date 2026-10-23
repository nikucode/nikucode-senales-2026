# Investigación: diseño persuasivo, uso problemático y gamificación ética

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Proyecto:** Hackatón Señales de Makana · Equipo nikucode
**Fecha de actualización:** 18 de octubre de 2026
**Propósito:** evaluar con fuentes verificables si los mecanismos que mantienen a las personas usando plataformas digitales pueden inspirar una intervención beneficiosa para facilitar pausas físicas, sin copiar patrones manipuladores ni intentar crear dependencia.

> **Conclusión ejecutiva:** Es viable aprovechar conocimientos de psicología del comportamiento, diseño persuasivo y juegos para facilitar una conducta saludable. No es recomendable definir como objetivo crear «adicción» o dependencia hacia la aplicación. La evidencia indica que el diseño puede modificar la interacción y que la gamificación puede mejorar ligeramente algunos resultados de actividad física, pero un uso más frecuente no garantiza un mayor beneficio para la persona. La dirección defendible es diseñar para una conducta valiosa, autonomía y facilidad de retorno, no para maximizar el tiempo dentro del producto.

## 1. Pregunta de investigación

¿Podemos aprovechar mecanismos que hacen atractivas y fáciles de repetir algunas experiencias digitales —señales, recompensas inmediatas, retroalimentación, narrativa, progresión y baja fricción— para facilitar pausas físicas breves antes del dolor o el agotamiento, sin fomentar uso compulsivo, culpa, vigilancia ni dependencia innecesaria de la pantalla?

La pregunta tiene dos partes distintas:

1. **Viabilidad conductual:** ¿qué mecanismos podrían ayudar a iniciar y repetir una pausa en un contexto de estudio, programación, tareas y descanso digital?
2. **Viabilidad ética:** ¿podemos lograrlo sin reproducir los daños que nos preocupan en plataformas diseñadas para maximizar la atención?

No debemos asumir que el mismo diseño que retiene a alguien en un feed sirve para cambiar una conducta de salud. Cambian el objetivo, las consecuencias, el contexto y los criterios de éxito.

## 2. Vocabulario: qué significa cada concepto

| Término | Uso en esta investigación | Qué no significa automáticamente |
|---|---|---|
| **Diseño persuasivo** | Diseño que intenta influir en una decisión o conducta mediante información, señales, opciones, retroalimentación o contexto. | No es sinónimo de manipulación; importa la transparencia, la autonomía y el interés que sirve. |
| **Gamificación** | Uso de elementos de juego —progreso, retos, narrativa, feedback, colaboración— en una actividad que no es un juego. | No demuestra eficacia por sí sola ni requiere puntos, rachas o premios aleatorios. |
| **Hábito** | Conducta que se vuelve más automática al repetirse en contextos o ante señales relativamente estables. | No es necesariamente una adicción ni requiere una app. |
| **Uso problemático de redes sociales** | Patrón de uso que interfiere con bienestar o funcionamiento, tal como se define operativamente en un estudio. | No se puede diagnosticar solo por las horas de uso ni hay una definición única universal. |
| **Adicción a redes sociales** | Expresión usada en investigación, debate público y litigios para describir algunos patrones compulsivos. | No es, a octubre de 2026, un diagnóstico independiente reconocido oficialmente por DSM-5-TR o ICD-11. |
| **Dependencia** | En conversación cotidiana puede significar que algo resulta necesario para iniciar una acción; en salud puede tener significados clínicos específicos. | No equivale automáticamente a un hábito saludable. Una intervención que solo funciona mientras la persona necesita la app puede estar creando dependencia funcional innecesaria. |
| **Compromiso / engagement** | Cualquier indicador de interacción: aperturas, sesiones, respuesta, uso repetido, etc. | No equivale a beneficio, salud, satisfacción ni cambio de conducta. |

La Organización Mundial de la Salud reconoce el **trastorno por videojuegos** en la ICD-11 cuando existe pérdida de control, prioridad creciente del juego frente a otras actividades y continuación pese a consecuencias negativas, con deterioro significativo del funcionamiento. Eso no implica que toda persona que juega mucho tenga un trastorno ni permite trasladar el diagnóstico automáticamente a redes sociales. La Asociación Estadounidense de Psiquiatría indica que las «adicciones tecnológicas» no figuran como diagnósticos en el DSM-5-TR; el trastorno por videojuegos aparece como condición para mayor estudio. Fuentes: [OMS: Gaming disorder](https://www.who.int/news-room/questions-and-answers/item/addictive-behaviours-gaming-disorder); [APA: What is Technology Addiction?](https://www.psychiatry.org/patients-families/technology-addictions-social-media-and-more/what-is-technology-addiction).

**Implicación:** el informe usará principalmente «uso problemático», «diseño adictivo alegado», «patrones compulsivos» o «síntomas adictivos» cuando corresponda. No afirmará que una plataforma produce adicción clínica a todas las personas.

## 3. Evidencia científica y estadística principal

### 3.1. Metaanálisis de vídeos cortos: cognición y salud mental

**Nguyen, L. et al. (2025).** *Feeds, feelings, and focus: A systematic review and meta-analysis examining the cognitive and mental health correlates of short-form video use*. **Psychological Bulletin, 151**(9), 1125–1146. DOI: [10.1037/bul0000498](https://doi.org/10.1037/bul0000498). Registro: [PubMed](https://pubmed.ncbi.nlm.nih.gov/41231585/).

- Sintetizó **71 estudios con 98.299 participantes**.
- Mayor uso de vídeos cortos se asoció con peor desempeño cognitivo: correlación promedio aproximada **r = −0,34**.
- Las asociaciones fueron más fuertes para atención (**r ≈ −0,38**) y control inhibitorio (**r ≈ −0,41**).
- La asociación agrupada con indicadores de peor salud mental fue menor, aproximadamente **r = −0,21**, y varió según el resultado analizado.
- Los autores describen asociaciones, no prueban que ver vídeos cortos cause por sí solo una reducción de la atención o trastornos emocionales. Buena parte de los estudios incluidos son observacionales y usan medidas de autoinforme; pueden existir causalidad inversa y variables de confusión.

**Qué permite concluir:** existe una señal científica consistente que justifica estudiar el uso problemático o intenso de vídeos cortos y su relación con control atencional y bienestar.

**Qué no permite concluir:** que todas las personas tengan una atención máxima de seis u ocho segundos; que los Reels hayan «destruido» la capacidad de atención; que la duración de cada vídeo cause por sí sola las asociaciones; ni que nuestro prototipo tenga que imitar el ritmo o la recompensa de los feeds.

### 3.2. Estudio EEG sobre vídeo corto: interesante, pero pequeño

**Yan, S. et al. (2024).** *Mobile phone short video use negatively impacts attention functions: an EEG study*. *Frontiers in Human Neuroscience*. DOI: [10.3389/fnhum.2024.1383913](https://doi.org/10.3389/fnhum.2024.1383913). [PubMed](https://pubmed.ncbi.nlm.nih.gov/38993329/).

- Estudio con **48 participantes**, edad media de **21,8 años**.
- La tendencia a un uso adictivo de vídeos cortos se correlacionó con un indicador EEG de control ejecutivo durante una tarea de atención (**r = −0,395; p = 0,007**) y con la puntuación de autocontrol (**r = −0,320; p = 0,026**).
- No se observó la misma correlación en el indicador EEG registrado en reposo.

**Limitación central:** tamaño pequeño y diseño correlacional. El estudio no establece qué ocurrió primero ni permite generalizar a toda la población. Es complemento, no sustituto, del metaanálisis anterior.

### 3.3. Uso problemático de redes: riesgo y bienestar no son una historia única

**Pazdur, M., Tutus, D. & Haag, A.-C. (2025).** *Risk Factors for Problematic Social Media Use in Youth: A Systematic Review of Longitudinal Studies*. *Adolescent Research Review*. DOI: [10.1007/s40894-025-00264-4](https://doi.org/10.1007/s40894-025-00264-4).

- Incluyó **23 estudios longitudinales** sobre factores asociados con el desarrollo de uso problemático de redes sociales en jóvenes.
- Los síntomas emocionales —incluidos depresión, ansiedad, estrés y emociones negativas— aparecen como posibles factores de riesgo en parte de la literatura. Esto respalda la posibilidad de relaciones en ambas direcciones: el malestar puede promover el uso de redes para afrontarlo y ciertos patrones de uso también pueden asociarse con resultados negativos.
- La revisión subraya problemas de definiciones inconsistentes, medidas no estandarizadas y dependencia del autoinforme.
- El tiempo o la frecuencia de uso, aislados de los motivos, el contenido y el contexto, no bastan para clasificar el uso como perjudicial. Las redes también pueden brindar conexión social, apoyo, creatividad y alivio momentáneo.

**Aplicación a nikucode:** es razonable explorar si el celular o el juego funciona a veces como vía de desconexión cuando hay agotamiento o tareas difíciles. No debemos asumirlo como diagnóstico ni describir todo descanso digital como dañino.

### 3.4. Gamificación en apps de salud: efecto promedio pequeño, medido en ensayos

**Nishi, S. K. et al. (2024).** *Effect of digital health applications with or without gamification on physical activity and cardiometabolic risk factors: a systematic review and meta-analysis of randomized controlled trials*. *EClinicalMedicine, 76*, 102798. DOI: [10.1016/j.eclinm.2024.102798](https://doi.org/10.1016/j.eclinm.2024.102798). [PubMed](https://pubmed.ncbi.nlm.nih.gov/39764571/).

- Incluyó **36 ensayos (49 comparaciones), con 10.079 participantes**; principalmente intervenciones sobre actividad física o pérdida de peso, de al menos ocho semanas.
- Frente a intervenciones sin gamificación, las apps gamificadas se asociaron con aproximadamente **489 pasos adicionales por día** (IC 95 % 64 a 914; evidencia de alta certeza para ese resultado), un cambio de **−0,28 kg/m² en IMC** (IC 95 % −0,44 a −0,12), **−0,70 kg de peso** (IC 95 % −1,18 a −0,22), **−1,92 puntos porcentuales de grasa corporal** (IC 95 % −2,71 a −1,14) y **−1,16 cm de cintura** (IC 95 % −1,93 a −0,39). No hubo diferencias claras para otros resultados.
- Los propios autores caracterizan los efectos globales sobre actividad física y adiposidad como pequeños o modestos.

**Aplicación:** elementos de juego pueden aportar algo frente a una versión no gamificada, pero no justifican diseñar un sistema compulsivo. Los resultados son de intervenciones sanitarias más largas, no una predicción de lo que conseguirá una demo de hackatón ni una prueba directa sobre pausas durante el estudio.

### 3.5. Diseño persuasivo para salud mental y conductual: el campo todavía tiene vacíos

**Idrees, A. R. et al. (2024).** *Persuasive technologies design for mental and behavioral health platforms: A scoping literature review*. *PLOS Digital Health*. DOI: [10.1371/journal.pdig.0000498](https://doi.org/10.1371/journal.pdig.0000498).

- Revisión de alcance que buscó en ocho bases de datos e incluyó **161 artículos**.
- Identificó **15 marcos o metodologías** de diseño persuasivo y estudió **146 aplicaciones** en áreas de salud y conducta.
- Halló escasez de comparaciones directas entre técnicas, adaptación a necesidades diversas y evaluación clara de cómo componentes específicos afectan la experiencia. La evidencia sobre riesgos de explotación y consecuencias negativas de la persuasión también era limitada.
- Describe mecanismos como señales oportunas, apoyo para retomar una tarea, compromiso gradual, feedback y gamificación; advierte que notificaciones, recompensas sociales y otros componentes también pueden fomentar uso repetitivo y plantear riesgos.

**Aplicación:** no hay un botón de «persuasión eficaz» que podamos copiar de una red social. Es necesario comparar alternativas concretas y comprobar qué cambia en el resultado objetivo.

### 3.6. Gamificación en salud mental digital: engagement no equivale a eficacia

**Ngabo-Woods, H., Dunai, L., Seguí Verdú, I. & Tîrșu, V. (2026).** *Gamification in Digital Mental Health Interventions: A Systematic Review of the Engagement–Efficacy–Ethics Trilemma*. *Information, 17*(2), 168. DOI: [10.3390/info17020168](https://doi.org/10.3390/info17020168).

- La revisión declara haber sintetizado **50 estudios** publicados entre 2015 y 2025.
- **22 de 50** planteaban preocupaciones éticas críticas; **35 de 50** usaban motivadores extrínsecos, como recompensas o seguimiento de progreso, según la codificación de los autores.
- Propone un marco útil de tres objetivos en tensión: **compromiso**, **eficacia** y **ética**. Aumentar la actividad dentro de la aplicación no garantiza mejores resultados clínicos y puede coexistir con riesgos de ansiedad, presión, comparación social o privacidad.
- Es una revisión reciente y su «trilema» es el marco conceptual de los autores, no una ley universal demostrada en todos los productos. Utilizarla como orientación crítica y contrastarla con ensayos y metaanálisis.

**Aplicación:** medir cuánto se usa el producto solo es una métrica de interacción. Para este proyecto, una aplicación que hace una buena pausa y luego permite volver al trabajo —o que deja de ser necesaria— puede ser más exitosa que una que maximiza el tiempo de uso.

## 4. ¿Es científicamente correcto decir «adicción a las redes sociales»?

Hay evidencia científica de patrones problemáticos o compulsivos de uso de redes, y existen propuestas académicas para clasificarlos como un trastorno. Sin embargo, a fecha de este informe, **«adicción a redes sociales» no es un diagnóstico independiente formalmente incluido en el DSM-5-TR o la ICD-11**. La revisión longitudinal de jóvenes destaca que la definición y la forma de medir el fenómeno varían entre estudios.

La OMS reconoce específicamente el trastorno por videojuegos en la ICD-11, definido por pérdida de control, prioridad del juego frente a actividades y continuidad pese a consecuencias negativas, con deterioro significativo del funcionamiento. El hecho de que esa categoría esté reconocida no permite equiparar todos los usos intensos de redes, vídeos o juegos a un trastorno.

Para comunicarlo con precisión:

- Adecuado: «Hay estudios sobre uso problemático de redes sociales y señales de uso compulsivo; la calidad, definición y causalidad de la evidencia varían».
- Adecuado: «Algunos diseños pueden facilitar la continuación de uso al retirar señales naturales de cierre o hacer que el siguiente contenido se reproduzca automáticamente».
- No adecuado: «Las redes causan adicción en todos sus usuarios».
- No adecuado: «Toda persona que usa redes para desconectar tiene una adicción».
- No adecuado: «La atención humana ahora dura solo seis segundos».

## 5. Situación legal y regulatoria: casos reales, sin confundir alegaciones con ciencia

### 5.1. Fallo civil en California, marzo de 2026

Reuters informó que el 25 de marzo de 2026 un jurado de Los Ángeles encontró negligentes a Meta y Google en el diseño de Instagram y YouTube en un caso individual sobre daño a una joven usuaria, otorgando **US$6 millones** en daños: US$4,2 millones atribuibles a Meta y US$1,8 millones a Google. La demanda se enfocó en diseño de producto —incluido el scroll infinito— y advertencias, no simplemente en el contenido publicado. Meta y Google anunciaron apelaciones. [Reuters, 25-03-2026](https://www.reuters.com/legal/litigation/jury-reaches-verdict-meta-google-trial-social-media-addiction-2026-03-25/).

Este veredicto es un hallazgo jurídico en una causa concreta, no un ensayo científico ni una demostración de que cada función por sí misma cause daño a todos los usuarios. El estado de las apelaciones debe verificarse si el dato se usa públicamente más adelante.

### 5.2. Acuerdo de Meta con estados de EE. UU., agosto de 2026

Reuters informó el 26–28 de agosto de 2026 que Meta acordó un conjunto de acuerdos con casi todos los estados de EE. UU. para resolver reclamaciones sobre el diseño de Facebook e Instagram y los daños alegados a menores. El medio informó de pagos de hasta **US$18.000 millones durante una década**, de los que aproximadamente US$12.700 millones serían pagos garantizados y el resto contingente a protecciones similares de otras plataformas. El acuerdo, según Reuters, fue aprobado por el juez federal que supervisaba el juicio. Meta negó haber actuado mal.

Los términos reportados incluyen limitar el uso de adolescentes a dos horas al día, bloquearlo de medianoche a las 06:00 salvo consentimiento parental y desactivar la mayoría de las notificaciones durante el horario escolar. Fuente: [Reuters, 26-08-2026, actualización 28-08-2026](https://www.reuters.com/business/meta-reaches-18-billion-settlements-over-childrens-social-media-addiction-2026-08-26/).

**Precaución:** es un acuerdo regulatorio/civil bajo el derecho estadounidense, no se aplica automáticamente en Chile y no significa que Meta haya admitido responsabilidad; Reuters reportó que la compañía negó haber cometido infracciones. Distinguir siempre un acuerdo de un veredicto y ambos de una conclusión científica.

### 5.3. Comisión Europea y TikTok, febrero de 2026

El 6 de febrero de 2026, la Comisión Europea anunció una **conclusión preliminar** de que funciones de diseño de TikTok —scroll infinito, reproducción automática, notificaciones push y recomendador personalizado— incumplirían la Ley de Servicios Digitales debido a la evaluación insuficiente de riesgos asociados al diseño adictivo. La Comisión citó la recompensa continua de nuevo contenido y el modo automático como mecanismos de riesgo. Fuente: [Comisión Europea](https://digital-strategy.ec.europa.eu/en/news/commission-preliminarily-finds-tiktoks-addictive-design-breach-digital-services-act).

Esto respalda que el diseño de producto y sus medidas de seguridad son objeto de regulación, pero hay que llamarlo «hallazgo preliminar» y no presentar la investigación como sentencia definitiva.

### 5.4. Restricciones de cuentas adolescentes en Instagram

Meta anunció Teen Accounts en septiembre de 2024, con protecciones predeterminadas para adolescentes, ajustes estrictos de mensajería y contenido, recordatorio de salir después de 60 minutos al día y modo sueño entre 22:00 y 07:00. En abril de 2025 amplió controles que exigen permiso parental a menores de 16 años para desactivar determinadas protecciones y acceder a Live. En junio de 2026 anunció ajustes de contenido clasificado como apto para mayores de 13 años, verificaciones de edad mediante IA y alertas parentales para determinados patrones de búsqueda de autolesiones.

Fuentes: [Meta, 17-09-2024](https://about.fb.com/news/2024/09/instagram-teen-accounts/); [Meta, 08-04-2025](https://about.fb.com/news/2025/04/introducing-new-built-in-restrictions-instagram-teen-accounts-expanding-facebook-messenger/); [Meta, 17-06-2026](https://about.fb.com/news/2026/06/strengthening-teen-accounts-with-new-safety-updates-on-instagram-and-facebook/).

Estas son comunicaciones de la empresa sobre sus propias medidas. Las cifras de aceptación que Meta atribuye a sus encuestas o la existencia de las protecciones no prueban por sí solas que las medidas mejoren los resultados de salud mental; para eso necesitaríamos evaluaciones independientes.

## 6. La cifra viral de los «seis» u «ocho segundos» de atención

No se debe usar como hecho la afirmación de que la capacidad humana de atención es de seis u ocho segundos. La cifra viral de ocho segundos —menor que los nueve segundos supuestamente atribuibles a un pez dorado— fue repetida en medios a partir de un informe de consumo de Microsoft Canada de 2015, pero no procede de una investigación identificable que hubiera medido una «duración promedio de la atención» en esa unidad. En 2017 la BBC rastreó las fuentes citadas y no logró encontrar el estudio original; especialistas también señalaron que atención es un conjunto de procesos que depende de la tarea y del contexto. Fuente: [BBC, «Busting the attention span myth», 10-03-2017](https://www.bbc.com/news/health-38896790) y resumen [BBC Learning English](https://downloads.bbc.co.uk/learningenglish/features/6min/170518_6min_english_attention_span.pdf).

Existe una medida distinta que se confunde con esa cifra: la investigadora Gloria Mark ha descrito observaciones del tiempo que trabajadores de información permanecen en un contenido de pantalla antes de cambiar a otro. Su promedio reportado de aproximadamente 47 segundos es una medición de cambio de pantalla en contextos laborales, **no un límite biológico de la atención humana**. Fuente de entrevista con la investigadora: [Steelcase, transcripción](https://www.steelcase.com/research/articles/our-47-second-attention-span-with-gloria-mark-s5-ep3-transcript/).

La evidencia sí justifica estudiar la distracción, la multitarea y el uso de vídeos cortos. Pero para nuestro producto es mejor diseñar para una transición fácil, una invitación clara y una interacción breve que concluir falsamente que «nadie puede concentrarse durante más de seis segundos».

## 7. ¿Podemos usar una «adicción positiva»?

### Respuesta

**Podemos usar mecanismos persuasivos para facilitar una conducta beneficiosa; diseñar deliberadamente una dependencia o compulsión no es un objetivo defendible.** La distinción no depende de que el propósito sea bueno. Una herramienta de bienestar puede perjudicar si induce ansiedad, culpa, pérdida de control, chequeo excesivo o si sustituye la autonomía por obediencia a una app.

Es más preciso proponer una **experiencia atractiva, fácil de repetir, con recompensas claras y salida fácil**, que intentar imitar la adicción de un feed. La finalidad debe ser ayudar a moverse; el uso de la aplicación es solo un medio. Un éxito plausible puede ser que con el tiempo la persona ya no necesite abrirla.

### 7.1. Mecanismos que conviene investigar

| Mecanismo | Cómo puede ayudar | Riesgo al aplicarlo mal | Versión ética a explorar |
|---|---|---|---|
| Señal/cue en el momento adecuado | Hace presente una oportunidad de acción que podría olvidarse. | Interrumpir tareas críticas; fatiga de avisos. | Señal opcional, no bloqueante, configurable y con opción de posponer o cerrar. |
| Feedback inmediato | Conecta la pausa realizada con una consecuencia comprensible. | Feedback constante se convierte en juicio o medición de rendimiento. | Confirmación breve centrada en haber tomado una pausa; sin puntuación moral. |
| Progreso visible | Ayuda a notar repetición o recuperación. | Rachas rotas, culpa y sensación de fracaso. | Mostrar continuidad flexible o pequeños hitos sin perder progreso por saltarse un día. |
| Narrativa o juego | Puede volver más agradable una pausa física. | Un mini-juego digital termina siendo otra razón para quedarse en pantalla. | La interacción principal ocurre fuera de la pantalla; el cierre del juego invita a volver al entorno real. |
| Recompensa | Puede dar una señal de satisfacción posterior a una acción. | Premio artificial, búsqueda compulsiva o recompensa que sustituye la razón de la conducta. | Refuerzo inmediato, previsible y proporcional; nunca por abrir más la app. |
| Personalización | Puede encajar el apoyo en distintos contextos. | Inferencias invasivas, caja negra, vigilancia. | Preferencias manuales y reglas sencillas; nada de capturar contenido de pantalla o pulsaciones. |
| Comunidad/cooperación | Puede ofrecer apoyo social. | Comparación, competencia y vergüenza pública. | Colaboración voluntaria, sin rankings públicos de hábitos ni exposición de datos personales. |
| Fricción y salida | Ayuda a continuar cuando es útil y a detenerse cuando ya no lo es. | Retirar toda fricción puede fomentar uso no intencional. | Un paso para iniciar; un final claro; sin scroll infinito, autoplay ni «un reto más» indefinido. |
| Recompensa impredecible | La incertidumbre puede aumentar el chequeo repetido en algunos contextos. | Es precisamente el tipo de mecanismo que puede promover búsqueda compulsiva. | **No recomendado**: no usar premios aleatorios, notificaciones cebadas ni contenido impredecible para crear dependencia. |

Estas recomendaciones son principios de diseño y salvaguardas, no una promesa de que cualquier recurso «ético» será efectivo. Cada mecanismo debe evaluarse en una tarea y contexto concretos.

### 7.2. Principios no negociables para nikucode

1. **Optimizar la pausa física, no el tiempo en pantalla.** No usar aperturas, minutos dentro de la app o notificaciones respondidas como métrica de éxito principal.
2. **Autonomía real.** La persona puede aplazar, descartar, pausar recordatorios y salir sin castigo.
3. **No penalizar lapsos.** Nada de rachas que se destruyen, retroceso de nivel, pérdida acumulada o lenguaje de culpa.
4. **No usar ansiedad, FOMO, vergüenza o presión social como motor.** No diseñar para que la persona sienta que perderá algo por no volver.
5. **Interacción digital breve.** La acción valiosa ocurre fuera de la app; la herramienta no retiene a la persona después de invitarla a moverse.
6. **Final claro y ausencia de bucles infinitos.** No scroll infinito, autoplay, recompensas intermitentes ni mensajes cuya finalidad sea reabrir el producto.
7. **Privacidad por defecto.** No monitorizar contenido de pantalla, pulsaciones, aplicaciones, historial o datos sensibles para adaptar un recordatorio, salvo necesidad demostrada y consentimiento explícito. En esta hackatón, además, está prohibido usar datos personales reales, incluidos los del equipo.
8. **Progreso reversible y comprensible.** El usuario controla la frecuencia, el horario y el mecanismo; puede desactivarlos fácilmente.
9. **No explotar estados vulnerables.** No intensificar avisos al inferir agotamiento, malestar o inactividad emocional. El prototipo no diagnostica salud mental.
10. **Medir efectos adversos.** Registrar en pruebas ficticias si el mecanismo interrumpe, molesta o hace que las personas quieran abandonarlo, no solo si aumenta el uso.
11. **Diseñar para independencia.** Una intervención exitosa puede convertirse en una señal ambiental o un hábito autónomo, sin requerir interacción persistente con la aplicación.
12. **No confundir intención con eficacia.** Que nuestro propósito sea saludable no elimina la obligación de comprobar los efectos.

### 7.3. «Persuasivo» no significa «manipulador» si se cumplen ciertas condiciones

La persuasión es más defendible cuando: la finalidad real está visible; el mecanismo y la recompensa son comprensibles; la persona puede rechazarlo sin presión; el diseño no oculta opciones de salida; no aprovecha datos privados para explotar debilidades; y la evaluación prioriza un resultado que la propia persona valora.

Una prueba útil para el equipo es preguntarse: **si explicáramos exactamente a la persona cómo funciona el mecanismo, ¿seguiría considerándolo aceptable y útil?** Si el efecto depende de ocultar la intención, aumentar la ansiedad o hacer más difícil abandonar el producto, la solución se acerca a la manipulación.

## 8. Aplicación al problema de nikucode: qué comparar, sin decidir aún el producto

El problema presentado en la postulación es facilitar pausas breves antes del dolor o agotamiento, sin culpa ni dependencia de la fuerza de voluntad. La conversación posterior añade que a veces se olvida la pausa, a veces se sigue por obligación, y otras veces el descanso con celular o juegos se prolonga; también aparece cansancio acumulado. Estos son elementos declarados por el equipo, no resultados de un estudio representativo.

Hay tres familias de prototipos que se pueden comparar con escenarios sintéticos:

### A. Invitación física atractiva y de duración acotada

Una señal invita a una micro-pausa específica. El elemento lúdico se concentra en hacer agradable el movimiento, no en mantener a la persona interactuando con la app. Al terminar, hay un final inequívoco.

- Hipótesis: hacer la primera acción pequeña y agradable reduce la fricción de iniciar una pausa.
- Riesgo: añade otra alerta o la persona rechaza el tono de juego.
- Prueba: observar si la persona entiende qué hacer, lo inicia y puede terminar en pocos pasos; registrar también si siente interrupción o infantilización.

### B. Transición con marcador de reanudación

Antes de salir unos minutos, la persona puede preservar un próximo paso («cuando vuelva, seguiré con…») en una acción simple. El marcador resuelve la incertidumbre de volver a la tarea; no se convierte en una lista de tareas ni en registro del contenido del trabajo.

- Hipótesis: reducir el temor a perder el hilo facilita aceptar una pausa.
- Riesgo: la preparación para reanudar se vuelve otra obligación o no compensa la fricción.
- Prueba: comparar un flujo sin marcador y otro con marcador usando una misma situación ficticia.

### C. Señal situada en una transición natural o fuera de pantalla

La oportunidad aparece al terminar una subtarea, al esperar una compilación o mediante una señal ambiental, si el contexto permite interrumpir sin riesgo. No se requiere que una app observe qué está haciendo el usuario.

- Hipótesis: una señal más cercana a un cierre natural puede resultar menos invasiva que un temporizador fijo.
- Riesgo: no siempre existe una transición natural; reglas demasiado rígidas no consideran reuniones u obligaciones inaplazables.
- Prueba: pedir que se interpreten escenarios ficticios con contextos diferentes y explicar cuándo sería apropiado ofrecer la pausa.

Estas familias son hipótesis de prototipado, no una selección final ni una afirmación de eficacia. No se recomienda aún construir un feed infinito de ejercicios, una app social, un sistema de premios aleatorios ni monitorización permanente.

## 9. Evaluación: separar atracción, conducta y resultado

Una demo de una hackatón no puede probar que se creó un hábito, se previno dolor o se mejoró la salud mental. Sí puede comprobar el funcionamiento y explorar si la propuesta se entiende.

| Nivel | Pregunta | Métrica exploratoria posible | Qué no permite afirmar |
|---|---|---|---|
| Funcionamiento | ¿El flujo funciona de principio a fin? | Casos de prueba que pasan/fallan. | Que alguien quiera usarlo o que le ayude. |
| Comprensión | ¿La persona entiende qué propone y por qué? | Puede explicar la acción sin ayuda. | Que vaya a cambiar su comportamiento real. |
| Usabilidad | ¿Puede iniciar/cerrar la pausa con poca fricción? | Pasos, errores, tiempo en tarea ficticia. | Efecto sobre salud. |
| Aceptabilidad | ¿La intervención se siente útil y respetuosa? | Comentarios estructurados sobre autonomía, molestia y claridad. | Adopción sostenida en el tiempo. |
| Conducta inmediata | ¿En un experimento real se hace una pausa más a menudo o antes? | Pausas válidas realizadas / oportunidades; latencia; interrupciones no deseadas. | Prevención clínica de dolor o hábito duradero con muestra pequeña. |
| Efecto sostenido | ¿El comportamiento cambia sin efectos adversos a lo largo del tiempo? | Seguimiento longitudinal con consentimiento y protocolo. | No se puede obtener en la hackatón de un día. |

En la hackatón se usarán únicamente escenarios y datos sintéticos. Las métricas reales de uso o salud de Alex y Javier no deben introducirse en código, prompts, servicios externos ni demo; el evento prohíbe datos personales reales, incluidos los propios.

### Experimento de prototipo aconsejado

1. Crear un caso ficticio de alguien concentrado en una tarea y con una pausa pendiente.
2. Comparar al menos dos flujos de baja fidelidad, por ejemplo una invitación breve y otra con opción de guardar el siguiente paso.
3. Pedir a la persona que explique qué haría y cuál le resulta menos disruptivo. Si solo participa el equipo, documentar que es una prueba heurística, no una validación independiente con usuarios.
4. Registrar por separado comprensión, fricción, autonomía percibida y molestia.
5. Elegir la versión más simple que responda a la hipótesis principal, no la que tenga más funciones o parezca más adictiva.

## 10. Recomendación para la visión del proyecto

Una formulación defendible para README o pitch sería:

> **Queremos aprovechar principios de diseño que hacen fáciles de iniciar y repetir algunas experiencias digitales, pero medir nuestro éxito por la acción saludable que ocurre fuera de la pantalla. En lugar de crear dependencia, buscamos que una pausa breve sea atractiva, accesible y elegida por la persona, con control claro para aplazar o salir y sin castigar los lapsos.**

Y una formulación más corta:

> **No queremos que la gente dependa de nuestra app; queremos que la app ayude a que cuidarse requiera menos esfuerzo.**

La segunda frase es una visión, no una afirmación de que ya sabemos hacerlo. Debemos comprobar qué mecanismo reduce realmente la barrera descrita.

## 11. Decisiones y pendientes de investigación

### Conclusiones provisionalmente respaldadas

- El uso problemático de redes sociales y los patrones compulsivos son temas reales de investigación, aunque su definición y estatus diagnóstico siguen siendo discutidos.
- Hay asociaciones entre mayor uso de vídeos cortos y resultados cognitivos/mentales menos favorables en un metaanálisis amplio, pero no se establece causalidad automática.
- La gamificación puede mejorar ligeramente ciertos resultados físicos en intervenciones sanitarias frente a versiones no gamificadas.
- En salud digital, aumentar engagement no garantiza aumentar eficacia; deben evaluarse ética, autonomía y posibles daños simultáneamente.
- El diseño de plataformas y las protecciones de menores son objeto de litigios y regulación actuales, pero los litigios deben distinguirse de las conclusiones científicas.
- Las cifras virales de «seis/ocho segundos de atención» no tienen una base primaria válida como medida general de la capacidad humana de atender.

### Hipótesis abiertas

- H1: un elemento lúdico breve puede hacer más atractiva una pausa física sin mantener al usuario en la pantalla.
- H2: la oportunidad de guardar un siguiente paso puede disminuir la preocupación por perder el hilo.
- H3: autonomía y ausencia de castigo pueden reducir la sensación de obligación incumplida.
- H4: una señal vinculada a una transición natural puede ser menos molesta que un recordatorio con intervalo fijo.
- H5: una interfaz sin rachas ni feed puede seguir siendo lo bastante atractiva para probarla; la hipótesis debe comprobarse con interacción, no asumirse.

### Pendiente antes de afirmar eficacia

- Pruebas reales con usuarios, consentimiento y protocolo ético apropiado.
- Seguimiento más largo que una demo.
- Medidas objetivas y comparables de pausas/sedentarismo, sin recoger datos sensibles innecesarios.
- Evaluación de efectos negativos: molestia, dependencia de avisos, ansiedad, distracción, aumento de pantalla o abandono.

## 12. Referencias principales

1. Nguyen, L. et al. (2025). *Feeds, feelings, and focus: A systematic review and meta-analysis examining the cognitive and mental health correlates of short-form video use*. Psychological Bulletin, 151(9), 1125–1146. https://doi.org/10.1037/bul0000498. Registro: https://pubmed.ncbi.nlm.nih.gov/41231585/
2. Yan, S. et al. (2024). *Mobile phone short video use negatively impacts attention functions: an EEG study*. Frontiers in Human Neuroscience. https://doi.org/10.3389/fnhum.2024.1383913
3. Pazdur, M., Tutus, D., & Haag, A.-C. (2025). *Risk Factors for Problematic Social Media Use in Youth: A Systematic Review of Longitudinal Studies*. Adolescent Research Review. https://doi.org/10.1007/s40894-025-00264-4
4. Nishi, S. K. et al. (2024). *Effect of digital health applications with or without gamification on physical activity and cardiometabolic risk factors: a systematic review and meta-analysis of randomized controlled trials*. EClinicalMedicine, 76, 102798. https://doi.org/10.1016/j.eclinm.2024.102798
5. Idrees, A. R. et al. (2024). *Persuasive technologies design for mental and behavioral health platforms: A scoping literature review*. PLOS Digital Health. https://doi.org/10.1371/journal.pdig.0000498
6. Ngabo-Woods, H., Dunai, L., Seguí Verdú, I., & Tîrșu, V. (2026). *Gamification in Digital Mental Health Interventions: A Systematic Review of the Engagement–Efficacy–Ethics Trilemma*. Information, 17(2), 168. https://doi.org/10.3390/info17020168
7. American Psychiatric Association. *What is Technology Addiction?* (reviewed February 2024). https://www.psychiatry.org/patients-families/technology-addictions-social-media-and-more/what-is-technology-addiction
8. World Health Organization. *Gaming disorder*. https://www.who.int/news-room/questions-and-answers/item/addictive-behaviours-gaming-disorder
9. European Commission (6 Feb 2026). *Commission preliminarily finds TikTok’s addictive design in breach of the Digital Services Act*. https://digital-strategy.ec.europa.eu/en/news/commission-preliminarily-finds-tiktoks-addictive-design-breach-digital-services-act
10. Reuters (25 Mar 2026). *Meta, Google lose US case over social media harm to kids*. https://www.reuters.com/legal/litigation/jury-reaches-verdict-meta-google-trial-social-media-addiction-2026-03-25/
11. Reuters (26 Aug 2026, updated 28 Aug). *Meta agrees to pay $18 billion to settle US lawsuits over children's social media addiction*. https://www.reuters.com/business/meta-reaches-18-billion-settlements-over-childrens-social-media-addiction-2026-08-26/
12. Meta (17 Sep 2024; subsequent updates). *Introducing Instagram Teen Accounts*. https://about.fb.com/news/2024/09/instagram-teen-accounts/
13. Meta (17 Jun 2026). *Strengthening Teen Accounts with New Safety Updates on Instagram and Facebook*. https://about.fb.com/news/2026/06/strengthening-teen-accounts-with-new-safety-updates-on-instagram-and-facebook/
14. BBC (10 Mar 2017). *Busting the attention span myth*. https://www.bbc.com/news/health-38896790
15. Mark, G. (entrevista/transcripción). *Our 47-Second Attention Span with Gloria Mark*. Steelcase. https://www.steelcase.com/research/articles/our-47-second-attention-span-with-gloria-mark-s5-ep3-transcript/

---

**Estado documental:** investigación bibliográfica actualizada al 16-10-2026. Este archivo apoya la fase de descubrimiento y los criterios éticos; no constituye una evaluación clínica ni evidencia de que una futura intervención de nikucode sea efectiva.


---

## Nota metodológica de continuidad (18-10-2026)

Las fuentes legales/regulatorias, la investigación académica y las interpretaciones de diseño se mantienen como categorías distintas. Una denuncia, demanda o conclusión preliminar no equivale a un resultado experimental ni a una sentencia definitiva. Ninguna fuente convierte “crear dependencia” en un objetivo de diseño validado o recomendable. La matriz `MATRIZ_EVIDENCIA_Y_VALIDACION.md` recoge alcance, límite y posible decisión asociada a las afirmaciones principales.
