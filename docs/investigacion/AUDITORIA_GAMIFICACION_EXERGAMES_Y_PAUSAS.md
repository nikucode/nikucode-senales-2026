# Gamificación, movimiento guiado y pausas: auditoría crítica y orientación de investigación

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


> **Corrección posterior, 20-10-2026:** ver `AUDITORIA_INTEGRAL_EVIDENCIA_Y_COHERENCIA.md`, A01–A05. La precisión de denominadores de §9 no detectaba aún EE→SD y contraste inconsistente de Swartz: **no usar −12,46 min/+1.030 pasos ni subgrupos derivados como magnitudes confiables sin reanálisis**. Micro-exergames comparan modalidades de juego, no juego frente a guía sin juego; no demuestran beneficio incremental de jugar sobre el mismo movimiento. Se conserva hipótesis, no superioridad.

**Fecha:** 19-10-2026. **Estado:** investigación documental focalizada; propuesta por contrastar, sin implementación ni validación del producto.

## 1. Conclusión que cambia la decisión

**Hay fundamento para investigar una pausa cuyo movimiento resulte entretenido, no solo una aplicación que entregue premios por registrar hábitos.** La idea de movimientos guiados recuerda a los *casual exergames* y tiene antecedentes específicos de micro-pausas de dos minutos. Esto justifica ampliar los candidatos del proyecto, pero no declarar que un minijuego ya es la solución ganadora.

La evidencia favorece una arquitectura conceptual con tres preguntas separadas:

1. **Oportunidad e inicio:** ¿cómo facilitar una interrupción que realmente pueda hacerse durante trabajo/estudio?
2. **Experiencia durante la pausa:** ¿la guía o el juego facilitan moverse y hacen agradable esa experiencia?
3. **Repetición:** ¿se sigue aceptando la intervención después de la novedad, sin presión ni carga excesiva?

Un plugin de escritorio y una pausa guiada/jugable **no son alternativas excluyentes**: el primero sería el canal de invitación y la segunda el contenido de la pausa. Cada componente debe justificar su contribución por separado. No hay evidencia de superioridad para su combinación exacta en nikucode.

## 2. Método y alcance de esta auditoría

- Se contrastó el texto aportado con registros bibliográficos y abstracts de Europe PMC, textos completos originales en XML cuando estaban disponibles, páginas editoriales y copias de autor de artículos de HCI.
- Se descargaron registros y textos públicos a `/tmp/opencode/makana-evidence-audit/` para consulta local. Esta caché es temporal y **no se incorpora al repositorio competitivo**. El inventario adjunto conserva enlaces permanentes y nivel de lectura.
- Se inspeccionaron métodos, resultados y limitaciones de los estudios centrales. Descargar un artículo no equivale a leer exhaustivamente todo su contenido: el inventario diferencia texto contrastado, abstract y localización bibliográfica.
- Es una revisión dirigida a decisiones, **no una revisión sistemática nueva**, ni una evaluación AMSTAR/RoB independiente completa, ni un nuevo metaanálisis. No se reanalizaron datos individuales o todos los suplementos.
- Se priorizó correspondencia con la pregunta y calidad metodológica, no prestigio de la revista ni cantidad de citas. Se conservaron resultados positivos, nulos e inconsistencias del propio manuscrito.
- Los estudios pueden solaparse entre revisiones: no sumar sus muestras como si fueran evidencia independiente.

**Leyenda:** AF = actividad física; MVPA = actividad moderada-vigorosa; SB = comportamiento sedentario; RCT = ensayo aleatorizado; IC95% = intervalo de confianza; SMD = diferencia estandarizada de medias. Un efecto significativo no es necesariamente grande o clínicamente importante. Un resultado no significativo no prueba equivalencia ni ausencia de todo efecto.

## 3. Distinciones necesarias

| Concepto | Qué es | Qué resultado NO demuestra por sí solo |
|---|---|---|
| Gamificación | Elementos de juego en una actividad no lúdica: puntos, retos, narrativa, cooperación, progreso. | Motivación intrínseca, hábito o mejor salud. |
| Jugabilidad | Las acciones, reglas, decisiones, desafío y feedback que constituyen la experiencia de jugar. | Que un sistema decorado con puntos tenga una experiencia jugable. |
| Exergame | Juego en el que el movimiento corporal participa en la interacción. | Que sea adecuado para cualquier capacidad, contexto o duración. |
| Video de movimiento guiado | Instrucciones audiovisuales que se pueden seguir; no requiere detectar movimientos. | Que sea interactivo, que ver el video equivalga a moverse, o eficacia específica para TDAH. |
| AF diaria | Pasos, minutos o intensidad acumulados. | Menos bloques largos sentado: se puede caminar más y seguir sentado muchas horas. |
| Hábito | Automaticidad de una conducta asociada con señales/contextos. | Muchas aperturas de una app o cumplimiento durante incentivos. |
| Engagement | Interacción con el sistema, definida de forma concreta. | Beneficio físico, retención comercial o autonomía. |

