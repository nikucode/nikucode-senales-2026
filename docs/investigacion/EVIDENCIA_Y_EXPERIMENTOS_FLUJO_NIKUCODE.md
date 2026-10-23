# Evidencia y plan experimental para el flujo principal de nikucode

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Actualización:** 19 de octubre de 2026
**Estado:** síntesis de investigación y recomendación provisional; la solución no está validada.
**Equipo:** nikucode · Hackatón Señales de Makana, 23–24 de octubre de 2026.

## 1. Decisión que necesitamos tomar

¿Qué intervención merece probarse primero para ayudar a personas que estudian o trabajan muchas horas frente a una pantalla a iniciar pausas físicas breves antes del dolor o agotamiento, sin añadir otra obligación ni una interrupción inoportuna?

La respuesta no puede formularse honestamente como una probabilidad numérica de éxito de nikucode. Los estudios disponibles prueban componentes distintos, en poblaciones y entornos diferentes; no existe un ensayo que pruebe nuestro flujo exacto ni nuestros objetivos de captación y retención. Lo que sí podemos hacer es identificar el componente con evidencia más directa, documentar las incertidumbres y diseñar un experimento que permita decidir sin construir demasiado.

## 2. Formulación fiel al caso

**Hecho de la postulación:** dos integrantes estudian y desarrollan proyectos durante periodos largos frente al computador. Notan que necesitan moverse, pero suelen seguir hasta que dolor, sueño o una necesidad externa los obliga a parar. Después pueden descansar con otra pantalla. Los intentos de rutinas, registros de ejercicio y recordatorios se convierten en obligaciones incumplidas. La meta declarada es iniciar pausas breves sin culpa ni depender solamente de fuerza de voluntad.

**Problema operativo de diseño:** facilitar la transición desde una sesión sedentaria y absorbente hacia una pausa física breve, manteniendo autonomía y una forma de volver a la tarea.

No asumimos que la causa única sea el olvido, las redes sociales, la falta de motivación, la adicción, ni la dificultad de recordar dónde se dejó una tarea. Son barreras que pueden coexistir. La solución inicial debe responder a la meta principal —pausas breves— y no transformarse en una app genérica de productividad, salud mental o bloqueo de redes.

## 3. Evidencia cuantitativa relevante

### E01. Leppe-Zamora et al. (2025): referencia cuantitativa en cuarentena

Referencia bibliográfica: revisión sistemática y metaanálisis de 18 estudios y 1.164 trabajadores de oficina. DOI: https://doi.org/10.1186/s12966-025-01781-0 · PubMed: https://pubmed.ncbi.nlm.nih.gov/40514667/

**Corrección crítica según auditoría previa del equipo en OpenCode:** se detectaron errores de extracción/cálculo (errores estándar de Swartz tratados como desviaciones estándar, orientación de grupos inconsistente según el resultado y tamaños de grupo incorrectos para el desenlace de pasos). El equipo reporta haber reproducido los agregados con esas entradas. Por ello quedan suspendidas como estimaciones fiables las cifras antes citadas de −12,46 minutos sentados y +1.030 pasos, hasta resolver la discrepancia con los datos/tablas originales. Esta nota integra ese hallazgo previo; no afirma que se haya repetido independientemente el reanálisis en esta edición.

**Implicación:** no presentar esta revisión como evidencia cuantitativa favorable ni como motivo para priorizar un aviso digital. El aviso puede mantenerse como comparador barato si la hipótesis y la prueba lo justifican, en conjunto con los resultados nulos de Teuber et al. (2022, N=57) y Wafi et al. (2024, N=77) y con la evidencia multicomponente de Parés-Salomón et al. (2024), que no identifica qué componente causa el efecto agregado.

### E02. Mensajes de pausa durante estudio universitario — resultado nulo relevante

