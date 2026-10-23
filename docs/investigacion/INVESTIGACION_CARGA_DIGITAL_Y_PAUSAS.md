# Investigación ampliada: sobrecarga, uso digital, atención y pausas

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Proyecto:** Hackatón Señales 2026 · Equipo nikucode
**Actualizado:** 18 de octubre de 2026
**Objetivo:** documentar qué permite concluir la investigación sobre la combinación de agotamiento, exigencias que no siempre se pueden posponer, consumo digital prolongado y dificultad para interrumpir el sedentarismo.
**Uso previsto:** apoyar decisiones de diseño antes de la hackatón; no diagnosticar a integrantes ni justificar una solución por adelantado.

---

## 1. Resumen ejecutivo

La postulación describe una experiencia mixta: dos integrantes pasan muchas horas frente al computador; saben que necesitan moverse, pero pueden seguir por concentración, obligación de terminar tareas, agotamiento o porque el descanso termina ocurriendo en otra pantalla. Las estrategias anteriores —rutinas, anotaciones y recordatorios— se han convertido en obligaciones difíciles de sostener.

La investigación externa **no respalda una única causa**. La evidencia que encontramos se organiza en cinco líneas:

1. **Carga académica y agotamiento:** un estudio de 2026 con 424 universitarios de Chile encontró una asociación fuerte entre exigencias académicas y agotamiento emocional. El diseño fue correlacional y transversal, por lo que no demuestra causalidad ni estima la prevalencia nacional.
2. **Tiempo sedentario y recordatorios:** un metaanálisis de 2025 de 18 estudios con 1.164 trabajadores de oficina había reportado una reducción de sedentarismo, pero el equipo detectó posteriormente errores de extracción/cálculo en sus resultados agregados. Las cifras de efecto se han suspendido como estimaciones fiables hasta resolver la discrepancia con los datos originales. No usar el valor de −12,46 minutos en presentaciones o decisiones.
3. **Avisos para estudiantes:** en un ensayo aleatorizado de 10 días con 57 universitarios que estudiaban en casa, los mensajes motivacionales digitales no aumentaron significativamente la probabilidad de hacer pausas activas. Esto impide asumir que más notificaciones resuelven por sí solas el problema.
4. **Uso problemático del celular y procrastinación:** un metaanálisis de 75 estudios con 48.031 estudiantes encontró una correlación positiva moderada (r = 0,376; IC 95 %: 0,345–0,406). Es una asociación, no prueba de que el celular cause procrastinación ni de cuál fenómeno precede al otro.
5. **Diseño de plataformas y atención:** existen mecanismos de diseño como desplazamiento infinito, reproducción automática, notificaciones y feeds personalizados que reducen señales naturales de detención y favorecen continuar consumiendo contenido. En 2026, la Comisión Europea emitió conclusiones regulatorias **preliminares** sobre TikTok y Meta por riesgos relacionados con el diseño; no equivalen a una sentencia final ni permiten afirmar que todas las plataformas o todo uso sean adictivos.

**Conclusión de trabajo:** el problema debe entenderse como una interacción posible entre demandas reales, energía limitada, fricción para interrumpir una tarea y herramientas digitales que facilitan continuar en pantalla. Esa síntesis es una hipótesis de diseño compatible con las fuentes, no una causalidad demostrada para nikucode.

La solución no debe prometer prevenir clínicamente el dolor ni revertir el agotamiento. En dos días podemos probar si una intervención ficticia es comprensible, de baja fricción, respetuosa de la autonomía y capaz de facilitar una pausa en un flujo de demostración. No podemos demostrar cambios de hábitos duraderos.

---

## 2. Cómo leer las cifras de este documento