**Matiz de accesibilidad:** una actividad sentada no es necesariamente sedentaria si supera el umbral energético de la definición; tampoco todo movimiento ligero sentado lo supera. No clasificar automáticamente un juego sentado como ruptura de SB ni como fracaso. Distinguir pausa de movimiento, cambio postural y ruptura de un episodio sedentario, y evaluar cada modalidad con una medida apropiada.

## 4. Evidencia de gamificación: efectos reales y límites

### G01. Nishi et al., 2024: mejor comparación agregada con controles no gamificados

**Referencia:** *Effect of digital health applications with or without gamification on physical activity and cardiometabolic risk factors: a systematic review and meta-analysis of randomized controlled trials*. **EClinicalMedicine**, 76, 102798. DOI: https://doi.org/10.1016/j.eclinm.2024.102798. Texto: https://pmc.ncbi.nlm.nih.gov/articles/PMC11701442/.

- **Corrección bibliográfica:** no es «Duggan et al.» ni *The Lancet Digital Health*. EClinicalMedicine pertenece al grupo Lancet, no a Nature.
- 36 ensayos, 49 comparaciones y 10.079 participantes en el conjunto; intervenciones de al menos ocho semanas con comparadores activos adecuados.
- Para pasos, el análisis concreto incluye 34 comparaciones y 5.119 participantes: **+489 pasos/día**, IC95% **64 a 914**, con heterogeneidad muy alta (**I²=93,8%**). Los autores califican la certeza de este resultado como alta y su magnitud como trivial conforme a su umbral de importancia.
- No hubo efecto significativo agrupado en MVPA. Peso e IMC mostraron reducciones modestas, pero no son el resultado de nuestra postulación y no deben dirigir el producto.
- No se identificó modificación significativa del efecto de AF según duración <6 frente a ≥6 meses. Esto **no demuestra equivalencia**, ni persistencia tras retirar el sistema, ni retención de clientes.
- Su definición de gamificación es amplia: incluye metas, feedback y características sociales. No permite atribuir los +489 pasos a una insignia, mascota, recompensa aleatoria o minijuego específico.

**Uso para nikucode:** justifica investigar valor añadido frente a una alternativa simple; contradice «la gamificación nunca supera controles activos». No demuestra más pausas ni una receta de diseño.

### G02. Lieder et al., 2024: conducta durante apoyo ≠ hábito posterior

**Referencia:** *Gamification of Behavior Change: Mathematical Principle and Proof-of-Concept Study*. **JMIR Serious Games**, 12, e43078. DOI: https://doi.org/10.2196/43078. Texto: https://pmc.ncbi.nlm.nih.gov/articles/PMC10998180/.

- Chatbot para beber agua: seguimiento de 40 días, con **21 días de intervención** y evaluación posterior. No fueron 40 días de intervención continua.
- Durante la intervención, el grupo de puntos optimizados informó realizar la conducta **14,71 veces**, frente a **11,64** en cada control; las comparaciones fueron significativas.
- **No** hubo una ventaja significativa entre condiciones en fuerza del hábito; después de la intervención tampoco se detectó superioridad en frecuencia de conducta.
- No se observó una diferencia significativa entre condiciones en abandono. Hubo pagos por participación y medidas de conducta autorreportadas.
- El artículo tiene inconsistencias internas de tamaños/asignación de grupos: el abstract declara 43/48/51; reclutamiento declara 132 participantes distribuidos 41/43/48; otra sección intercambia etiquetas. **No usar «N=43» como muestra total ni fijar una distribución definitiva sin aclaración adicional.** La tabla de conducta informa n=118 para ese análisis.
- El modelo calcula puntos según historia de conducta y contempla pérdidas. **No es una prueba de recompensas aleatorias de razón variable.** Los autores reconocen que no compararon directamente con otros esquemas numéricos de puntos.

**Resolución de la contradicción aportada:** sí hubo ventaja conductual durante apoyo; no se demostró ventaja en hábito ni mantenimiento posterior. Ambas cosas pueden coexistir. Tampoco demuestra que su optimización sea mejor que cualquier diseño más sencillo.

### G03. Mamede et al., 2021: antecedente cercano a oficina y abandono de la ventaja

**Referencia:** *Combining Web-Based Gamification and Physical Nudges With an App (MoveMore) to Promote Walking Breaks and Reduce Sedentary Behavior of Office Workers: Field Study*. DOI: https://doi.org/10.2196/19875. Texto: https://pmc.ncbi.nlm.nih.gov/articles/PMC8076996/.

- 298 empleados, **solo dos edificios**, uno por condición: la aleatorización por centro deja diferencias entre edificios potencialmente confundidas con la intervención.
- Cinco semanas gamificadas con componentes sociales, comparadas con app básica de metas y automonitoreo: **+634 pasos/día**, IC95% **154,2 a 1.113,8**, p=.01.
- La ventaja no se sostuvo en la fase posterior de señales físicas ni en seguimiento.
- Hubo pérdidas sustanciales de datos; SB se midió con autorreportes poco fiables. No constituye una demostración robusta de reducción de pausas sedentarias prolongadas.

