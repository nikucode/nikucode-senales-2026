# RESEARCH_AND_CASES.md

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


> **Actualización crítica 22-10-2026:** las cifras agregadas de Leppe-Zamora et al. (2025) quedan suspendidas tras la auditoría anterior del equipo descrita en `INTEGRACION_OPENCODE_A_CODEX_2026-10-22.md`. Algunas frases históricas en versiones previas se han corregido; si aparece una cifra en una cita, leerla como referencia al resultado que fue cuestionado, nunca como estimación validada.


**Última actualización:** 18 de octubre de 2026
**Alcance:** revisión preliminar. Esta no es una revisión sistemática exhaustiva ni sustituye los briefs, entrevistas o reglas oficiales.

## 0. Actualización de auditoría del evento (16 de octubre de 2026)

La página oficial de bases está en **versión 1.4, actualizada el 16-10-2026**: https://hack.makana.cl/bases.html. Esta versión resuelve la discrepancia horaria que figuraba en los correos/programa frente a la versión 1.2 anterior. El horario operativo actual es: viernes 09:00–18:30 (acreditación desde 08:30), sábado 09:00–13:00 para construir y entregar, pitches desde las 14:00, deliberación 17:00, premiación 17:30 y cierre 18:00. El jurado considera el último commit de la rama principal presente a las 13:00. La página del evento confirma el mismo horario: https://hack.makana.cl/evento.

Reglas que afectan directamente al plan: no llevar código propio preescrito como entrega del evento; crear el repo durante la hackatón; mantenerlo público y con README de una página; usar las cuentas individuales de GitHub; no cargar ni utilizar datos personales reales propios ni ajenos; herramientas y formato de solución libres. Los tres criterios de evaluación tienen igual peso: comprensión del problema, calidad de la solución y credibilidad de que produzca cambio. Fuentes: bases v1.4, secciones 8–10 y 16; página del evento.

Este documento registra la base oficial vigente consultada en esa fecha; revisar una posible actualización posterior antes de participar.

## 1. Principio metodológico

La unidad de diseño no es “una app para crear hábitos”, sino una conducta concreta en un contexto específico y una barrera que podamos justificar que existe. No diagnosticaremos personas con base en una publicación de marketing o un resumen de caso.

Para cada conclusión, conservar estas categorías:

- **Hecho/fuente:** lo que dice expresamente la evidencia.
- **Interpretación:** explicación plausible que conecta hechos.
- **Hipótesis:** explicación que todavía necesita comprobarse.
- **Decisión de diseño:** intervención elegida provisionalmente.
- **Prueba:** cómo verificaremos un resultado observable.

No presentar categorías como equivalentes.

## 2. Literatura científica y metodológica inicial

### 2.1 COM-B y Behaviour Change Wheel

**Referencia:** Michie, S., van Stralen, M. M., & West, R. (2011). “The behaviour change wheel: A new method for characterising and designing behaviour change interventions.” *Implementation Science*, 6, 42. DOI: https://doi.org/10.1186/1748-5908-6-42
Texto abierto: https://pmc.ncbi.nlm.nih.gov/articles/PMC3096582/

- **Tipo:** marco conceptual/metodológico, no experimento que demuestre por sí solo la eficacia de una intervención concreta.
- **Idea central:** COM-B propone examinar capacidad (capability), oportunidad (opportunity) y motivación (motivation) como componentes que interactúan para explicar una conducta. Behaviour Change Wheel organiza funciones de intervención que pueden responder a barreras diferentes.
- **Utilidad práctica:** evita asumir “falta motivación”. Una conducta puede ser difícil por habilidad, tiempo, recursos, condiciones físicas, organización, señales del entorno, creencias, emociones o rutinas.
- **Limitaciones:** clasificar una barrera usando COM-B no demuestra que esa barrera sea real ni que una intervención vaya a cambiar conducta. El diagnóstico depende de evidencia del caso; las categorías pueden solaparse.
- **Decisiones que podría informar:** preguntas de investigación, mecanismos alternativos, elección de intervención mínima y riesgos de atribuir todo al individuo cuando hay condiciones estructurales/laborales.

### 2.2 Formación de hábitos en la vida cotidiana

**Referencia:** Lally, P., van Jaarsveld, C. H. M., Potts, H. W. W., & Wardle, J. (2010). “How are habits formed: Modelling habit formation in the real world.” *European Journal of Social Psychology*, 40, 998–1009. DOI: https://doi.org/10.1002/ejsp.674
Página editorial y resumen: https://onlinelibrary.wiley.com/doi/abs/10.1002/ejsp.674

- **Método/población:** 96 voluntarios eligieron una conducta de alimentación, bebida o actividad para repetir diariamente en un contexto consistente durante 12 semanas; 82 aportaron datos suficientes para el análisis.
- **Hallazgo relevante:** la automaticidad aumentó con la repetición en un contexto consistente. En los participantes para los que ajustó el modelo individual, el tiempo estimado para alcanzar el 95 % de su asíntota varió de 18 a 254 días.
- **Otro matiz:** perder una oportunidad aislada no alteró materialmente el proceso de formación del hábito en este estudio.
- **Limitaciones:** muestra de voluntarios, conductas escogidas por los participantes, mediciones de autorreporte y duración acotada. No convierte esos días en una promesa individual ni representa todas las conductas o contextos.
- **Decisiones que podría informar:** evitar el mito de que todos los hábitos se forman en 21 días; favorecer la repetición en un contexto estable cuando corresponda; diseñar para recuperarse de interrupciones en lugar de presentar un tropiezo como fracaso.

### 2.3 Intenciones de implementación (“si ocurre X, haré Y”)

**Referencia:** Gollwitzer, P. M., & Sheeran, P. (2006). “Implementation Intentions and Goal Achievement: A Meta-analysis of Effects and Processes.” *Advances in Experimental Social Psychology*, 38, 69–119. DOI: https://doi.org/10.1016/S0065-2601(06)38002-1
Registro bibliográfico: https://www.socmot.uni-konstanz.de/publications/implementation-intentions-and-goal-achievement-meta-analysis-effects-and-processes

- **Tipo:** metaanálisis de la relación entre planes específicos de acción y logro de metas.
- **Idea central:** un plan que especifica cuándo/dónde/cómo responder a una señal (“si X, entonces Y”) puede ayudar a cerrar la brecha entre intención y acción.
- **Utilidad práctica:** convertir un objetivo vago en una respuesta realizable ante una situación concreta; definir también alternativas ante barreras previsibles.
- **Limitaciones:** un plan no elimina falta de recursos, horarios incompatibles, enfermedad, restricciones laborales ni falta de control sobre el entorno. No basta con pedir a alguien que formule una intención.
- **Decisión que podría informar:** probar una secuencia de acción concreta o un plan de contingencia si el caso indica que la persona ya tiene intención, pero falla al pasar a la acción.