- **Metaanálisis / revisión sistemática:** sintetiza varios estudios; su calidad sigue dependiendo de las investigaciones incluidas y de la comparabilidad de sus métodos.
- **Ensayo aleatorizado:** puede ofrecer evidencia causal bajo las condiciones estudiadas, pero no necesariamente se generaliza a otras poblaciones o a una intervención distinta.
- **Estudio correlacional:** indica que dos variables cambian juntas; no prueba causa y efecto.
- **IC 95 %:** intervalo de confianza del 95 % del estimador, no un rango que contenga el 95 % de los resultados individuales.
- **r:** correlación; un valor positivo indica asociación positiva, no porcentaje de causalidad.
- **d / g:** tamaños de efecto estandarizados; no son porcentajes de personas beneficiadas.
- **β y R² en modelos estructurales:** describen relaciones estimadas por el modelo. En un diseño transversal, no deben interpretarse como prueba causal.

Los porcentajes y efectos que aparecen abajo no deben sumarse entre estudios distintos ni presentarse como cifras de Chile si la muestra no lo es. No todos los estudios midieron lo mismo ni incluyeron el mismo tipo de personas.

---

## 3. Evidencia por tema

### 3.1. Sobrecarga académica y agotamiento en Chile

**Fuente central:** Jorquera-Gutiérrez, R., Guerra-Díaz, F. y Martinez-Luna, L. (2026). *Academic demands and resources as predictors of emotional exhaustion and academic engagement in Chilean university students*. Frontiers in Psychology, 17, 1885652. DOI: https://doi.org/10.3389/fpsyg.2026.1885652

**Diseño y muestra:** estudio transversal, no experimental y correlacional; 424 estudiantes de pregrado de una universidad del norte de Chile. Muestreo intencional no probabilístico. Los datos se recopilaron entre septiembre y noviembre de 2024.

**Datos principales:**
- Las demandas académicas se asociaron positivamente con el agotamiento emocional (β = 0,88; p < 0,001; R² = 0,78 en el modelo reportado).
- Los recursos académicos se asociaron positivamente con el engagement académico (β = 0,72; p < 0,001; R² = 0,52).
- La covarianza entre recursos y demandas fue negativa (β = −0,35; p < 0,001).

**Qué significa:** este estudio local apoya que el agotamiento estudiantil se entienda en relación con exigencias y recursos del contexto, en vez de atribuirlo automáticamente a falta de voluntad. El diseño y el muestreo no permiten afirmar que las demandas causan agotamiento ni extrapolar los porcentajes o magnitudes a todas las personas universitarias de Chile.

**Aplicación al proyecto:** la solución de nikucode no debe tratar las pausas omitidas como fallas morales ni fingir que una interfaz puede eliminar una sobrecarga de tareas real. Puede abordar una microbarrera —hacer más viable interrumpir por un momento—, no resolver por sí sola las causas estructurales del cansancio.

### 3.2. Qué sabemos sobre el burnout estudiantil (y qué no)

**Fuente:** Madigan, D. J., Kim, L. E. y Glandorf, H. L. (publicación en línea 2023; número de revista 2024). *Interventions to reduce burnout in students: A systematic review and meta-analysis*. European Journal of Psychology of Education, 39, 931–957. DOI: https://doi.org/10.1007/s10212-023-00731-3

**Diseño y muestra:** 17 estudios de intervención (10 ensayos aleatorizados y 7 cuasiexperimentales), 2.462 estudiantes de secundaria y educación superior.

**Datos principales:**
- Efecto agregado sobre burnout total: g⁺ = 0,90; IC 95 % [0,04, 1,75]; p = 0,02; k = 14.
- Heterogeneidad extremadamente alta para ese resultado: I² = 94,31 %.
- Para agotamiento específicamente: g⁺ = 0,47; IC 95 % [−0,03, 0,97]; p = 0,06; k = 9. El intervalo incluye cero y el resultado no alcanzó significación estadística convencional.

**Interpretación:** hay indicios de que algunas intervenciones pueden ayudar con burnout estudiantil, pero los resultados varían mucho por tipo de intervención, síntoma y estudio. No corresponde prometer que un producto breve resuelve el agotamiento.

**Precisión terminológica:** la OMS clasifica burnout como fenómeno ocupacional asociado al estrés crónico laboral no gestionado, no como enfermedad médica, y advierte que la definición se refiere al contexto laboral. La investigación académica sí estudia constructos de burnout estudiantil, pero para nuestro proyecto es más prudente hablar de **agotamiento percibido** o **sobrecarga**, sin diagnosticar.