**Uso:** referente mucho más pertinente al segmento de escritorio que educación física infantil; mantener resultado positivo y límites, sin prometer sostenibilidad.

### G04. YuLife, Salami et al., 2026: prometedor, preprint y selección analítica relevante

**Fuente contrastada:** https://www.medrxiv.org/content/10.64898/2026.05.31.26354543v1.full-text. Versión examinada: v1, publicada en junio de 2026; no se estableció publicación revisada por pares de este ensayo en esta auditoría.

- 1.288 participantes aleatorizados, pero **427 en análisis principal por protocolo**; 291 de estos aportaron pasos hasta mes nueve. No describirlo como un resultado analítico completo de más de mil personas.
- Diferencias de cambio según modelo: aproximadamente **+474 pasos/día a tres meses** y **+481 a nueve**, con p=.027 y p=.033 **unilaterales**. No presentarlos como p bilaterales.
- Sensibilidad a cómo se define la línea basal por novedad/sincronización, imputación de datos y exclusiones posteriores a aleatorización. El texto además presenta una discrepancia aritmética en el flujo: 1.288−859 no da 427 y el desglose de exclusiones suma 858. Requiere aclaración; no reconstruirlo por intuición.
- Los controles recibían recompensas monetarias comparables en promedio: se intenta separar valor incremental del paquete gamificado, pero no identificar qué mecánica concreta funciona.
- Hay autores de YuLife. El riesgo de mortalidad es **modelado con UK Biobank**, no muertes evitadas observadas en el ensayo.

**Uso:** evidencia emergente favorable a pasos mientras funciona el programa, no demostración de pausas, independencia de la app ni eficacia clínica de nikucode.

### G05. Motivación autónoma y experiencia social: dos advertencias

**Inagaki et al., 2026**, DOI https://doi.org/10.2196/87236: estudio de un solo brazo en diabetes, 32 consentimientos y 29 en análisis principal. Motivación con trayectoria de U invertida y máximo observado/modelado alrededor de seis meses. Sin control no se atribuye el cambio a gamificación; tampoco es retención comercial. Corregir el año 2025 de la lista.

**Corepal et al., 2018**, DOI https://doi.org/10.1136/bmjopen-2017-019663: seguimiento cualitativo de una submuestra de **19 adolescentes**, no ensayo de habilidades motoras. Competición y amigos podían motivar; también aparecieron aburrimiento, poca posibilidad percibida de ganar y frustración por no recibir premios. Es evidencia valiosa de experiencia y barreras, no de eficacia causal de insignias.

## 5. Evidencia de juego con movimiento: la línea más cercana a la nueva idea

### X01. Berglund y Orädd, 2024: micro-pausas jugables de dos minutos

**Referencia:** *Exploring the Psychological Effects and Physical Exertion of Using Different Movement Interactions in Casual Exergames That Promote Active Microbreaks: Quasi-Experimental Study*. **JMIR Serious Games**. DOI: https://doi.org/10.2196/55905. Texto: https://pmc.ncbi.nlm.nih.gov/articles/PMC11384167/.

- Dos estudios de experiencias de dos minutos con juegos controlados por movimiento: **n=80** para cuerpo superior frente a cuerpo completo y **n=40** para sentado frente a de pie.
- El control percibido fue mayor con movimientos superiores (p=.04). En el segundo estudio aumentó afecto positivo tras jugar sentado y de pie; no hubo diferencias significativas entre modalidades en disfrute, afecto positivo o desempeño.
- **Límites críticos:** reclutamiento en festival de juegos/cosplay, asignación alternada, experiencia aguda, sin comparación con pausa no jugable equivalente para aislar el juego. No prueba aceptación espontánea durante trabajo, más pausas diarias o uso mantenido. Ausencia de diferencias no equivale a equivalencia probada.
- Usaron webcam: es un método del estudio, **no un requisito del mecanismo** ni recomendación de capturar imágenes en la hackatón.

**Descubrimiento útil:** la investigación sí estudia hacer agradable el movimiento mismo, más allá de puntos añadidos a un registro. Es un antecedente específico y una razón defendible para mantener una variante jugable. No es evidencia de que saltar sea necesario ni de eficacia para TDAH.

### X02. Li et al., 2025: más AF no implica menos SB

**Referencia:** *Exergame-Based Behavior Change Interventions for Promoting Physical Activity: Systematic Review and Meta-Analysis of Randomized Controlled Studies*. **JMIR**, 27, e62906. DOI: https://doi.org/10.2196/62906. Texto: https://pmc.ncbi.nlm.nih.gov/articles/PMC12334110/.