Teuber et al. (2022), ensayo aleatorizado de 10 días durante la pandemia, con 57 universitarios que estudiaban en casa (grupo de intervención n=22; grupo de intervención mínima n=35). El grupo de intervención recibió mensajes digitales motivacionales diarios sobre videos de pausas activas; el control tuvo acceso mínimo a la videoteca y también respondió preguntas diarias. El porcentaje medio de participantes que informó al menos un minuto de pausa por día fue 60,7 % frente a 49,2 %, pero la diferencia entre grupos no fue estadísticamente significativa: OR aproximada 2,00, IC 95 % 0,37–10,8, p=0,42.

Fuente: https://doi.org/10.3389/fspor.2022.1024996

**Qué apoya:** no asumir que “más avisos” o mensajes motivacionales por sí solos basten.
**Qué no apoya:** concluir que todas las notificaciones fallan. La muestra fue pequeña, el contexto fue excepcional y el control no era completamente inactivo.

### E03. Intervenciones adaptativas en el momento oportuno (JITAI) — prometedoras, pero no probadas como superiores en general

Yang et al. (2026), revisión sistemática publicada el 4 de septiembre de 2026. Incluyó 37 estudios y 6.939 participantes; 18 eran ensayos aleatorizados. Los efectos de ensayos favorables sobre pasos oscilaron entre +371 y +1.327 pasos/día, con heterogeneidad alta en la síntesis exploratoria (I²=85 %). Para actividad física moderada-vigorosa, algunos ensayos mostraron +13 a +200 min/semana. En los ensayos aleatorizados que midieron objetivamente tiempo sedentario, las diferencias entre grupos no alcanzaron significación estadística. Quince de 18 RCT tuvieron riesgo de sesgo moderado o alto.

Fuente: https://doi.org/10.3389/fpubh.2026.1934024 · PubMed: https://pubmed.ncbi.nlm.nih.gov/42761105/

La revisión identificó un estudio no aleatorizado en 58 trabajadores sedentarios con mayor proporción de pausas en el grupo de mensajes contextuales que en el de mensajes estáticos (53,2 % frente a 19,9 %, p<0,001). El diseño no aleatorizado impide tratarlo como estimación causal robusta por sí solo.

**Qué apoya:** estudiar el momento y contexto de la señal; podría ser más importante que añadir más contenido.
**Qué no apoya:** que la personalización compleja, sensores o IA superen a una regla sencilla. La revisión pide comparaciones directas entre JITAI y alternativas estáticas.

### E04. Interrumpir una apertura de app — mecanismo de elección relevante, resultado indirecto

Grüning et al. (2023), estudio de campo con datos de 280 participantes durante seis semanas y experimento preregistrado en línea con n=500. En el estudio de campo, los intentos de abrir las apps objetivo bajaron 37 % frente a la primera semana y las aperturas efectivas bajaron 57 % al final de seis semanas. En promedio, 36 % de los intentos de abrir una app objetivo se cerraban tras la intervención de un segundo. En el experimento online, la opción explícita de cancelar la apertura fue el componente más potente; el mensaje reflexivo por sí solo no mostró eficacia.

Fuente: https://doi.org/10.1073/pnas.2213114120 · Texto disponible: https://pmc.ncbi.nlm.nih.gov/articles/PMC9974409/

**Qué apoya:** dar una oportunidad clara de elección («ahora», «después», «no ahora») puede ser más importante que una frase motivacional.
**Qué no apoya:** que se generen pausas físicas, ni una reducción equivalente de sedentarismo. El 57 % se refiere a aperturas de apps; no es una tasa de retención y no debe proyectarse a nikucode.

### E05. Notificaciones, engagement inmediato y abandono — la respuesta puntual no equivale a permanencia

Bell et al. (2023), ensayo microrrandomizado de la app Drink Less. De 350 usuarios nuevos, cada participante tenía decisiones diarias aleatorizadas sobre recibir o no una notificación. Una notificación incrementó 3,5 veces las probabilidades de abrir la aplicación en la hora posterior (IC 95 %: 2,91–4,25). Sin embargo, las políticas comparadas no produjeron diferencias significativas en el tiempo hasta la desvinculación.

Fuente: https://pubmed.ncbi.nlm.nih.gov/37294612/ · DOI: https://doi.org/10.2196/38342