OMS: https://www.who.int/standards/classifications/frequently-asked-questions/burn-out-an-occupational-phenomenon

### 3.3. Recordatorios para interrumpir el sedentarismo en oficinas — referencia bajo auditoría

**Fuente bibliográfica:** Leppe-Zamora, J. et al. (2025). *The effect of computer prompt in breaks of sedentary behaviour among office workers: a systematic review and meta-analysis*. International Journal of Behavioral Nutrition and Physical Activity, 22, 75. DOI: https://doi.org/10.1186/s12966-025-01781-0

**Diseño y muestra reportados:** revisión de 18 estudios y 1.164 trabajadores de oficina; mediana de duración de intervención de 8 semanas (rango 1–24). Algunos estudios usaron recordatorios solos y otros combinaron avisos con escritorios regulables u otras medidas.

**Corrección de auditoría:** el equipo detectó problemas de extracción/cálculo: errores estándar de Swartz tratados como desviaciones estándar, orientación inconsistente de grupos entre resultados y tamaños de grupo incorrectos para pasos. El equipo informa que reprodujo los agregados con esas entradas. Por ello quedan suspendidas las cifras de −12,46 minutos y +1.030 pasos como estimaciones fiables hasta resolver la discrepancia con tablas/datos originales. Esta nota integra la auditoría anterior del equipo; no implica una nueva reproducción independiente en esta edición.

**Aplicación:** conservar el artículo como referencia rastreable, pero no usar sus números de efecto en un pitch ni para decir que el recordatorio es el mejor mecanismo. Los ensayos estudiantiles con resultados nulos deben permanecer en la comparación. La decisión entre señal digital, señal física, transición o cambio ambiental necesita otra justificación y una prueba de bajo coste.

Texto completo: https://pmc.ncbi.nlm.nih.gov/articles/PMC12164069/

### 3.4. Avisos de pausas activas mientras estudiantes estudian en casa

**Fuente:** Teuber, M., Leyhr, D., Moll, J. y Sudeck, G. (2022). *Nudging digital physical activity breaks for home studying of university students—A randomized controlled trial during the COVID-19 pandemic with daily activity measures*. Frontiers in Sports and Active Living, 4, 1024996. DOI: https://doi.org/10.3389/fspor.2022.1024996

**Diseño y muestra:** ensayo aleatorizado de 10 días con 57 universitarios en el suroeste de Alemania. Un grupo recibió mensajes motivacionales diarios con videos de pausas activas; el grupo de comparación obtuvo un enlace único a una biblioteca de videos.

**Resultado:** la intervención de mensajes diarios no tuvo efecto estadísticamente significativo sobre la probabilidad de participar en pausas en un día determinado (coeficientes reportados entre 0,69 y 0,75; p > 0,3). Más tiempo de estudio en casa en un día se asoció con más probabilidad de hacer una pausa (coeficientes reportados entre 1,07 y 1,11; p < 0,001).

**Interpretación:** es una advertencia directa contra asumir que enviar más mensajes aumentará automáticamente las pausas. La muestra era pequeña, la intervención duró solo 10 días y el contexto fue la pandemia; un resultado nulo de una intervención no demuestra que todos los avisos sean inútiles.

Texto completo: https://www.frontiersin.org/journals/sports-and-active-living/articles/10.3389/fspor.2022.1024996/full

### 3.5. Uso problemático del teléfono y procrastinación

**Fuente:** Zhou, X., Yang, F., Chen, Y. y Gao, Y. (2024). *The correlation between mobile phone addiction and procrastination in students: A meta-analysis*. Journal of Affective Disorders, 346, 317–328. DOI: https://doi.org/10.1016/j.jad.2023.11.020

**Diseño y muestra:** metaanálisis de 75 estudios y 48.031 estudiantes.

**Resultado principal:** correlación positiva entre uso problemático del teléfono y procrastinación: r = 0,376; IC 95 % [0,345, 0,406]. La asociación variaba según el nivel educativo, sexo, cultura y herramientas de medición.