### 2.4 Fogg Behavior Model

**Recurso:** Stanford Behavior Design Lab, “Fogg Behavior Model”: https://behaviordesign.stanford.edu/resources/fogg-behavior-model

- **Tipo:** modelo práctico de diseño conductual promovido por el laboratorio de su autor; no debe tratarse como evidencia independiente de eficacia.
- **Propuesta:** para que ocurra una conducta, motivación, capacidad percibida y un prompt/señal deben coincidir en el momento pertinente.
- **Utilidad práctica:** lista de comprobación rápida si una acción no ocurre: ¿es demasiado difícil? ¿existe la señal adecuada? ¿es importante para la persona en ese momento?
- **Limitaciones:** simplifica procesos complejos y no sustituye investigación cualitativa, factores materiales o evaluación de causalidad.
- **Decisión que podría informar:** generar hipótesis de fricción y oportunidades de simplificación, sin convertirlo en diagnóstico.

### 2.5 Intervenciones digitales de formación de hábitos: revisión sistemática

**Referencia:** Wang, S. J. et al. (2024). “Digital Behavior Change Intervention Designs for Habit Formation: Systematic Review.” *Journal of Medical Internet Research*, 26, e54375. DOI: https://doi.org/10.2196/54375
Texto: https://www.jmir.org/2024/1/e54375/

- **Método/alcance:** revisión sistemática de cuatro bases de datos, estudios publicados entre 2012 y 2022; incluyó 41 artículos centrados en intervenciones digitales para actividad física y formación de hábitos.
- **Hallazgos descriptivos:** en los estudios revisados eran comunes las señales/prompts, el establecimiento de metas, el automonitoreo, feedback, planes definidos por el usuario y otras técnicas.
- **Interpretación correcta:** que una técnica aparezca con frecuencia en soluciones existentes no demuestra por sí solo que sea la más eficaz para un caso particular.
- **Limitaciones:** foco en actividad física, en intervenciones digitales, y en publicaciones en inglés; la implementación/validación de las intervenciones revisadas varía.
- **Decisiones que podría informar:** repertorio de opciones para comparar —señales, metas autoelegidas, registro y feedback—, no una lista obligatoria de funcionalidades.

### 2.6 Desarrollo y evaluación de intervenciones complejas

**Referencia:** Skivington, K. et al. (2021). “A new framework for developing and evaluating complex interventions: update of Medical Research Council guidance.” *BMJ*, 374, n2061. DOI: https://doi.org/10.1136/bmj.n2061
Texto: https://www.bmj.com/content/374/bmj.n2061

- **Idea central:** desarrollo, factibilidad, evaluación e implementación deben considerar contexto, teoría del programa, participación de partes interesadas, incertidumbres, refinamiento y recursos; no son una escalera rígida donde se avanza sin importar lo que se aprende.
- **Utilidad para la hackatón:** registrar qué incertidumbre reduce cada prueba, qué mecanismo esperamos y qué contexto puede impedir que funcione.
- **Limitación:** es un marco amplio para intervenciones complejas; no es una receta de un día ni autoriza conclusiones de impacto con una demo.

### 2.7 Diseño centrado en las personas y prototipado

**Recurso metodológico:** IDEO.org, Design Kit / The Field Guide to Human-Centered Design: https://www.ideo.org/tools%26

- **Uso práctico:** explorar el contexto de la persona, reformular el problema, generar alternativas, prototipar lo suficiente para aprender y revisar la propuesta ante observaciones.
- **Límite de evidencia:** es una fuente metodológica profesional; no la presentaremos como un ensayo que prueba que una intervención concreta funciona.
- **Uso en una jornada:** una entrevista breve o ficha de caso bien leída, un mapa compacto de barreras, varias alternativas y una prueba de flujo pueden dar información accionable sin fingir que sustituyen investigación longitudinal.

### 2.8 Tamaño de muestra y pruebas de usabilidad

**Recurso metodológico:** Nielsen Norman Group, Jakob Nielsen (2012), “How Many Test Users in a Usability Study?” https://www.nngroup.com/articles/how-many-test-users/

- El artículo describe que las muestras pequeñas pueden descubrir problemas cualitativos de usabilidad; advierte expresamente que las pruebas cuantitativas requieren más participantes y otro razonamiento.
- **Uso correcto:** si logramos probar el prototipo con una o pocas personas, informar qué confusión/obstáculo apareció y cómo corregimos el flujo.
- **No afirmar:** que una prueba con pocas personas representa a toda la población, que predice adopción o que demuestra un efecto sobre hábitos.

### 2.9 Pausas breves, conducta sedentaria y recordatorios digitales

**Referencia 1:** Leppe-Zamora, J. et al. (2025). “The effect of computer prompt in breaks of sedentary behaviour among office workers: a systematic review and meta-analysis.” *International Journal of Behavioral Nutrition and Physical Activity*, 22, 75. DOI: https://doi.org/10.1186/s12966-025-01781-0. Texto/abstract: https://pubmed.ncbi.nlm.nih.gov/40514667/

- **Método/población:** revisión sistemática y metaanálisis de 18 estudios con 1.164 trabajadores de oficina; la búsqueda cubrió literatura hasta diciembre de 2024. Los estudios duraron entre 1 y 24 semanas (mediana: 8 semanas).
- **Estado del resultado cuantitativo:** en una auditoría previa del equipo durante el trabajo con OpenCode se detectaron problemas de extracción/cálculo (errores estándar de Swartz tratados como desviaciones estándar, orientación inconsistente de grupos según resultado y tamaños de grupo incorrectos para pasos). El equipo informa haber reproducido los agregados con esas entradas. Las cifras publicadas de efecto quedan **en cuarentena** hasta resolver la discrepancia con los datos/tablas originales; no utilizarlas como estimaciones fiables. Esta actualización integra el hallazgo informado y no reproduce de forma independiente sus cálculos.
- **Certeza y límites generales:** incluso al margen de la discrepancia cuantitativa, el contexto es trabajadores de oficina y los resultados secundarios de salud no fueron estadísticamente significativos. La cita se conserva para trazabilidad, no como prueba cuantitativa favorable.
- **Aplicación al caso:** no concluir que “los recordatorios no funcionan”, pero tampoco declarar que funcionan o que son superiores. Los ensayos con estudiantes y otras intervenciones deben leerse por separado. La señal puede mantenerse como candidato barato de comparación si el diagnóstico de barrera y la prueba lo justifican.

**Referencia 2:** Parés-Salomón, I. et al. (2024). “Effectiveness of workplace interventions with digital elements to reduce sedentary behaviours in office employees: a systematic review and meta-analysis.” *International Journal of Behavioral Nutrition and Physical Activity*, 21, 41. DOI: https://doi.org/10.1186/s12966-024-01595-6. Texto: https://link.springer.com/article/10.1186/s12966-024-01595-6