- 20 RCT, 2.211 participantes, edades/contextos variados.
- AF global **SMD 0,19**, IC95% **0,05 a 0,33**; MVPA **0,48**, IC95% **0,12 a 0,85**; pasos **0,54**, IC95% **0,13 a 0,94**.
- **No hubo efecto agrupado significativo sobre tiempo sedentario.** Citar solo el ensayo infantil favorable y omitir esta síntesis induce a error.
- Subgrupo adulto para AF: **0,13**, IC95% **−0,16 a 0,42**, basado en tres estudios. La comparación estadística entre subgrupos infantil/adulto no fue significativa: no demuestra que solo funcione en niños.
- Tecnología, dosis y población difieren de una micro-pausa en escritorio. Las asociaciones entre mayor número de técnicas y mayor efecto no prueban que añadir más funciones cause más beneficio.

### X03. Wang et al., 2025: gamificación infantil, resultado sedentario nulo

**Referencia:** *Effectiveness of Gamification Interventions to Improve Physical Activity and Sedentary Behavior in Children and Adolescents: Systematic Review and Meta-Analysis*. DOI: https://doi.org/10.2196/68151. Texto: https://pmc.ncbi.nlm.nih.gov/articles/PMC12445784/.

16 RCT, 7.472 participantes de 6–18 años. MVPA: **SMD 0,15**, IC95% **0,01 a 0,29**. SB: **SMD 0,07**, IC95% **−0,07 a 0,22**, **p=.33**, no significativo. Los análisis de duración/teoría son exploratorios entre estudios, no ensayos aleatorizados de «usar SDT» o «superar doce semanas». No trasladar su resultado directamente a trabajadores adultos.

## 6. Por qué cuesta hacer una pausa: evidencia para no diseñar otra obligación

| Fuente | Muestra y método | Hallazgo pertinente | Consecuencia de investigación, no función ya validada |
|---|---|---|---|
| **Ojo et al., 2019**, DOI 10.3390/ijerph16162903 | 25 entrevistas a empleados de escritorio; texto contrastado. | Concentración/olvido, carga y naturaleza del trabajo, normas y juicio social, motivaciones competidoras. | Un aviso no crea permiso ni tiempo. Probar discreción, oportunidad y viabilidad de la actividad. |
| **Pachu et al., 2022; online 2020**, DOI 10.1080/07448481.2020.1786098 | 19 estudiantes, cuatro grupos focales; abstract. | Baja prioridad, beneficios distantes/poco valorados, horarios e infraestructura. | No confundir saber con poder/querer actuar; no es un artículo de BMC Public Health 20:532. |
| **Gale et al., 2025; online 2024**, DOI 10.1007/s12529-024-10334-x | 28 entrevistas tras intervención de laboratorio; abstract. | Cansancio, streaming, olvido, no querer cortar actividad, apoyo o interferencia de convivientes. | No se cuantifica una barrera dominante universal; distinguir ocio de trabajo. Revista correcta: International Journal of Behavioral Medicine. |
| **Mott et al., 2026**, DOI 10.1186/s12889-026-26719-4 | 22 entrevistas a empleados ≥50 años en homeoffice; texto contrastado. | Conflicto entre rol laboral y pausa, acción poco consciente, cultura de pausas no incorporada al hogar. | Relevante a homeoffice, pero no estimación de barreras en estudiantes. |
| **Harsanyi et al., 2026**, DOI 10.1186/s12966-026-01917-w | 30 entrevistas en Canadá; texto contrastado. | Transporte: oportunidad física; trabajo: oportunidad social; ocio: motivación automática. | No pretender una única explicación ni un único canal para todo el día. |
| **Curran et al., 2024**, DOI 10.1002/osp4.721 | 21 entrevistas en adultos con obesidad; abstract contrastado. | Bienestar físico/mental, roles, entorno, estigma y disposición al cambio. | Movimientos y modalidades adaptables; evitar vergüenza y exigencias universales. |

**Importante:** los estudios cualitativos identifican experiencias y mecanismos plausibles; no permiten afirmar «X% no hace pausas por Y» ni que un componente propuesto eliminará la barrera.

### Interrupciones cognitivas: hallazgos más matizados que el texto aportado

- **Leroy, 2009**, *Why is it so hard to do my work?*, DOI https://doi.org/10.1016/j.obhdp.2009.04.002: dos experimentos sobre residuo atencional al cambiar entre tareas; abstract y extractos editoriales contrastados, no texto completo. No mide directamente rechazo a pausas físicas. No prueba que una pausa sea perjudicial ni que escribir un marcador resuelva nuestro problema.
- **Mark, Gudith y Klocke, 2008**, DOI https://doi.org/10.1145/1357054.1357072: **experimento con 48 personas**, no simplemente observación del trabajo real. Hubo mayor estrés/frustración/esfuerzo y ejecución compensatoriamente más rápida, sin diferencia de calidad. No demuestra que toda interrupción aumente duración o que una pausa elegida tenga el mismo efecto.
- **Ma, Huang y Leach, 2024**, DOI https://doi.org/10.1145/3597503.3639079: estudio controlado **n=20**. Algunas interrupciones dominantes en pantalla aumentaron tiempo de comprensión de código; resultados dependían de tarea/tipo. Las interrupciones presenciales redujeron ciertas medidas fisiológicas de estrés, aunque subió el estrés subjetivo. No reducir el estudio a «toda interrupción eleva estrés y destruye flow».
- **ten Broeke et al., online 2022/volumen 2023**, DOI https://doi.org/10.1080/17437199.2022.2143851, **Health Psychology Review**: marco conceptual, no IJBNPA 19:114. Las transiciones de postura suelen servir a metas como trabajar, comer o ver televisión. Es razonable estudiar cómo hacerlas compatibles con esas metas; no es prueba experimental de un momento óptimo.