**Qué no significa:** no quiere decir que el celular explique el 37,6 % de la procrastinación; r no es un porcentaje causal. La evidencia de correlación no resuelve si el uso problemático favorece la postergación, si las personas que postergan recurren más al celular o si ambas cosas se relacionan con otros factores, como el estrés o el estado de ánimo.

**Aplicación:** mirar el celular o jugar puede funcionar como escape inmediato ante cansancio, tarea desagradable o tensión; esa explicación es plausible para investigar, pero no está demostrada en el equipo. La intervención debe distinguir descanso elegido de consumo que se alarga y deja a la persona menos recuperada.

Ficha de PubMed: https://pubmed.ncbi.nlm.nih.gov/37979628/

### 3.6. Uso problemático de redes sociales y salud mental

**Fuente:** *Problematic Social Media Use in Adolescents and Young Adults: Systematic Review and Meta-analysis* (2022). JMIR Mental Health. DOI: https://doi.org/10.2196/33450

**Diseño y muestra:** 18 estudios y 9.269 adolescentes y adultos jóvenes.

**Correlaciones estimadas:**
- Síntomas depresivos: r = 0,273; p < 0,001.
- Ansiedad: r = 0,348; p < 0,001.
- Estrés: r = 0,313; p < 0,001.

**Interpretación:** uso problemático y síntomas de salud mental estaban asociados en las muestras estudiadas. Estos resultados no demuestran causalidad ni equivalen al efecto de usar redes durante cierto número de minutos. La revisión mide uso problemático mediante distintas escalas; no debe extrapolarse a toda persona que usa redes sociales.

**Aplicación:** evitar mensajes simplistas del tipo «las redes causan todo». El diseño de nuestro prototipo puede reconocer que la plataforma captura atención y hace fácil seguir, a la vez que no culpa a la persona por usarla para descansar o regularse.

Artículo: https://pmc.ncbi.nlm.nih.gov/articles/PMC9052033/

### 3.7. ¿Las plataformas están diseñadas para que sigamos usando?

**Fuente institucional actual:** Comisión Europea, conclusiones preliminares sobre TikTok (6 de febrero de 2026) y Meta/Instagram/Facebook (10 de julio de 2026), en el marco del Reglamento de Servicios Digitales.

- TikTok: https://digital-strategy.ec.europa.eu/en/news/commission-preliminarily-finds-tiktoks-addictive-design-breach-digital-services-act
- Meta: https://digital-strategy.ec.europa.eu/en/news/commission-preliminarily-finds-addictive-design-instagram-and-facebook-breach-digital-services-act

La Comisión identifica elementos como desplazamiento infinito, reproducción automática, notificaciones push y recomendaciones altamente personalizadas. En ambos casos, las conclusiones son **preliminares**; el procedimiento permite a las compañías responder y no equivale a una decisión final.

**Cómo expresarlo rigurosamente:** el diseño de algunas plataformas incorpora mecanismos que reducen las señales para detenerse y facilitan continuar consumiendo contenido. Hay preocupación científica y regulatoria por sus riesgos. No debemos afirmar que todas las redes son igual de adictivas, que toda utilización es dañina ni que el diseño explica por sí solo la experiencia del equipo.

**Aplicación:** si el descanso se desplaza al celular o a un juego, la persona puede seguir sentada y prolongar la exposición a pantalla. La propuesta debería facilitar un paso hacia una pausa física cuando sea oportuno, no satanizar el ocio digital ni exigir abandonar el teléfono por completo.

### 3.8. ¿Qué aporta un experimento de limitar internet móvil?

**Fuente:** Castelo, N., Kushlev, K., Ward, A. F., Esterman, M. y Reiner, P. B. (2025). *Blocking mobile internet on smartphones improves sustained attention, mental health, and subjective well-being*. PNAS Nexus, 4(2), pgaf017. DOI: https://doi.org/10.1093/pnasnexus/pgaf017