- **Método/población:** revisión de 19 estudios y metaanálisis de 11 estudios de intervenciones laborales con componentes digitales.
- **Hallazgo:** reducción agrupada de 29,9 minutos de conducta sedentaria por jornada laboral de ocho horas (IC 95 %: 14,5–45,2 minutos menos).
- **Matiz esencial:** gran parte de las intervenciones fueron multicomponente y mezclaron información, apoyo organizacional, retroalimentación y prompts. No se puede atribuir el efecto a una notificación concreta ni identificar un componente universalmente mejor.
- **Aplicación al caso:** considerar la interacción entre señal, contexto y facilidad de responder; no equiparar “más funciones digitales” con mejor intervención.

**Referencia 3:** World Health Organization (2020). *WHO guidelines on physical activity and sedentary behaviour*. https://www.who.int/publications/i/item/9789240015128

- **Tipo:** guía de salud pública basada en evidencia, no protocolo de pausas frente al computador.
- **Hallazgo pertinente:** recomienda limitar el comportamiento sedentario y sustituir parte de ese tiempo por actividad física de cualquier intensidad.
- **Limitación:** no establece una duración o frecuencia universal de micropausas adecuada para este caso, ni permite prometer prevención individual del dolor.

**Fuente de contexto adicional:** Cochrane, “Workplace interventions for reducing time spent sitting at work” (2018). https://www.cochrane.org/evidence/CD010912_workplace-interventions-methods-reducing-time-spent-sitting-work

- La revisión encuentra indicios de que interrupciones breves pueden reducir tiempo sentado en ciertos contextos, pero señala limitaciones y evidencia insuficiente para varias comparaciones. Es un recordatorio de diseñar pruebas específicas en lugar de convertir una frecuencia fija en regla médica.

**Referencia 4 (amplía el panorama, pero no es evidencia directa sobre pausas):** Lee, S.-A., & Park, J.-H. (2025). “Systematic review and meta analysis of standalone digital behavior change interventions on physical activity.” *npj Digital Medicine*, 8, 436. DOI: https://doi.org/10.1038/s41746-025-01827-4. Texto: https://www.nature.com/articles/s41746-025-01827-4

- **Método/población:** revisión sistemática y metaanálisis de 18 ensayos aleatorizados de intervenciones digitales autónomas de cambio de conducta para promover actividad física en adultos.
- **Hallazgo:** efecto pequeño a moderado en actividad física (SMD = 0,324), con certeza baja; para métricas corporales SMD = 0,269, certeza moderada.
- **Límite central:** el objetivo de la revisión es actividad física y métricas corporales en adultos, no específicamente interrupciones del sedentarismo, pausas breves durante programación/estudio ni evitar dolor en el momento oportuno.
- **Uso válido en nuestro proyecto:** muestra que las intervenciones digitales por sí solas pueden tener efectos modestos en actividad física, pero no determina que una solución digital sea mejor que un ritual o señal ambiental ni que las rachas, la IA o una aplicación particular sean necesarias.

### 2.10 Interrupciones, concentración y momentos oportunos

**Referencia 1:** Adamczyk, P. D., & Bailey, B. P. (2004). “If not now, when? The effects of interruption at different moments within task execution.” *CHI 2004*, pp. 271–278. DOI: https://doi.org/10.1145/985692.985727. Ficha académica: https://experts.illinois.edu/en/publications/if-not-now-when-the-effects-of-interruption-at-different-moments-/

- **Hallazgo:** los distintos momentos de interrupción de una secuencia de tarea tuvieron impactos diferentes en estado emocional y atribución social, lo que sugiere que el momento de una interrupción importa.
- **Limitación:** estudio de interacción humano-computador sobre interrupciones, no prueba de una intervención para pausas sedentarias ni de un mecanismo que detecte automáticamente el mejor instante.
- **Aplicación al caso:** diseñar con cuidado el momento y la posibilidad de aplazar un aviso; tratar la detección de “buen momento” como una hipótesis, no como capacidad ya demostrada.

**Referencia 2:** Leroy, S. (2009). “Why is it so hard to do my work? The challenge of attention residue when switching between work tasks.” *Organizational Behavior and Human Decision Processes*, 109(2), 168–181. DOI: https://doi.org/10.1016/j.obhdp.2009.04.002

- **Método/hallazgo:** dos experimentos sobre transiciones entre tareas encontraron que parte de la atención puede permanecer ligada a una tarea sin terminar, afectando el rendimiento en la siguiente.
- **Limitación:** no estudió micropausas ni demuestra que una nota de reanudación solucione por sí sola el problema.
- **Aplicación al caso:** una hipótesis de diseño razonable es reducir el coste percibido de dejar la tarea guardando una pista breve de “dónde quedé / próximo paso” antes de hacer la pausa. Se debe probar su comprensión y utilidad, no presentarlo como un efecto científico establecido.

**Referencia 3:** Mark, G., Gudith, D., & Klocke, U. (2008). “The cost of interrupted work: more speed and stress.” *Proceedings of CHI 2008*, pp. 107–110. DOI: https://doi.org/10.1145/1357054.1357072. Texto del autor: https://www.ics.uci.edu/~gmark/chi08-mark.pdf

- **Hallazgo:** en su estudio, las personas compensaron interrupciones trabajando más rápido, pero experimentaron más estrés, frustración, presión temporal y esfuerzo.
- **Limitación:** no implica que toda interrupción produzca esos efectos ni estudia específicamente pausas saludables.
- **Aplicación al caso:** evitar diseñar una experiencia que haga sentir a la persona que está fallando por aplazar una pausa o que debe completar otra obligación administrativa para descansar.

### 2.11 Síntesis de evidencia para el caso

**Hallazgos apoyados por fuentes:** los prompts de computador pueden reducir modestamente el tiempo sentado en intervenciones de varias semanas; las intervenciones digitales multicomponente también muestran reducciones agrupadas, pero no permiten aislar el componente activo; las micropausas pueden mejorar algunos indicadores de bienestar como vigor/fatiga, aunque no necesariamente el rendimiento global; el momento de interrupción puede importar. El metaanálisis de intervenciones digitales autónomas para actividad física aporta evidencia general sobre actividad física, no evidencia específica sobre pausas sedentarias.

**Interpretación del equipo:** el caso combina por lo menos dos dificultades descritas en la postulación: permanecer sedentario durante periodos largos y sentir que parar interrumpe una actividad en la que se está muy concentrado. La segunda puede ser tan importante para el diseño como la señal misma.

**Hipótesis abiertas:** (a) una alerta genérica llega en momentos poco oportunos o se aprende a ignorarla; (b) hacer visible un punto de continuación reduce la fricción de detenerse; (c) una señal ambiental o un ritual de transición podría facilitar una pausa sin añadir otra interfaz.