**Qué apoya:** los avisos pueden generar una respuesta inmediata.
**Qué no apoya:** que el uso repetido mejore el resultado conductual o la retención a largo plazo. Además, el dominio estudiado era el consumo de alcohol, no las pausas sedentarias.

### E06. Autonomía y competencia percibida — efecto medio pequeño

Sheeran et al. (2020), metaanálisis de ensayos aleatorizados basado en 56 artículos y 65 pruebas independientes de intervenciones de cambio de conducta fundamentadas en la teoría de autodeterminación. El tamaño de efecto promedio fue d=0,23; las intervenciones mostraron efectos significativos en varios comportamientos saludables, aproximadamente entre d=0,16 y 0,29. La motivación autónoma y la competencia percibida mediaron los efectos conductuales; tras correcciones por sesgo, los efectos seguían siendo distintos de cero pero menores.

Fuente: https://doi.org/10.1037/ccp0000501 · PubMed: https://pubmed.ncbi.nlm.nih.gov/32437175/

**Qué apoya:** elección real, lenguaje no controlador y acciones que parezcan alcanzables.
**Qué no apoya:** una interfaz concreta ni un efecto grande. Autonomía debe probarse como parte de una intervención, no solo declararse.

### E07. Intenciones de implementación — utilidad potencial, efecto dependiente de cómo se refuerzan

Silva et al. (2018), revisión y metaanálisis de 13 ensayos aleatorizados sobre planes del tipo «si ocurre X, entonces haré Y» para promover actividad física en adultos. El análisis global informado en el artículo fue pequeño y no significativo (d≈0,15; IC 95 % −0,01 a 0,31); el subgrupo de intervenciones que reforzaban las intenciones de implementación mostró d≈0,25 (IC 95 % 0,05–0,45).

Fuente: https://doi.org/10.1371/journal.pone.0206294 · PubMed: https://pubmed.ncbi.nlm.nih.gov/30427874/

**Qué apoya:** asociar la pausa con una señal o transición concreta puede merecer una prueba.
**Qué no apoya:** asumir que una pregunta de planificación, por sí sola, aumentará pausas en el equipo.

### E08. Formación de hábitos — repetición contextual, gran variabilidad, sin castigar lapsos

Lally et al. (2010), estudio longitudinal de 96 voluntarios que eligieron una conducta alimentaria, de bebida o actividad para repetir diariamente en un contexto estable durante 12 semanas; 82 aportaron datos suficientes. El tiempo estimado para llegar al 95 % de la asíntota de automaticidad osciló entre 18 y 254 días en los participantes cuyos datos admitían modelamiento; el resultado varió ampliamente entre personas. Perder una oportunidad no alteró materialmente el proceso de formación del hábito.

Fuente: https://doi.org/10.1002/ejsp.674

**Qué apoya:** repetición ligada a señales conocidas y recuperación sencilla después de saltarse una pausa.
**Qué no apoya:** prometer formación de hábitos en 21 días, ni usar rachas como prueba de bienestar.

### E09. Abandono de apps de salud — alto y heterogéneo

Una revisión de alcance de 18 estudios, con 525.824 participantes y aplicaciones de salud, estilo de vida y salud mental, encontró que la mediana de abandono acumulado era del 70 % antes de 100 días. Los motivos se agruparon en problemas técnicos/funcionales, privacidad, mala experiencia, contenido/funciones, coste de tiempo o dinero y cambios en necesidades u objetivos.

Fuente: https://pmc.ncbi.nlm.nih.gov/articles/PMC11694054/ · DOI: https://doi.org/10.2196/56897

**Qué apoya:** reducir pasos, carga, interrupciones no deseadas y falta de utilidad.
**Qué no apoya:** atribuir un 70 % de abandono a una app concreta, predecir el abandono de nikucode o justificar tácticas adictivas.

### E10. Interrupciones y recuperación de una tarea — el coste de perder el hilo existe

Una revisión sistemática y metaanálisis de 2021 examinó 33 experimentos de laboratorio (49 intervenciones) diseñados para reducir los efectos negativos de las interrupciones. El conjunto de intervenciones mejoró la precisión de la tarea principal (SMD=1,03; p=0,001) y redujo el retardo de reanudación (SMD=−0,51; p<0,001), aunque los resultados variaron por tipo de intervención y tarea.