**Diseño y muestra:** ensayo aleatorizado preregistrado, con bloqueo de internet móvil durante dos semanas en un diseño cruzado; 467 participantes aceptaron inicialmente participar. Las llamadas y SMS permanecían disponibles y seguía siendo posible usar internet en otros dispositivos.

**Datos principales:**
- En el grupo de intervención, el tiempo de pantalla medio reportado en el teléfono bajó de 314 a 161 minutos diarios durante las dos semanas; después subió a 265 minutos en el seguimiento.
- Los efectos pre-pos intervención agregados reportados fueron d_z = 0,45 para bienestar subjetivo, d_z = 0,56 para salud mental y d_z = 0,23 para atención sostenida objetiva.
- El 90,7 % mejoró en al menos uno de esos tres indicadores en las observaciones combinadas.
- La implementación fue difícil: solo 119 de 467 personas comprometidas (25,5 %) cumplieron el criterio estricto preregistrado de bloqueo activo durante al menos 10 de 14 días. Hubo también pérdida de participantes en el seguimiento.

**Interpretación:** ofrece evidencia causal de que reducir el acceso permanente a internet móvil pudo mejorar varios resultados a corto plazo en esa muestra. No demuestra que prohibiciones rígidas sean sostenibles ni que funcionen igual en Chile o para todos. La dificultad de adherencia es especialmente relevante.

**Aplicación:** cambiar las condiciones ambientales a veces puede ser más realista que pedir más fuerza de voluntad; pero debemos buscar un apoyo voluntario, reversible y compatible con necesidades reales de trabajo y comunicación.

Texto completo: https://pmc.ncbi.nlm.nih.gov/articles/PMC11834938/

### 3.9. Concentración, tareas sin terminar y cambio de actividad

**Fuente:** Leroy, S. (2009). *Why is it so hard to do my work? The challenge of attention residue when switching between work tasks*. Organizational Behavior and Human Decision Processes, 109(2), 168–181. DOI: https://doi.org/10.1016/j.obhdp.2009.04.002

El artículo presenta dos experimentos sobre el cambio entre tareas y describe cómo la atención puede seguir parcialmente ligada a una tarea anterior que quedó sin terminar, perjudicando el desempeño en la tarea siguiente.

**Limitación:** no estudia directamente micropausas ni prueba que guardar un «siguiente paso» en una interfaz mejore la salud. Es un fundamento que hace razonable probar si una manera simple de dejar un punto de reanudación reduce la fricción de interrumpir; esa mejora sigue siendo hipótesis.

### 3.10. «Disociar» frente a una pantalla: usar el término con cuidado

En el habla cotidiana, «disociar» puede significar quedarse en piloto automático, perder la noción del tiempo, distraerse o usar una pantalla para desconectar. En clínica, la disociación es un término técnico para experiencias relacionadas con interrupciones o discontinuidades en la integración de conciencia, memoria, identidad, emoción, percepción o conducta. No debemos inferir una condición clínica a partir de la expresión cotidiana usada en la postulación.

Un metaanálisis de evaluación momentánea en la vida diaria revisó 25 artículos y sintetizó 17; estimó que la divagación mental (*mind-wandering*) ocupaba aproximadamente el 34,5 % de la vida diaria. Es una estimación amplia de pensamiento autogenerado, no una tasa de disociación clínica ni una estadística de uso de redes. Las definiciones y técnicas de muestreo modifican las estimaciones.

Fuente: *Ecological momentary assessment of mind-wandering: meta-analysis and systematic review* (Scientific Reports, 2023). https://www.nature.com/articles/s41598-023-29854-9

**Aplicación:** en el documento de producto usar descripciones observables como «seguir deslizando sin haberlo decidido», «perder la noción del tiempo» o «desconectarse mentalmente» si eso representa lo que quieren decir. No diagnosticar ni usar «disociación» como nombre técnico de la función.

---

## 4. Síntesis: qué hipótesis siguen abiertas

Estos hallazgos permiten formular un sistema de hipótesis relacionadas, no una cadena causal confirmada:

1. **Demanda/agotamiento:** las tareas obligatorias y el cansancio pueden reducir la capacidad disponible para autocuidado y recuperación.
2. **Coste de interrupción:** cuando una tarea sigue abierta, la persona puede posponer la pausa para no perder el hilo o no dejar el trabajo incompleto.
3. **Descanso digital ambiguo:** usar el celular, redes o juegos puede sentirse como descanso y, al mismo tiempo, mantener a la persona en la misma postura sedentaria o prolongar el tiempo de pantalla.
4. **Diseño de plataformas:** feeds continuos, autoplay y notificaciones pueden facilitar que la actividad continúe sin una decisión explícita de seguir.
5. **Fricción y culpa:** el registro manual y las rachas pueden transformar el autocuidado en una tarea más, haciendo costoso retomar después de ignorar una oportunidad.
6. **Momento y autonomía:** una intervención tolerable podría necesitar esperar un punto conveniente, ofrecer una pausa breve y permitir aplazarla sin penalización.

La evidencia externa respalda que estas áreas merecen explorarse. No confirma que cada mecanismo esté presente en Alex y Javier ni cuál pesa más. No hace falta resolver todas las causas para la hackatón: basta con elegir una barrera concreta, justificada por la postulación y por la evidencia, y diseñar una prueba honesta.

## 5. Implicaciones de diseño: qué evitar y qué probar

### Evitar

- Interpretar cada pausa omitida como falta de disciplina.
- Prometer que una función curará el agotamiento, prevendrá dolor o cambiará permanentemente un hábito.
- Añadir una aplicación que requiera registro continuo, rachas o anotaciones obligatorias sin demostrar su necesidad.
- Usar alertas intrusivas o bloquear tareas por defecto.
- Medir aperturas de una app como si fueran pausas realizadas.
- Monitorizar contenido de pantalla, pulsaciones o aplicaciones activas sin necesidad demostrada.
- Copiar mecánicas de engagement diseñadas para prolongar el tiempo de pantalla.
- Tratar el uso de redes o juegos como una patología por sí solo.

### Comparar durante el prototipado

**Alternativa A: aviso suave con decisión explícita.**
Probar si una invitación no bloqueante permite aceptar, posponer o rechazar una pausa; el mecanismo sería traer la opción a la atención sin convertirla en orden.

**Alternativa B: transición con un punto de reanudación.**
Probar si dejar indicado el siguiente paso hace más fácil interrumpir una tarea; no asumir que funciona hasta observarlo en una tarea ficticia.

**Alternativa C: señal vinculada a un punto natural de detención.**
Probar una señal al terminar una unidad pequeña de trabajo, no en un intervalo rígido. El riesgo es depender de que la persona alcance ese punto o interrumpir tareas que no conviene pausar.

**Alternativa D: señal no basada en otra pantalla.**
Explorar una señal ambiental o ritual físico mínimo; justificarla solo si reduce competencia con la pantalla y es viable sin hardware adicional.

No hace falta implementar las cuatro. Son conceptos comparables para elegir uno, no funcionalidades comprometidas.

---

## 6. Cómo evaluar el prototipo de la hackatón sin fingir eficacia

Dado el límite de tiempo, la prueba será de funcionamiento y usabilidad con **escenarios ficticios**. No utilizar registros personales reales, ni siquiera de los integrantes.

### Escenario de prueba neutral

«Una persona ficticia lleva un tiempo trabajando en una tarea digital. Nota que podría hacer una pausa, pero tiene algo pendiente y no quiere perder el hilo. La intervención le ofrece una opción breve y le permite decidir qué hacer después».

### Qué observar

- ¿Entiende la opción sin explicación oral?
- ¿Puede iniciar una pausa sin muchos pasos?
- ¿Puede posponer o rechazar sin culpa, castigo o reinicio?
- Si existe un punto de reanudación, ¿sabe cómo volver a la tarea?
- ¿La señal le parece intrusiva o útil?
- ¿La interacción añade configuración y mantenimiento innecesarios?

### Cómo definir éxito