**Qué no sabemos:** no tenemos medidas representativas de cuánto se sienta el equipo, con qué frecuencia ignora avisos, en qué momentos duele, ni cuál alternativa funcionaría mejor. No hace falta recolectar registros personales para construir una demo plausible y probar su flujo con un escenario sintético.

## 3. Síntesis de diseño para la hackatón

1. Definir conducta observable, lugar/momento y criterio de éxito antes de imaginar pantallas.
2. Investigar qué antecede a la conducta, qué la hace difícil y qué consecuencias inmediatas la mantienen.
3. Identificar recursos y restricciones del entorno; no convertir barreras estructurales en “falta de disciplina”.
4. Diseñar una hipótesis de mecanismo: cómo exactamente la intervención reduciría una barrera.
5. Comparar solución digital y no digital. IA solo si hace algo necesario que una regla simple no resuelve mejor.
6. Diseñar la prueba más pequeña que pueda invalidar una suposición importante.
7. Separar resultados de la demo (funcionamiento) de resultados humanos (comprensión, usabilidad, adopción e impacto).

## 4. Método para analizar cada brief

Completar la ficha tras recibir el caso real, sin rellenar vacíos con intuición.

### Ficha del caso

- **Identificador/nombre del caso:**
- **Descripción literal del brief:**
- **Fuente y fecha del brief:**
- **Qué quiere conseguir la persona:**
- **Conducta observada que se desea facilitar/cambiar:**
- **Contexto (lugar, momento, rutinas, personas/recursos disponibles):**
- **Qué sabemos de sus intentos anteriores:**
- **Qué sabemos de las consecuencias inmediatas y posteriores:**
- **Restricciones materiales/sociales/laborales fuera de su control:**
- **Qué ya le funciona o qué estrategias usa:**
- **Información desconocida:**
- **Supuestos que podríamos estar haciendo:**
- **Preguntas que resolvería primero:**
- **Posibles riesgos de una intervención mal diseñada:**

### Cadena de hipótesis

**Problema → evidencia → hipótesis causal → intervención → mecanismo esperado → prueba → limitaciones.**

- Problema formulado sin nombrar una solución:
- Evidencia explícita:
- Hipótesis (no hecho):
- Intervención mínima:
- Mecanismo por el cual debería ayudar:
- Señal/resultado observable en la demo:
- Prueba técnica:
- Prueba de comprensión/usabilidad:
- Qué quedaría sin validar:

## 5. Casos que aparecen en publicaciones públicas: tabla provisional

**Advertencia:** esta tabla solo conserva los detalles descritos públicamente. No son los briefs completos ni entrevistas con personas reales. La propia publicación de Kai indica que Camila fue construida como personaje a partir de problemas reales. No debemos inventar motivaciones, emociones o circunstancias no descritas.

| Caso público | Qué se dice públicamente | Qué no sabemos y debemos comprobar |
|---|---|---|
| Camila — gimnasio | Inscrita en enero/lo paga; fue seis veces según las publicaciones. En una descripción se indica que probó tres apps y vuelve al “lunes”; el costo emocional de cancelar se describe como sensación de rendirse. | Si son los mismos datos en el brief vigente; horario, traslados, preferencias, salud, barreras específicas, qué le gustaba, motivos de inasistencia, metas y otras circunstancias. No asumir que el problema sea motivación. |
| Rodrigo — sueño y turnos | Se describe dormir unas cinco horas por turnos rotativos. | Tipo/rotación de turno, tiempo de traslado, condiciones del sueño, control sobre horarios, responsabilidades, entorno de descanso y riesgos de salud. No proponer tratamiento ni asumir que una app puede cambiar los turnos. |
| Patricia — estados de cuenta | Se describe que lleva siete meses evitando abrir el estado de cuenta. | Qué entiende por estados de cuenta, qué teme o espera encontrar, estado real de su situación, acceso, costos/endeudamiento, flujo de ingresos, apoyos y barreras prácticas. No asumir deuda ni diagnosticar ansiedad. |
| Marco — pausas en faena | Se describe que trabaja como operador en faena y casi nunca alcanza a hacer la pausa. | Normas de seguridad, permiso real para pausar, carga de trabajo, cobertura, señalización, supervisión y si una pausa es segura/permitida en ese momento. No culparlo si la organización impide detenerse. |
| Antonia — empezar cada lunes | Se describe que vuelve a empezar desde cero cada lunes tras interrumpir el objetivo. | Qué objetivo intenta cumplir, por qué se interrumpe, si el objetivo es suyo y viable, cuáles son sus reglas de “fallar”, qué significa retomar y qué apoyos/contexto existen. |
| Hábito del propio equipo | La organización anuncia una opción relacionada con un hábito del propio equipo. | Regla completa, si el equipo debe presentar evidencia, cuál sería el hábito y si todos aceptan trabajar sobre ese comportamiento. No inventar el reto. |

## 6. Comparación razonada sin puntuaciones arbitrarias

No hay información suficiente para declarar ganador a un caso. Una matriz justa usará estados cualitativos explícitos —**conocido, desconocido, favorable, preocupante, depende del brief**— y una breve justificación.

| Criterio | Qué buscar | Señal favorable | Riesgo / información que falta |
|---|---|---|---|
| Claridad del problema | Conducta y contexto observables | Se puede describir una situación concreta | El problema está formulado como rasgo (“flojo”) o solución (“necesita app”) |
| Calidad de evidencia | Detalles del brief, entrevista y contexto | El brief ofrece ejemplos concretos o permite preguntar | Solo hay un resumen promocional |
| Relevancia humana | Consecuencias para la persona | Problema importa para esa persona y su rutina | La urgencia se presume desde fuera |
| Aprendizaje posible | Preguntas que pueden resolverse en el tiempo | Se puede observar/confirmar una barrera importante | Causa depende de datos inaccesibles o entrevistas largas |
| Intervención concreta | Barrera modificable | Una intervención mínima aborda un mecanismo claro | Se intenta resolver todos los factores a la vez |
| Factibilidad técnica | Flujo principal y dependencias | Prototipo local o simple, sin dependencias frágiles | API, integraciones, sensores o permisos complejos imprescindibles |
| Demostrabilidad | Entrada, acción, salida y resultado visible | Flujo reproducible en pocos pasos | Solo hay mockup superficial o necesita datos externos caídos |
| Posibilidad de prueba | Señal de éxito a corto plazo | Se puede observar comprensión o tarea completada | Se requieren semanas/meses para evaluar conducta |
| Privacidad y ética | Datos, consentimiento, coerción, vergüenza | Datos ficticios y elección de la persona | Vigilancia, sanción, exposición financiera/salud o presión indebida |
| Ajuste al equipo | Experiencia y curva de aprendizaje | Se conocen herramientas y se prueba rápido | Todo el MVP depende de tecnología nueva |
| Diferenciación | Soluciones ya intentadas/alternativas | Se identifica por qué el enfoque se adapta mejor al contexto | “Usa IA/gamificación” como única diferenciación |
| Historia del pitch | Persona, barrera, intervención y aprendizaje | Se puede explicar el razonamiento honestamente | La narrativa depende de resultados inventados |