Fuente: https://doi.org/10.1016/j.apergo.2021.103506 · PubMed: https://pubmed.ncbi.nlm.nih.gov/34273814/

Un estudio experimental de 2026 con una tarea de programación (N=40, 20 por condición) encontró que el grupo interrumpido produjo más errores, necesitó más tiempo total y realizó más comprobaciones entre regiones de la interfaz. Es un estudio exploratorio de laboratorio, no una prueba de que un marcador de reanudación resuelva esos efectos.

Fuente: https://doi.org/10.1016/j.displa.2026.103618

**Qué apoya:** no interrumpir como si todas las tareas fueran iguales; explorar si una transición elegible o un apoyo opcional para recordar el siguiente paso facilita retomar.
**Qué no apoya:** obligar a escribir una nota antes de cada pausa; eso también añade fricción.

## 4. Síntesis: qué componente tiene la evidencia más útil

No hay evidencia suficiente para estimar una «probabilidad de éxito» del producto completo. Sí hay una jerarquía cualitativa de pertinencia:

1. **Señal simple + pausa física concreta:** candidato de bajo coste para comparación; los estudios de prompts son pertinentes pero los agregados de Leppe-Zamora están en cuarentena y hay ensayos estudiantiles con resultados nulos.
2. **Elección visible de hacerla ahora, posponer o rechazar:** apoyo experimental indirecto desde la interrupción de aperturas de apps y coherencia con evidencia de autonomía; debe probarse para pausas físicas.
3. **Momento contextual o regla basada en señal elegida:** evidencia emergente. No está demostrado que un algoritmo complejo supere a una regla estática, así que empezar con horario configurado o transición visible reduce riesgo.
4. **Ayuda opcional para retomar la tarea:** justificada como hipótesis por literatura de interrupciones, pero no necesaria hasta probar que perder el hilo es un obstáculo dominante.
5. **Microcontenido, mascota, puntos o racha:** no son el núcleo inicial. La gamificación puede apoyar actividad física en promedio, pero el resultado es pequeño e indirecto. Añadirlos podría aumentar carga y consumo de pantalla.
6. **Overlay dentro de Instagram, IA o monitorización de pantalla:** no priorizar en una primera prueba; complejidad técnica y privacidad altas y sin prueba directa de que sean necesarios para aumentar pausas.

Una candidata pragmática para comparar es una invitación breve y de baja fricción que nombra una acción física fácil, ofrece opciones de decisión sin castigo y evita exigir registro. Esto no se presenta como la dirección mejor respaldada cuantitativamente: es una **hipótesis de bajo coste**, no una solución estadísticamente probada para nikucode.

## 5. Protocolo de pretotipo durante la hackatón

Las reglas del evento exigen iniciar el código competitivo durante la hackatón y prohíben usar datos personales reales, incluidos los propios. Este protocolo no supone que el prototipo ni el código se construyan antes del evento. El test debe utilizar escenarios ficticios; si se solicita feedback a participantes, no se registrarán nombres, datos identificables ni información sensible y se respetará cualquier instrucción adicional de la organización.

### Pregunta de prueba

¿Una invitación que ofrece una acción física específica y las opciones «ahora / después de este paso / no ahora» se entiende más fácilmente y se siente menos coercitiva que una invitación genérica a hacer una pausa?

### Variantes

- **A — Recordatorio genérico:** «¿Te vendría bien una pausa?» con opciones para iniciar, posponer y descartar.
- **B — Acción concreta con autonomía:** una propuesta breve de movimiento, con las mismas opciones para hacerla ahora, posponerla hasta terminar el paso actual o descartarla sin penalización.

No se compararán simultáneamente mascota, contenido educativo, puntos, temporizador, detección automática ni IA. Mantener una sola diferencia principal ayuda a interpretar el resultado.

### Método exploratorio