### Automonitoreo: un sensor no es requisito demostrado

**Compernolle et al., 2019**, DOI https://doi.org/10.1186/s12966-019-0824-3: 19 estudios, 2.800 participantes; intervenciones con automonitoreo redujeron SB a corto plazo. Solo el subgrupo con herramientas objetivas alcanzó significación para ciertos resultados, pero **no es una comparación aleatorizada aislada sensor frente a autorreporte**. Los autores no establecen que el automonitoreo explique por sí solo el efecto. No hubo efecto significativo sobre número de pausas.

No concluir «solo funciona con acelerómetro», ni que observar teclado, ratón o una ventana permita medir postura. Para el producto y su evaluación son preguntas técnicas distintas.

## 7. TikTok, Reels y la hipótesis de reutilizar sus mecanismos

### Lo que sí se pudo contrastar

1. **Montag, Yang y Elhai, 2021**, DOI https://doi.org/10.3389/fpubh.2021.641673: **revisión narrativa**, no «primer experimento empírico». Discute usos/gratificaciones y diseño sobre evidencia entonces escasa.
2. **Qin, Omar y Musetti, 2022**, DOI https://doi.org/10.3389/fpsyg.2022.932805: encuesta de 659 adolescentes y modelo PLS. Calidad percibida, experiencia de flow y síntomas de uso problemático están relacionados; no midieron dopamina ni manipularon un algoritmo para establecer causalidad.
3. **Zhang y Li, 2025**, DOI https://doi.org/10.3389/fnhum.2025.1542271: fNIRS y tarea BART en 45 universitarios seleccionados por puntuaciones extremas. La señal fNIRS prefrontal **no mide dopamina ni actividad del núcleo accumbens**, una estructura profunda. El experimento con imágenes relacionadas con videos no demuestra que un recomendador personalizado haga al cerebro incapaz de ignorar el siguiente video. El propio texto matiza algunas diferencias conductuales que el abstract describe con mayor fuerza.
4. **Nguyen et al., 2025**, DOI https://doi.org/10.1037/bul0000498: 71 estudios/98.299 participantes; asociaciones con cognición r=−.34 y salud mental r=−.21. Aquí se contrastó el abstract, no toda la metodología original; no establece por sí solo causalidad ni necesidad de imitar el feed.
5. **Wu et al., 2026**, DOI https://doi.org/10.1186/s12889-026-26220-y: **encuesta transversal de 644 adolescentes**, no intervención. La mediación estadística AF → motivación → alfabetización → síntomas no establece esa secuencia causal. No se puede prometer que una pausa reduzca adicción ni un círculo virtuoso demostrado.

### Lo que debe retirarse como conclusión científica

- «Cada swipe es exactamente una tragamonedas»: analogía, no demostración de un programa operante específico en cada plataforma/usuario.
- «Variar el ejercicio equivale a razón variable»: falso. **Variedad de contenido** y **recompensa tras un número impredecible de respuestas** son cosas distintas. Un calendario variable tampoco es lo mismo que razón variable.
- «Un prompt cronológico deja de servir porque baja la dopamina»: no demostrado por los artículos contrastados. Existen resultados favorables de avisos temporales y también resultados nulos.
- «Lieder demuestra que la recompensa impredecible es la clave»: el estudio no prueba eso.
- «Combinar prueba social, aleatoriedad y feedback tiene más evidencia que cualquier app de pausas»: no hay comparación directa que sostenga esta superioridad.
- No se localizó una referencia académica verificable para **The Architecture of Compulsion: Variable Reinforcement Schedules in Social Media Design (IJIRT)** con los datos facilitados. Mantener excluida como respaldo, sin afirmar que es inexistente.

### Qué puede reutilizarse sin invocar adicción

**Inicio sencillo, instrucciones claras, feedback rápido, disfrute del movimiento, posibilidad de elegir y variedad acotada** son mecanismos investigables. Se puede preservar una señal relativamente estable para iniciar y variar el contenido después: no es necesario contraponer hábito estable y experiencia variada.

La recompensa hipotéticamente útil puede ser la experiencia misma de la pausa; no tiene que ser un premio externo ni una espera impredecible. Esta es una **hipótesis de diseño**, no un efecto probado para nikucode. Mantener salida clara y no prolongar la sesión para ganar más premios.

## 8. Redes sociales y bloqueo: evidencia adyacente, no sustituta de pausas