**Regla de selección provisional:** comparar primero los briefs completos; identificar para cada uno el problema menos incierto que podamos aprender a comprender y una barrera abordable sin infringir restricciones. Elegir solo después de evaluar dependencia técnica, ética y capacidad de demostrarlo. El sexto caso no recibe preferencia automática.

## 7. Diseño de evaluación realista

| Nivel | Pregunta | Evidencia posible en un día | Qué no demuestra |
|---|---|---|---|
| Funcionamiento técnico | ¿El flujo principal funciona? | Ejecutar la demo desde el inicio, repetir tareas, verificar errores | Que a la persona le sirva o cambie su conducta |
| Comprensión | ¿La persona entiende qué hacer y para qué? | Pedir a alguien que explique con sus palabras y complete una tarea | Que vaya a usarlo en la vida diaria |
| Usabilidad exploratoria | ¿Dónde se atasca? | Observar intentos, errores, dudas, finalización sin ayuda | Estimaciones representativas o significancia estadística |
| Señal preliminar | ¿La intervención parece reducir la barrera prevista en una tarea acotada? | Comparar ejecución de la tarea con/ sin un elemento del prototipo, cuando sea ético y viable | Causalidad sólida o impacto a largo plazo |
| Adopción | ¿La persona lo usa repetidamente en contexto real? | Requeriría seguimiento posterior con medidas claras | No se puede inferir desde una presentación de hackatón |
| Impacto conductual | ¿Cambió la conducta de forma sostenible? | Requiere datos a lo largo del tiempo y diseño de evaluación apropiado | No es algo que una demo pueda demostrar |

## 8. Riesgos éticos a revisar según el caso

- No culpabilizar ni presentar la conducta como defecto de carácter.
- No proponer vigilancia o compartir datos con empleadores/familia sin necesidad, transparencia y autorización.
- Evitar vergüenza, castigos, rachas que penalicen interrupciones inevitables o recompensas diseñadas para crear uso compulsivo.
- En turnos/faena, no promover pausas que contradigan procedimientos de seguridad, ni consejos médicos de sueño.
- En finanzas, evitar conectar cuentas, recolectar credenciales, inferir deuda o dar asesoría financiera personalizada sin competencia/validación apropiada.
- Minimizar datos. Usar datos ficticios/sintéticos de extremo a extremo.
- Explicar consentimiento, elección de la persona, limitaciones y qué no medimos.

## 9. Referencias centrales y cómo usar cada una

1. Michie et al. (2011), COM-B / Behaviour Change Wheel — https://doi.org/10.1186/1748-5908-6-42 — marco para formular barreras y funciones posibles de intervención.
2. Lally et al. (2010), habit formation in everyday life — https://doi.org/10.1002/ejsp.674 — variabilidad individual y repetición en contexto estable.
3. Gollwitzer & Sheeran (2006), implementation intentions meta-analysis — https://doi.org/10.1016/S0065-2601(06)38002-1 — planes específicos tipo “si X, entonces Y”.
4. Wang et al. (2024), digital habit-formation interventions systematic review — https://doi.org/10.2196/54375 — panorama de estrategias digitales para actividad física.
5. Skivington et al. (2021), MRC complex intervention framework — https://doi.org/10.1136/bmj.n2061 — desarrollo iterativo y evaluación de incertidumbres/contexto.
6. Stanford Behavior Design Lab, Fogg Behavior Model — https://behaviordesign.stanford.edu/resources/fogg-behavior-model — heurística práctica que no sustituye evidencia del caso.
7. IDEO.org, Design Kit — https://www.ideo.org/tools%26 — métodos prácticos de diseño centrado en las personas/prototipado.
8. Nielsen, J. (2012), qualitative usability testing sample sizes — https://www.nngroup.com/articles/how-many-test-users/ — diferencia entre detectar problemas cualitativos y estimar números poblacionales.


## 10. Aplicación al sexto caso: pausas breves durante sesiones frente al computador

**Fuente de verdad:** el equipo compartió el texto original de su postulación el 16-10-2026. La siguiente síntesis conserva su sentido, sin registrar correos, identificadores oficiales ni otra información personal innecesaria.

> Dos integrantes estudian y desarrollan proyectos que los mantienen horas frente al computador. Aunque notan que necesitan moverse, suelen continuar hasta que el dolor, el sueño o una necesidad externa los obliga a parar; después descansan con otra pantalla. Han intentado retomar rutinas, anotar ejercicio y recordarse hacer pausas, pero terminan convirtiéndose en otra obligación incumplida. Las barreras señaladas son el agotamiento, la concentración intensa, el dolor y que estudio, ocio y descanso ocurren en los mismos dispositivos.

- **Objetivo original:** facilitar el inicio de pausas breves sin culpa y sin depender únicamente de fuerza de voluntad.
- **Criterio de éxito original:** interrumpir periodos sedentarios con pausas breves antes de llegar al dolor o agotamiento.
- **Límite:** este criterio expresa la aspiración del equipo; no es evidencia de que una intervención prevendrá dolor ni de que cambie un hábito de manera sostenida.
- **Regla de datos del evento:** no usar datos personales reales, incluidos los propios. El prototipo, prompts de IA, repo y demo se limitan a escenarios/datos ficticios; no registrar ni transmitir detalles de salud o hábitos de las personas participantes.

### 10.1 Separación de hechos, hipótesis y preguntas

**Hechos declarados en la postulación**

- El equipo pasa periodos prolongados estudiando/desarrollando proyectos frente al computador.
- Describe que suele continuar hasta que el dolor, el sueño o una necesidad externa fuerza la interrupción.
- Después, el descanso puede seguir ocurriendo frente a otra pantalla.
- Ya intentó rutinas, registro del ejercicio y recordatorios, pero los vivió como una obligación adicional incumplida.
- El objetivo no es aumentar la productividad: es empezar pausas breves antes del dolor/agotamiento y sin culpa.

**Hipótesis de diseño que aún no se han verificado**

- La concentración intensa eleva el coste subjetivo de interrumpir una tarea antes de un punto natural de cierre.
- Una alerta de reloj fija podría resultar inoportuna, convertirse en ruido o ser ignorada; la evidencia no permite asumir que los prompts siempre fallan, ya que las revisiones encuentran reducciones modestas de tiempo sentado.
- Dejar una pista rápida para retomar la tarea podría reducir el coste percibido de hacer una pausa. Esto es una extrapolación razonada desde investigación de transiciones entre tareas, no una intervención demostrada en este caso.
- Una señal física/ambiental o un ritual de transición puede ser menos intrusivo que otra app, pero su disponibilidad y efectividad son desconocidas.
- El mecanismo debe funcionar también cuando no hay dolor todavía; no usar el dolor como disparador requerido ni recomendar ignorarlo.