**Éxito técnico:** el flujo principal funciona de principio a fin en la demo.
**Éxito de comprensión:** una persona que prueba el escenario entiende qué propone el producto y por qué.
**Señal preliminar de usabilidad:** la persona puede completar el flujo y explicar cómo aceptaría, aplazaría y retomaría.
**No demostrado:** que las personas hagan pausas reales con más frecuencia, que sufran menos dolor o agotamiento, o que mantengan el hábito en el tiempo.

Si el producto se validara después del evento, la medida alineada con la postulación sería la proporción de oportunidades relevantes que terminan en pausas breves realizadas antes de dolor o agotamiento percibido, acompañada de medidas de intrusión, autonomía y carga. Recoger esos datos requeriría consentimiento y diseño de privacidad fuera del alcance de una demo ficticia.

---

## 7. Tabla breve de datos cuantitativos

| Pregunta | Estudio / muestra | Dato | Lectura prudente |
|---|---|---|---|
| ¿Los avisos pueden reducir sedentarismo laboral? | Metaanálisis, 18 estudios, 1.164 trabajadores de oficina (2025), bajo auditoría | Efecto cuantitativo en cuarentena; no usar −12,46 min como estimación fiable hasta resolver errores de extracción/cálculo | Mantener el artículo como referencia, no usar sus agregados para justificar superioridad |
| ¿Los avisos diarios funcionan para estudiantes que estudian en casa? | Ensayo aleatorizado, n = 57, 10 días (2022) | Sin efecto significativo del nudging digital; p > 0,3 | Más notificaciones no garantizan más pausas; estudio pequeño y contextual |
| ¿Uso problemático del celular y procrastinación están relacionados? | Metaanálisis, 75 estudios, 48.031 estudiantes (2024) | r = 0,376; IC 95 % 0,345–0,406 | Asociación moderada, no causalidad |
| ¿Uso problemático de redes se asocia con salud mental? | Revisión/meta, 18 estudios, 9.269 jóvenes (2022) | Depresión r = 0,273; ansiedad r = 0,348; estrés r = 0,313 | Asociaciones moderadas; medidas de uso problemático; no causalidad |
| ¿Las exigencias académicas se relacionan con agotamiento en Chile? | Estudio transversal, n = 424 estudiantes de una universidad (2026) | β = 0,88; p < 0,001; R² = 0,78 en modelo | Asociación fuerte en esa muestra, no causalidad ni estimación nacional |
| ¿Limitar internet móvil puede afectar atención y bienestar? | Ensayo aleatorizado, 467 inscritos; bloqueo de 2 semanas (2025) | Efectos pre-pos: d_z = 0,45 bienestar; 0,56 salud mental; 0,23 atención; 25,5 % cumplió adherencia estricta | Evidencia causal de corto plazo en esa muestra; cumplimiento bajo y generalización limitada |
| ¿Hay estimaciones de burnout estudiantil universalmente fiables? | Metaanálisis de intervención, 17 estudios, 2.462 estudiantes (2023/24) | Burnout global g = 0,90; IC 95 % 0,04–1,75; I² = 94,31 %; agotamiento g = 0,47, IC incluye cero | Intervenciones heterogéneas; resultados sobre agotamiento inconclusos |
| ¿La divagación mental existe en la vida cotidiana? | Revisión de 25 artículos; metaanálisis de 17 (2023) | Estimación de 34,5 % de la vida diaria | No es disociación clínica ni tasa de distracción por redes; depende del método |

---

## 8. Bibliografía verificada y fuentes de apoyo