1. Preparar dos representaciones neutrales con el mismo nivel visual de fidelidad durante la hackatón.
2. Presentar un escenario ficticio idéntico a cada participante; equilibrar el orden A/B para reducir el efecto de orden.
3. Pedir que explique qué ofrece la interfaz y que señale cómo empezar, posponer y descartar.
4. Observar sin sugerir respuestas: pasos necesarios, dudas, opciones no encontradas y momentos percibidos como intrusivos.
5. Registrar solo conteos agregados y comentarios no identificables, si las normas del evento lo permiten.

### Métricas de pretotipo

- **Éxito de tarea:** consigue localizar y explicar sin ayuda cómo iniciar una pausa, posponer y descartar.
- **Comprensión:** identifica la acción física sugerida y entiende que no es obligatoria.
- **Fricción:** número de pasos necesarios y necesidad de explicación externa.
- **Interferencia percibida:** si la invitación parece interrumpir indebidamente una tarea.
- **Autonomía percibida:** si el usuario interpreta que puede elegir sin penalización.

### Criterio de decisión previo

La prueba de hackatón es pequeña, exploratoria y no estará estadísticamente potenciada para demostrar eficacia conductual. No declarar significación ni generalizar desde una muestra de conveniencia.

Preferir B para continuar si los participantes pueden identificar las tres opciones sin ayuda, entienden de forma consistente la acción concreta y no describen más presión o interferencia que con A. Si B añade confusión o fricción, simplificar o regresar a A. Si los resultados son mixtos, conservarlo como inconcluso y escoger la variante técnicamente más simple para la demo, documentando la limitación.

Si la conversación o el test indica que el impedimento principal es el miedo a perder el hilo, considerar como experimento secundario una opción **voluntaria** para marcar en una frase el siguiente paso antes de pausar. No hacerla obligatoria ni añadirla al MVP antes de que el flujo primario funcione.

## 6. Qué puede y qué no puede demostrar este experimento

**Puede informar:** comprensión, usabilidad, aceptabilidad inicial, claridad de opciones, percepción de interrupción y qué variante merece un prototipo funcional.

**No puede demostrar:** que la gente haga más pausas en su vida real, que se reduzcan minutos de sedentarismo, que se prevenga dolor, que se forme un hábito, que la solución sea mejor estadísticamente, que clientes la descarguen o que mantengan la aplicación a largo plazo.

En la demo puede comprobarse funcionamiento técnico del flujo con escenarios ficticios; el éxito técnico no es evidencia del impacto sanitario.

## 7. Qué medir en una futura prueba de campo

Solo después de validar el flujo básico y con consentimiento y protección de privacidad apropiados, un estudio posterior puede estudiar el comportamiento en condiciones reales. Una comparación microrrandomizada dentro de la persona podría asignar en puntos de decisión elegibles una variante simple o la variante con acción/elección; el tamaño de muestra y cantidad de puntos de decisión deberán planificarse usando tasas basales y correlación intrapersonal, no elegirse arbitrariamente.

- **Resultado conductual principal:** proporción de oportunidades elegibles seguidas de una pausa breve completada dentro de una ventana predefinida. Definir de antemano cómo se confirma la pausa sin recopilar más datos de lo necesario.
- **Resultados proximales:** seleccionar «ahora», posponer y luego completar, descartar, latencia, número de pasos y errores.
- **Aceptabilidad/daños:** molestia, interrupciones no deseadas, desactivaciones, culpa o presión percibida.
- **Retorno saludable:** proporción de participantes que mantienen voluntariamente la función activada y realizan pausas en semanas sucesivas, junto con carga percibida y pausas realizadas. No usar aperturas o minutos dentro de la app como sustituto del resultado físico.
- **Adopción comercial:** activación al primer valor útil, decisión explícita de probar de nuevo y retención vinculada al beneficio. Requiere un estudio separado; la evidencia sobre sedentarismo no permite estimar adquisición ni disposición a pagar.

No establecer un objetivo de dependencia psicológica. El objetivo comercial puede ser que se quiera volver porque el sistema aporta valor real; la medida de éxito debe seguir siendo el beneficio fuera de la pantalla, con opción de desactivación y sin pérdida de progreso.

## 8. Registro de decisión