**Preguntas que importan para elegir intervención**

1. ¿La dificultad principal es olvidar la pausa, no querer perder el hilo, sentir culpa por parar, no saber qué pausa hacer, o una mezcla?
2. ¿Hay momentos naturales de transición que ya ocurren al guardar, ejecutar, compilar, terminar un bloque o cambiar de tarea? Es una pregunta de diseño, no un hecho medido.
3. ¿Qué pausa mínima se considera útil y aceptable en el escenario, sin prescribir ejercicio ni dar consejo médico?
4. ¿Qué señal podría llamar la atención sin competir agresivamente con el trabajo?
5. ¿Cómo puede la persona posponer/declinar sin penalización y volver sin culpa?

### 10.2 Cadena problema–evidencia–hipótesis–prueba

- **Problema:** durante sesiones prolongadas frente al computador, el equipo retrasa las pausas y suele interrumpirse recién cuando el malestar, sueño u obligación externa lo fuerza.
- **Evidencia de contexto:** el texto de la postulación declara ese patrón y varios intentos previos; no aporta medidas de frecuencia o causalidad.
- **Hipótesis prioritaria:** para este caso, no basta con tener presente que conviene hacer pausas: detener la actividad puede sentirse costoso mientras la tarea sigue “abierta”. Una ayuda que permita pausar sin perder dónde se quedó merece compararse con un recordatorio genérico.
- **Intervención:** todavía no elegida. Comparar alternativas antes de implementar.
- **Mecanismo esperado (si se elige una pista de reanudación):** bajar el coste percibido de dejar la tarea por un momento al conservar el próximo paso, y presentar la pausa como una opción pequeña y reversible. Es hipótesis, no resultado demostrado.
- **Prueba viable en el evento:** con un escenario completamente ficticio, pedir a una persona que recorra el prototipo y explique si entiende cómo hacer una pausa, aplazarla y retomar su trabajo. Observar errores de comprensión; no registrar conducta real, dolor ni hábitos de integrantes.
- **Limitaciones:** prueba rápida de comprensión/usabilidad no demuestra adherencia, prevención del dolor, salud mejorada ni cambio de hábito sostenido.

### 10.3 Comparación de familias de intervención antes de elegir

| Alternativa | Mecanismo esperado | Ventaja | Riesgo/limitación | Qué probar en la hackatón |
|---|---|---|---|---|
| A. Aviso periódico genérico | Traer la pausa a la atención | Fácil de entender y prototipar; tiene respaldo indirecto de revisiones de prompts | Puede interrumpir en mal momento, habituarse o volverse otra obligación; la evidencia no identifica el timing ideal | ¿La persona entiende el aviso, lo considera aceptable y puede aplazarlo sin penalización? |
| B. Aviso no bloqueante con control de momento | Señalar oportunidad sin obligar; permitir “ahora / al terminar este paso / más tarde” | Respeta autonomía y reconoce la concentración | Si añade muchas decisiones, aumenta carga; “momento oportuno” podría ser solo una elección manual y no detección real | ¿La opción elegida reduce confusión o introduce un paso extra? |
| C. Pausa con “marcador de reanudación” | Guardar dónde quedó/próximo paso en pocas palabras antes de pausar | Ataca la posible preocupación de perder el hilo; puede ser un flujo simple y local | No hay evidencia directa de que este patrón reduzca sedentarismo; escribir una nota puede convertirse en otra obligación | ¿La persona puede dejar una pista y volver a entender qué hacer sin fricción? Usar solo contenido ficticio. |
| D. Señal ambiental o ritual no digital | Hacer visible la oportunidad de moverse sin una notificación en pantalla | Menos competencia por atención; bajo coste y baja dependencia técnica | Puede pasar desapercibida, no estar disponible o ser difícil de demostrar como producto digital | Prototipar una secuencia/escenario y comparar si se entiende mejor que el aviso. |
| E. Regla o intención “si X, entonces pausa breve” | Vincular una transición existente con una acción sencilla | No requiere sensores, app ni registros; puede evitar depender de un horario uniforme | Puede transformarse en norma rígida, culpa o fallar cuando no ocurre la señal | ¿La regla encaja en escenarios diversos y permite excepciones sin sensación de fracaso? |
| F. Detección automática del contexto/actividad | Estimar si la persona está concentrada o entre tareas para elegir momento | Podría reducir avisos inoportunos si la señal fuera fiable | Alta complejidad y permisos; probable acceso a ventanas/actividad sensible; riesgo de errores y vigilancia; difícil validar en un día | No se recomienda como primera opción de hackatón salvo que aparezca una necesidad clara y viable. |
| G. Chatbot/IA para decidir la pausa | Personalizar recomendaciones o elegir entre opciones | Flexible si hay ambigüedad real y necesidad de adaptación | Puede añadir otra pantalla, latencia, coste y privacidad; no hay necesidad demostrada de IA en este problema | Exigir una tarea que no resuelva un flujo determinista. Si no aparece, descartar IA. |

**Lectura provisional, no decisión final:** A tiene evidencia directa más cercana sobre reducir tiempo sentado en oficinas, aunque los efectos medios son modestos y la población/contexto difieren. B y C abordan mejor la hipótesis de fricción por cambio de tarea, pero su ventaja en este caso aún debe probarse. D y E son alternativas legítimas y no deben descartarse solo por no ser software. F parece desproporcionada para un día y añade riesgos de privacidad. G no se justifica todavía. La selección final debe depender de la barrera que el equipo decida priorizar y de qué flujo se pueda probar mejor.

### 10.4 Diseño de una evaluación pequeña y honesta

La demo debería permitir comprobar algo específico, por ejemplo:

- Comprensión: ¿se entiende qué propone el sistema y por qué?
- Facilidad de acción: ¿se puede empezar una pausa breve en pocos pasos?
- Control: ¿se puede posponer o rechazar sin culpa, penalización ni racha rota?
- Reanudación: si existe un marcador, ¿la instrucción ficticia permite saber cómo continuar?
- Fricción añadida: ¿la herramienta exige teclear, revisar estadísticas o navegar más de lo que simplifica?
- Robustez: ¿la experiencia principal funciona sin cuenta, API o conexión externa, cuando sea posible?

Usar una historia ficticia y datos sintéticos (ejemplo: “Sam está cerrando un proyecto y lleva un rato sentado; acaba de terminar una pequeña tarea”). No utilizar experiencias personales del equipo como datos, no recopilar dolor, salud, tiempos de sentado ni horarios individuales, y no guardar el resultado de un miembro en el repo.

Distinguir estos niveles:

1. **Funcionamiento técnico:** el flujo corre.
2. **Comprensión/usabilidad exploratoria:** una persona puede recorrer el escenario sintético y explicar lo ocurrido.
3. **Señal preliminar:** se identifica una fricción concreta que la intervención parece reducir dentro de la tarea de prueba.
4. **Adopción real:** requeriría uso repetido en contexto real y seguimiento posterior, con reglas estrictas de privacidad.
5. **Impacto conductual/salud:** no se puede demostrar en una hackatón con una demo de un día.

### 10.5 Recomendación metodológica provisional

**No construir primero un temporizador ni un monitor de actividad.** Primero acuerden cuál de estas dos hipótesis es más fiel al problema: (1) se les olvida pausar hasta que llega una señal externa; o (2) recuerdan la pausa, pero el costo de interrumpir y perder el hilo hace que la pospongan. Un recordatorio puede encajar con la primera; un soporte de transición/reanudación puede encajar con la segunda. Si no saben cuál domina, la demo puede comparar dos flujos mínimos sobre el mismo escenario ficticio, en vez de asumir una respuesta.

La pregunta de diseño se mantiene como la formularon: **¿cómo facilitar que una persona interrumpa una sesión sedentaria cuando todavía está a tiempo, sin romper innecesariamente su concentración ni hacer que la pausa se sienta como una tarea pendiente?**

### 10.6 Bibliografía prioritaria para este caso

1. Leppe-Zamora et al. (2025), prompts por computador para pausas sedentarias: https://doi.org/10.1186/s12966-025-01781-0
2. Parés-Salomón et al. (2024), intervenciones digitales en trabajadores de oficina: https://doi.org/10.1186/s12966-024-01595-6
3. WHO (2020), recomendaciones de actividad física y conducta sedentaria: https://www.who.int/publications/i/item/9789240015128
4. Adamczyk & Bailey (2004), momento de la interrupción: https://doi.org/10.1145/985692.985727
5. Leroy (2009), residuo atencional al cambiar de tarea: https://doi.org/10.1016/j.obhdp.2009.04.002
6. Mark, Gudith & Klocke (2008), velocidad/estrés tras interrupciones: https://doi.org/10.1145/1357054.1357072
7. Albulescu, P. et al. (2022), “Give me a break!” A systematic review and meta-analysis on the efficacy of micro-breaks for increasing well-being and performance. *PLOS ONE*, 17(8), e0272460. https://doi.org/10.1371/journal.pone.0272460 — 22 muestras independientes (N=2.335); efectos pequeños favorables en vigor (d=0,36) y fatiga (d=0,35), pero no un efecto estadísticamente significativo en rendimiento global (d=0,16). La mayoría de estudios no fueron de bajo riesgo de sesgo y el rendimiento tuvo heterogeneidad; no equivale a evidencia directa de prevención del dolor ni de cambios de sedentarismo para este hábito.
8. Lee & Park (2025), metaanálisis de intervenciones digitales autónomas sobre actividad física en adultos: https://doi.org/10.1038/s41746-025-01827-4 — útil como contexto general; no estudia en específico interrupciones sedentarias ni el momento oportuno para pausar.

## Investigación ampliada: agotamiento, consumo digital y pausas (16-10-2026)

Se creó un informe independiente para evitar inflar este documento y facilitar la continuidad: [`INVESTIGACION_CARGA_DIGITAL_Y_PAUSAS.md`](INVESTIGACION_CARGA_DIGITAL_Y_PAUSAS.md).

Hallazgos cuantitativos destacados:

- Un estudio correlacional con 424 universitarios de Chile (2026) encontró asociación entre demandas académicas y agotamiento emocional (β = 0,88; p < 0,001; R² = 0,78 en el modelo). No demuestra causalidad ni prevalencia nacional. DOI: https://doi.org/10.3389/fpsyg.2026.1885652
- Un metaanálisis de 75 estudios con 48.031 estudiantes encontró correlación moderada entre uso problemático del teléfono y procrastinación (r = 0,376; IC 95 % [0,345, 0,406]); no demuestra dirección causal. DOI: https://doi.org/10.1016/j.jad.2023.11.020
- El artículo de Leppe-Zamora et al. (2025) revisó 18 estudios con 1.164 trabajadores, pero sus efectos agregados están en cuarentena por la auditoría previa del equipo; no usar la estimación anterior de −12,46 minutos ni el aumento aproximado de pasos como efectos fiables hasta resolver los errores de extracción/cálculo con datos originales. DOI: https://doi.org/10.1186/s12966-025-01781-0
- Un ensayo aleatorizado con 57 universitarios no encontró un efecto significativo de mensajes motivacionales diarios sobre la probabilidad de realizar pausas activas (p > 0,3). DOI: https://doi.org/10.3389/fspor.2022.1024996

La experiencia declarada del equipo incluye agotamiento, obligaciones que no se pueden posponer, consumo de celular/juegos para desconectar y pérdida de noción del tiempo. Esto amplía las hipótesis, pero no autoriza diagnosticar ni asumir una sola causa. Ver el informe para población, método, resultados, limitaciones, fuentes y opciones de diseño.


## Investigación ampliada: diseño persuasivo, gamificación y ética (16-10-2026)

Informe detallado: [`INVESTIGACION_DISENO_PERSUASIVO_Y_DEPENDENCIA.md`](INVESTIGACION_DISENO_PERSUASIVO_Y_DEPENDENCIA.md).

Hallazgos clave: un metaanálisis de 2025 sobre vídeos cortos reunió 71 estudios y 98.299 participantes; encontró asociaciones entre mayor uso y peores resultados cognitivos (r≈−0,34; atención r≈−0,38; control inhibitorio r≈−0,41) y una asociación menor con salud mental (r≈−0,21). Son asociaciones, no pruebas de causalidad. Un metaanálisis de 36 ensayos con 10.079 participantes encontró que la gamificación en aplicaciones de salud añadía unos 489 pasos por día frente a intervenciones no gamificadas, un beneficio medio pequeño. Una revisión de alcance de diseño persuasivo en salud incluyó 161 artículos y encontró pocas comparaciones directas y brechas importantes de evaluación ética.

Conclusión de diseño: se pueden explorar señales, feedback, progresión y mecanismos lúdicos para facilitar pausas, pero no debemos diseñar deliberadamente dependencia. Engagement no equivale a beneficio. Métrica principal: pausa física útil y experiencia autónoma, no tiempo en app, aperturas ni rachas. La cifra viral «seis/ocho segundos de atención» no es una medida científica válida de capacidad humana.


## Investigación ampliada: educación positiva y microcontenido (16-10-2026)

Informe dedicado: [`INVESTIGACION_EDUCACION_POSITIVA_Y_MICROCONTENIDO.md`](INVESTIGACION_EDUCACION_POSITIVA_Y_MICROCONTENIDO.md).