1. **Leppe-Zamora, J. et al. (2025).** *The effect of computer prompt in breaks of sedentary behaviour among office workers: a systematic review and meta-analysis.* International Journal of Behavioral Nutrition and Physical Activity, 22, 75. DOI: https://doi.org/10.1186/s12966-025-01781-0. Texto completo: https://pmc.ncbi.nlm.nih.gov/articles/PMC12164069/
2. **Teuber, M. et al. (2022).** *Nudging digital physical activity breaks for home studying of university students—A randomized controlled trial during the COVID-19 pandemic with daily activity measures.* Frontiers in Sports and Active Living, 4, 1024996. DOI: https://doi.org/10.3389/fspor.2022.1024996
3. **Zhou, X. et al. (2024).** *The correlation between mobile phone addiction and procrastination in students: A meta-analysis.* Journal of Affective Disorders, 346, 317–328. DOI: https://doi.org/10.1016/j.jad.2023.11.020. PubMed: https://pubmed.ncbi.nlm.nih.gov/37979628/
4. **Problematic Social Media Use in Adolescents and Young Adults: Systematic Review and Meta-analysis (2022).** JMIR Mental Health. DOI: https://doi.org/10.2196/33450. Texto completo: https://pmc.ncbi.nlm.nih.gov/articles/PMC9052033/
5. **Jorquera-Gutiérrez, R., Guerra-Díaz, F. y Martinez-Luna, L. (2026).** *Academic demands and resources as predictors of emotional exhaustion and academic engagement in Chilean university students.* Frontiers in Psychology, 17, 1885652. DOI: https://doi.org/10.3389/fpsyg.2026.1885652
6. **Madigan, D. J., Kim, L. E. y Glandorf, H. L. (2024).** *Interventions to reduce burnout in students: A systematic review and meta-analysis.* European Journal of Psychology of Education, 39, 931–957. DOI: https://doi.org/10.1007/s10212-023-00731-3
7. **Castelo, N. et al. (2025).** *Blocking mobile internet on smartphones improves sustained attention, mental health, and subjective well-being.* PNAS Nexus, 4(2), pgaf017. DOI: https://doi.org/10.1093/pnasnexus/pgaf017. Texto completo: https://pmc.ncbi.nlm.nih.gov/articles/PMC11834938/
8. **Leroy, S. (2009).** *Why is it so hard to do my work? The challenge of attention residue when switching between work tasks.* Organizational Behavior and Human Decision Processes, 109(2), 168–181. DOI: https://doi.org/10.1016/j.obhdp.2009.04.002
9. **Ecological momentary assessment of mind-wandering: meta-analysis and systematic review (2023).** Scientific Reports. https://www.nature.com/articles/s41598-023-29854-9
10. **World Health Organization.** *Burn-out an occupational phenomenon.* https://www.who.int/standards/classifications/frequently-asked-questions/burn-out-an-occupational-phenomenon
11. **European Commission (6 February 2026).** *Commission preliminarily finds TikTok's addictive design in breach of the Digital Services Act.* https://digital-strategy.ec.europa.eu/en/news/commission-preliminarily-finds-tiktoks-addictive-design-breach-digital-services-act
12. **European Commission (10 July 2026).** *Commission preliminarily finds the addictive design of Instagram and Facebook in breach of the Digital Services Act.* https://digital-strategy.ec.europa.eu/en/news/commission-preliminarily-finds-addictive-design-instagram-and-facebook-breach-digital-services-act

---

## 9. Decisión metodológica para nikucode

**No seleccionar todavía un stack ni añadir funciones de IA.** Primero se debe elegir qué barrera principal intentará abordar el prototipo: recordar la pausa, interrumpir sin perder el hilo, escapar a una pantalla sin lograr recuperarse o actuar con poco margen de energía. Pueden estar relacionadas, pero son problemas de interacción diferentes.

Para el tiempo disponible, la intervención más defendible será la más pequeña que pruebe una hipótesis relevante con un flujo completo y escenarios sintéticos. El pitch debe distinguir resultados documentados en literatura, hipótesis sobre nuestro contexto y resultados observados en la demo.


---

## Nota metodológica de continuidad (18-10-2026)

Esta revisión es una síntesis bibliográfica temática, no una revisión sistemática nueva. La lectura de cifras debe seguir la escalera de evidencia del manual reutilizable: los resultados externos respaldan únicamente las afirmaciones dentro del alcance de cada estudio; no diagnostican al equipo ni establecen causalidad cuando el diseño es correlacional. Para comparar afirmaciones y pruebas, consultar `MATRIZ_EVIDENCIA_Y_VALIDACION.md`.