- **Decisión provisional:** probar primero la señal de baja fricción con una acción física concreta y opciones explícitas ahora/después/no ahora.
- **Razón:** es una comparación sencilla y de bajo coste que corresponde al resultado de la postulación; las afirmaciones cuantitativas de Leppe-Zamora están en cuarentena. La opción de elección tiene respaldo indirecto en one sec, cuyo resultado fue apertura de apps, no pausas físicas.
- **Supuesto más riesgoso:** la señal será suficientemente oportuna y no se convertirá en otro recordatorio ignorado; los usuarios realmente pueden hacer una pausa al recibirla.
- **Alternativas no elegidas aún:** marcador de reanudación, microeducación, mascota/recompensa, adaptación contextual, bloqueo de redes o overlay.
- **Qué cambiaría la decisión:** pruebas donde la invitación concreta aumenta fricción o intrusión; evidencia de que el obstáculo dominante es distinto; o reglas del evento que impidan la función propuesta.
- **Estado:** HIPÓTESIS INFORMADA; no validada.

## 9. Referencias principales

1. Leppe-Zamora J, Ramos-Fuster S, Muñoz-Monari B, et al. (2025). *The effect of computer prompt in breaks of sedentary behaviour among office workers: a systematic review and meta-analysis*. International Journal of Behavioral Nutrition and Physical Activity, 22, 75. https://doi.org/10.1186/s12966-025-01781-0
2. Teuber M, Leyhr D, Sudeck G. (2022). *Nudging digital physical activity breaks for home studying of university students—a randomized controlled trial during the COVID-19 pandemic with daily activity measures*. Frontiers in Sports and Active Living. https://doi.org/10.3389/fspor.2022.1024996
3. Yang S, Li M, Li Y, et al. (2026). *Just-in-Time Adaptive Interventions for physical activity: a systematic review of their public health impact and methodological quality*. Frontiers in Public Health. https://doi.org/10.3389/fpubh.2026.1934024
4. Grüning DJ, et al. (2023). *Directing smartphone use through the self-nudge app one sec*. PNAS. https://doi.org/10.1073/pnas.2213114120
5. Bell L, Garnett C, Bao Y, et al. (2023). *How Notifications Affect Engagement With a Behavior Change App: Results From a Micro-Randomized Trial*. JMIR mHealth and uHealth. https://doi.org/10.2196/38342
6. Sheeran P, Wright CE, Avishai A, et al. (2020). *Self-determination theory interventions for health behavior change: Meta-analysis and meta-analytic structural equation modeling of randomized controlled trials*. Journal of Consulting and Clinical Psychology, 88(8), 726–737. https://doi.org/10.1037/ccp0000501
7. Silva MAV, São-João TM, Brizon VC, Franco DH, Mialhe FL. (2018). *Impact of implementation intentions on physical activity practice in adults: A systematic review and meta-analysis of randomized clinical trials*. PLOS ONE, 13(11), e0206294. https://doi.org/10.1371/journal.pone.0206294
8. Lally P, van Jaarsveld CHM, Potts HWW, Wardle J. (2010). *How are habits formed: Modelling habit formation in the real world*. European Journal of Social Psychology, 40, 998–1009. https://doi.org/10.1002/ejsp.674
9. Kidman et al. (2024). *When and Why Adults Abandon Lifestyle Behavior and Mental Health Mobile Apps: Scoping Review*. JMIR. https://doi.org/10.2196/56897
10. *Effects of interventions to reduce the negative consequences of interruptions on task performance: A systematic review, meta-analysis, and narrative synthesis of laboratory studies*. Applied Ergonomics (2021). https://doi.org/10.1016/j.apergo.2021.103506
11. Wen Z, Ba J, Yang J, Zhou Y. (2026). *Understanding user resumption behavior after task interruptions: An eye-tracking-based empirical study*. Displays. https://doi.org/10.1016/j.displa.2026.103618

---

**Cierre metodológico:** la evidencia no nos da una probabilidad de éxito del producto terminado. Sí hace defendible priorizar una señal simple + acción física concreta + elección sin castigo como primera hipótesis, y diseñar una prueba que pueda refutarla antes de ampliar el alcance.