La evidencia respalda algunos componentes educativos dentro de intervenciones de cambio de conducta, pero no demuestra que enseñar un dato, hacerlo entretenido o usar mensajes positivos por sí solos generen hábitos. Una revisión de 2026 de 10 RCT (N=1.355) no encontró una ventaja general estadísticamente significativa de los mensajes orientados a ganancias frente a pérdidas para actividad física; hubo señales favorables en algunos subgrupos que deben interpretarse con cautela. Una revisión paraguas de salud digital (85 revisiones, 12 dominios y más de 865.000 participantes agregados) respalda ciertas combinaciones de señales, tareas graduadas, feedback, planificación y personalización, pero no permite aislar el efecto de una cápsula educativa.

**Hipótesis candidata, no decisión tomada:** una cápsula breve, positiva, opcional y respaldada por fuentes podría aumentar comprensión/aceptabilidad de la pausa sin añadir fricción. Comparar flujo sin contenido frente a una frase integrada; si retrasa la acción o prolonga la pantalla, excluirla del MVP. El objetivo sigue siendo la pausa física, no el consumo de contenido.

## Addendum: evaluar microcontenido sin confundir comprensión con cambio conductual (16-10-2026)

La revisión sistemática de microaprendizaje para autocuidado (Wang et al., 2020; 26 manuscritos) informa que 91% de 23 estudios sobre capacidades cognitivas reportaron mejora estadísticamente significativa, pero solo 36% de los 11 estudios que midieron conducta de autocuidado lo hicieron. La revisión calificó 25/26 artículos con riesgo de sesgo moderado a alto. Por tanto, leer/aprender no debe usarse como sustituto de conducta real: https://pubmed.ncbi.nlm.nih.gov/32882481/ (DOI: 10.1016/j.puhe.2020.07.007).

La revisión de feedback justo a tiempo de Schembre et al. (2018) incluyó 31 estudios (N total 6.623); nueve evaluaron la eficacia del feedback y cuatro informaron mejoras significativas. El feedback accionable, orientado a metas o continuamente disponible apareció en tres de esos cuatro, pero la revisión narrativa no establece causalidad independiente: https://www.jmir.org/2018/3/e106/ (DOI: 10.2196/jmir.8701).

**Prueba metodológica candidata para el evento, sin código competitivo previo:** comparar en escenario ficticio (A) una invitación directa a pausa frente a (B) la misma invitación con una sola frase educativa breve. Mantener iguales el control de pausa/posponer/rechazar, el aspecto y el número de pasos. Observar comprensión, facilidad de iniciar, autonomía percibida y si la frase se siente como una tarea extra. Si no añade valor claro, eliminarla. Informe ampliado: [`INVESTIGACION_EDUCACION_POSITIVA_Y_MICROCONTENIDO.md`](INVESTIGACION_EDUCACION_POSITIVA_Y_MICROCONTENIDO.md).

## Actualización 18-10-2026 — apps existentes y alternativas

Se incorporó `INVESTIGACION_COMPARATIVA_APPS_HABITOS_ENFOQUE.md` con perfiles, mecánicas, cifras públicas, límites de evidencia y fuentes para Opal, Wakeout, Finch y Fabulous.

| Producto | Trabajo principal que declara | Mecanismo de producto que puede estudiarse | Riesgo/limitación para nikucode |
|---|---|---|---|
| Opal | Reducir distracciones y gestionar acceso al teléfono | Bloqueos, límites, horarios, fricción deliberada, reports/score | Puede volver el cuidado en control rígido, puntuación o ranking; no aborda necesariamente el inicio de una pausa física |
| Wakeout | Reducir sedentarismo con movimientos breves y situacionales | Invitación, movimiento inmediato, ejercicios contextuales, juego físico y recordatorios | Antecedente directo; “pausa breve con juego” no es una diferenciación suficiente por sí sola |
| Finch | Hacer el autocuidado cotidiano más amable | Metas pequeñas, mascota, feedback narrativo, personalización y vuelta sin culpa | La mascota/progreso podría convertirse en otra obligación; diarios y datos emocionales no parecen necesarios de entrada |
| Fabulous | Estructurar rutinas y hábitos | Secuencias, habit stacking, retos, coaching, contenido y comunidad | Puede producir carga/checklists; saber más sobre hábitos no demuestra que se realice una pausa |

Las métricas de tiendas (descargas, valoraciones, reseñas) y de marketing (sesiones o personas “ayudadas”) deben mantenerse separadas de retención, adherencia, eficacia y cambio conductual. La búsqueda dirigida no encontró curvas de retención o churn específicas y auditables de las cuatro apps. Véase el informe, que incluye referencias públicas y la revisión sistemática de abandono de apps de salud.


## Investigación competitiva ampliada (18-10-2026)

Véase `INVESTIGACION_COMPETENCIA_DIRECTA_Y_ESTRATEGIA_NIKUCODE.md` para la comparación ampliada de 14 alternativas y literatura. Hallazgos que importan para el análisis de caso:

- La competencia más cercana en la interrupción del ciclo social es one sec, ScreenZen y Clearspace; en el contexto sedentario de escritorio, Workrave y Stretchly; en movimiento breve y jugable, Wakeout.
- Opal/Freedom/Brick trabajan principalmente el compromiso/bloqueo ambiental. Forest/Focus Friend y Finch/Habitica/Fabulous ofrecen antecedentes de gamificación y compañerismo, con riesgos de castigo, rachas, sobrecarga y tareas adicionales.
- No afirmar novedad antes de mapear productos y sustitutos. La posible diferenciación es una hipótesis sobre la transición de pantalla a pausa física con carga mínima, no un hecho probado.
- En iOS no se encontró API pública para insertar una mascota arbitraria dentro de la vista de Reels; el mecanismo soportado más cercano es un shield de Screen Time. En Android son posibles overlays, pero requieren permiso especial y consideración de las políticas de privacidad/accesibilidad.


## Nueva sección — decisión sobre mecanismo principal (18-10-2026)

La investigación no permite declarar una acción universalmente óptima ni inferir captación de clientes a partir del efecto conductual. Aunque el artículo de Leppe-Zamora et al. (2025) es directamente pertinente por tema, sus cifras agregadas están en cuarentena tras la auditoría del equipo y no deben sustentar una priorización cuantitativa. Los metaanálisis de intervenciones multicomponente muestran resultados agrupados en otros contextos, pero mezclan componentes, poblaciones y diseños y no deben compararse como una clasificación directa de eficacia.

La opción one sec (pausa/posibilidad de cancelar al abrir una app) apoya la utilidad potencial de hacer visible una elección, pero su outcome fue apertura de apps, no movimiento físico. Gamificación mostró un efecto pequeño promedio (+489 pasos/día) y es evidencia indirecta para pausas durante estudio/programación.

Candidato a probar: una señal contextual de baja fricción con una acción física clara y permiso explícito de posponer/rechazar. Educación positiva, mascota y feedback quedan como componentes opcionales si se demuestra que reducen una barrera adicional. Detalles, fuentes, métricas y límites en `DECISION_PRELIMINAR_ENFOQUE_PRINCIPAL.md`.