**Zhang, Brackbill, Yang y Centola, 2015**, DOI https://doi.org/10.1016/j.pmedr.2015.08.005, **Preventive Medicine Reports**: RCT con 217 posgraduados y trece semanas. Ver inscripciones de 4–6 compañeros anónimos produjo más inscripciones (6,3 frente a 4,5 en control; p=.02); el aumento autorreportado de ejercicio fue 1,6 frente a 0,8 días semanales. **No son Hagger et al. ni Computers in Human Behavior**, y no estudia un feed ni pausas laborales. No demuestra que observar desconocidos saltar en video reproduzca el efecto de una red de pares.

**Castelo et al., 2025**, DOI https://doi.org/10.1093/pnasnexus/pgaf017: RCT de bloqueo del acceso a internet del smartphone (wifi y datos), no de toda conexión de la persona. 467 participantes; 119 cumplieron criterio de bloqueo ≥10/14 días. Los análisis principales fueron por intención de tratar, no solo los 119 cumplidores. La reducción 314→161 min/día corresponde al grupo intervenido con capturas disponibles; **no es una media observada en los 467**. Hubo mejoras en bienestar/atención, pero el ensayo no prueba nuestra conducta de pausas ni superioridad del bloqueo sobre gamificación. La equivalencia divulgativa con «diez años» no significa rejuvenecimiento cognitivo clínico.

**Hematabadi et al., 2026**, DOI https://doi.org/10.1177/10901981261458638: revisión **narrativa** de 104 estudios; abstract contrastado. Respalda discutir efectos dependientes del contexto, no una receta causal «TikTok al servicio del movimiento».

**Paschmann et al., 2025**, DOI https://doi.org/10.1177/00222437241275927, **Journal of Marketing Research**: datos de una app de investigación de mercado, 18.952 usuarios; abstract y síntesis editorial de AMA contrastados. Engagement comercial y actividad de valor para la empresa no equivalen a salud. No es Journal of Service Research.

## 9. Corrección de la evidencia previa sobre avisos de escritorio

### Otras revisiones de la lista: no convertir resultados heterogéneos en «solo funciona combinado»

- **Zhang et al., 2025**, DOI https://doi.org/10.2196/59943: **26 ensayos/3.800 participantes** con enfermedades crónicas en la revisión; **16 ensayos/1.770** corresponden correctamente al metaanálisis de tiempo sentado, no al total. Reducción agrupada de ese resultado −30,80 min/día, IC95% −49,79 a −11,82; sin diferencias significativas en duración de episodios o pausas. No atribuir la reducción a juego ni generalizarla a adultos sanos.
- **Wang et al., 2025**, DOI https://doi.org/10.1177/20552076251353731: 12 estudios de chatbots; AF global **SMD 0,20**, IC95% 0,04 a 0,37, p=.02: no es solo «marginal». No hubo resultado significativo en SB, **SMD 0,32**, IC95% −0,54 a 1,19, p=.46; intervalo muy amplio. No demuestra que la IA nunca sirva: no justifica exigirla como componente.
- **Lee y Park, 2025**, DOI https://doi.org/10.1038/s41746-025-01827-4, **npj Digital Medicine**: 18 RCT de intervenciones digitales independientes; AF **SMD 0,324**, certeza baja. No es EClinicalMedicine ni establece imposibilidad de beneficio sin telecoaching.
- **Mazéas et al., 2025**, DOI https://doi.org/10.2196/78376: se localizó y contrastó la publicación revisada por pares en JMIR, no solo el preprint. RCT de **50 pacientes** con obesidad o diabetes tipo 2; 42 en análisis modificado por intención de tratar y pérdidas posteriores. Paquete Kiplin de juego, grupo y sesiones supervisadas: diferencia de cambio en pasos **+1.085** durante intervención e **+1.775** en el periodo de seguimiento, frente a atención presencial; no hubo diferencia significativa en SB entre resultados secundarios. No aísla la contribución de gamificación; tampoco es evidencia de superioridad de una app autónoma.
- **Rouyard et al., 2025**, DOI https://doi.org/10.1016/S2468-2667(25)00038-6, **The Lancet Public Health**: abstract contrastado; 36 revisiones/214 estudios únicos. Escritorios ajustables: hasta −75 min/día sentado en ciertas comparaciones, no efecto de una app. Estrategias psicosociales pueden aportar, pero no se puede convertir «hasta 33%» en incremento esperado de añadir nuestro plugin. No se verificó en el texto completo la afirmación aportada de que solo intervenciones >6 meses fueron significativas; no usarla como regla.

### Avisos: precisión por resultado

**Leppe-Zamora et al., 2025**, DOI https://doi.org/10.1186/s12966-025-01781-0: se contrastó ahora el texto completo, no solo el abstract.

- La revisión reúne 18 publicaciones/1.164 trabajadores; **no todos contribuyen a cada estimación**.
- **Tiempo sentado laboral:** ocho estudios/n=325, −12,46 min/jornada, IC95% −18,12 a −6,80. Incluye avisos solos y estrategias combinadas. El subgrupo que el artículo denomina «solo avisos» fue −11,79 min, IC95% −17,73 a −5,86; algunos estudios de ese grupo tenían apoyos adicionales.
- **Pasos laborales:** tres estudios/n=165, +1.030 pasos/jornada, IC95% 816 a 1.244. No son pasos de todo el día ni una estimación basada en 1.164 personas.
- **Transiciones sentado-de pie laborales:** sin diferencia significativa, MD +0,67, IC95% −2,38 a 3,73. Tampoco fue significativa la reducción agrupada de tiempo sentado de todo el día.
- El abstract resume certeza baja–moderada. Su tabla GRADE distingue **moderada para tiempo sentado laboral**, **alta para pasos laborales** y **muy baja para transiciones**. Hay discrepancias de síntesis internas; citar la certeza por resultado y sección, no una etiqueta uniforme.

**Conclusión corregida:** un canal de escritorio tiene respaldo relativo para reducir modestamente tiempo sentado durante trabajo; **no está demostrado con la misma fuerza que aumente la frecuencia de pausas**. No abandona la hipótesis inicial, pero precisa qué parte falta comprobar.

## 10. Cómo estructurar la propuesta a partir de lo revisado

Esto organiza la investigación conceptual; **no es copy final, storyboard, elección definitiva ni especificación competitiva preconstruida**.

### A. Resultado y segmento

- Mantener el problema de la postulación: facilitar pausas físicas durante sesiones prolongadas frente al computador, sin añadir otra obligación.
- El segmento propuesto —estudiantes y trabajadores de escritorio/homeoffice— encaja mejor con Ojo, Pachu, Mott y evidencia de avisos que con extrapolar de educación física infantil.
- No tratar a estudiantes, empleados con permiso para pausar y empleados con restricciones como una población homogénea. El primer piloto futuro debe acotar un contexto.

### B. Mecanismo candidato por capas

| Capa | Candidato | Fundamento | Incertidumbre que debe poder refutarse |
|---|---|---|---|
| Acceso | Canal en escritorio, potencialmente plugin. | Correspondencia con contexto y evidencia de prompts. | ¿Evita abrir otra app o añade distracción? ¿En qué plataforma tendría alcance real? |
| Oportunidad | Invitación breve, elegible, posponible y descartable. | Barreras COM-B y costes de interrupción. | ¿Llega en momentos viables? Posponer podría ser aplazar indefinidamente. |
| Inicio | Acción pequeña y explícita, sin planificación obligatoria. | Barreras de conocimiento/recursos; evidencia indirecta de instrucción. | ¿Baja la fricción frente a una invitación genérica? |
| Pausa | Guía audiovisual sencilla; juego corporal opcional como variante. | Micro-exergames y evidencia de AF. | ¿El juego aporta sobre la misma guía no jugable o exige demasiado aprendizaje? |
| Repetición | Experiencia agradable, variedad limitada, retorno voluntario. | Beneficios modestos y problemas de novedad/competencia. | ¿Se sigue usando y haciendo pausas después de varias exposiciones? |

**Prioridad razonada:** conservar un comparador simple y estudiar si jugar durante la pausa añade valor. La postura «no incluir juego nunca» y la postura «hacerlo adictivo garantiza éxito» van más allá de la evidencia.

### C. Qué rescatar de los videos que mencionas

La oportunidad es **externalizar la secuencia**: seguir una indicación visible en vez de planificar una rutina, y que la acción corporal tenga un propósito lúdico inmediato. Puede explorarse sin afirmar beneficios particulares para TDAH.

No asumir que saltar, movimientos rápidos o levantar brazos por encima de la cabeza sean apropiados para todos. Investigar modalidades de bajo impacto, espacio disponible, ruido, equilibrio y alternativas sentadas; no recomendar superar dolor, mareo o fatiga. Las acciones concretas requieren revisión de seguridad por profesionales apropiados antes de uso real.

Mantener como alternativas guía sin juego, audio y salida fuera de pantalla. No existe evidencia aquí de que mirar otra pantalla sea necesario para toda pausa.

### D. Qué aporta y qué no aporta un plugin

Un plugin puede reducir navegación y hacer accesible una invitación en el entorno habitual. **No demuestra por sí solo** que la persona esté sentada, que no esté en reunión, que sea oportuno interrumpirla o que complete el movimiento. Una extensión de navegador no cubre necesariamente trabajo en otras aplicaciones. La plataforma se elegirá con una pregunta técnica concreta durante el evento.

No se justifica IA por defecto. Una cámara puede cerrar un bucle de interacción en un exergame, pero añade permisos, errores y datos personales; no es requisito para probar si una guía se entiende o resulta deseable. En la hackatón no usar imágenes, telemetría ni datos reales de participantes.

## 11. Evaluación que separa las contribuciones

**Antes del evento:** investigación, preguntas metodológicas neutrales y consulta a organización sobre trabajo previo y pruebas con personas. Bases vigentes sección 9: todo el trabajo debe hacerse durante el evento; no producir aquí código ni artefactos competitivos específicos.

**Durante el evento, si autorizado:** seleccionar una sola incertidumbre y crear el artefacto entonces. Un test pequeño de comprensión/aceptabilidad puede comprobar interpretación, controles y fricción; **no eficacia conductual ni retención**. No asumir que registros individuales pasan a estar permitidos por quitar nombres: anonimización, agregación y consentimiento no sustituyen la autorización de Makana.

**Piloto posterior, fuera de esas restricciones y con consentimiento/protección adecuada:**

1. **Evaluar invitación:** señal frente a no señal en oportunidades previamente definidas. Pregunta: ¿inicia más pausas?
2. **Evaluar jugabilidad:** misma duración, movimientos, señal y calidad visual; guía simple frente a guía con mecánica de juego. Pregunta: ¿añade valor el juego? Si se cambian ejercicios/intensidad/feedback a la vez, se evalúa un paquete, no «el juego» aisladamente.
3. Para **inicio**, asignar la invitación de forma que el formato sea conocido antes de decidir y analizar todas las oportunidades asignadas. Para **experiencia**, se puede asignar tras aceptar la pausa, pero eso solo informa sobre quienes aceptaron. No comparar únicamente los que jugaron e inferir causalidad sobre inicio.
4. **Evaluar mantenimiento:** exposiciones y días repetidos, con comparación y línea basal suficientes; distinguir uso durante apoyo de conducta tras retirarlo. No elegir duración ni muestra por conveniencia y presentarlas como suficientes para demostrar un hábito.

### Métricas y denominadores

- **Principal conductual:** oportunidades elegibles asignadas seguidas de una pausa válida en ventana predefinida / todas las oportunidades elegibles asignadas. Definir qué es válida, para quién y cómo se confirma.
- Separar inicio, realización y duración; distinguir autorreporte de observación/medición. Un botón «listo» no es verificación objetiva.
- **Patrón sedentario:** minutos sentados, distribución de episodios prolongados y transiciones, si existe medición válida y consentida. Actividad de teclado/ratón no equivale a postura; un contador de pasos no siempre distingue postura.
- **Valor lúdico:** disfrute, comprensión, carga mental, capacidad de terminar. Adaptar cuestionarios sin llamarlos validados si se alteran.
- **Coste y daños:** interferencia y reanudación, rechazo/desactivación, presión/culpa, esfuerzo no deseado, incidencias físicas y tiempo adicional en pantalla.
- **Repetición útil:** continuidad voluntaria de la función y pausas, incluyendo abandonos y razones cuando se permita recogerlas. No deducir retención de quienes completaron el estudio.
- No agrupar todos los avisos de una persona como si fueran participantes independientes: un análisis longitudinal debe contemplar correlación intrapersonal, novedad y tendencias temporales.

**Decisión:** avanzar con una capa lúdica solo si aporta al resultado predefinido sin incrementar de forma inaceptable fricción, interferencia o riesgos. Si aumenta agrado pero no inicio, el hallazgo sirve para experiencia, no para declarar resuelta la barrera de empezar. La ausencia de superioridad con una muestra pequeña mantiene incertidumbre; no demuestra equivalencia.

## 12. Afirmaciones defendibles y no defendibles

**Defendibles:**

- Hay ensayos y revisiones que encuentran beneficios promedio modestos de gamificación en actividad física frente a controles no gamificados.
- Existen estudios específicos de micro-exergames con experiencias inmediatas positivas; su uso sostenido como pausa laboral sigue siendo una pregunta.
- Concentración, carga de trabajo, normas sociales, cansancio y capacidad física pueden dificultar una pausa, no solo el olvido.
- Queremos investigar si un canal de escritorio de baja fricción y una pausa guiada, opcionalmente jugable, ayudan a iniciar movimiento en un contexto acotado.

**No defendibles:**

- Nuestra app formará hábitos, evitará dolor o tratará uso problemático/TDAH porque esos componentes ya tienen papers.
- Copiar recompensas variables de TikTok es una estrategia probada para romper sedentarismo.
- Más pasos o más engagement garantizan menos periodos largos sentado.
- La solución es superior a las apps existentes, tiene mercado validado o dispone de una probabilidad estadística conocida de éxito.

## 13. Cierre y siguiente paso único

**Cambio respecto de la síntesis previa:** mantener el aviso sencillo como comparador, pero incorporar explícitamente **guía corporal y casual exergame** como línea con antecedentes propios, no reducir toda jugabilidad a mascota/puntos/rachas. La evidencia no obliga a elegir juego ni a descartarlo.

**Siguiente paso:** contrastar con Javi cuál barrera intenta resolver su propuesta de plugin —detectar oportunidad, permitir empezar, guiar movimiento o facilitar volver— y elegir una sola contribución que merezca compararse con la alternativa simple durante el evento. No hace falta definir ahora toda la app.

**Documentación complementaria:** `INVENTARIO_FUENTES_GAMIFICACION_Y_BARRERAS.md` registra correcciones, nivel de lectura y referencias todavía pendientes. Este informe añade evidencia y corrige interpretaciones; no convierte las hipótesis en resultados observados del equipo.
