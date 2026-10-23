# Matriz de alternativas, evidencia, viabilidad y brechas — nikucode

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


## Aclaración de Makana con transcripción — 22-10-2026

La [transcripción de chat.mp3 aportada por Alex](ACLARACION_MAKANA_TRANSCRIPCION_2026-10-22.md) permite investigar, tener ideas de producto, llevar material escrito y preparar herramientas/dependencias. **El código de la app empieza después de terminar la presentación de bienvenida**, sin commits de desarrollo previos. El repositorio debe ser público; para nuestro flujo lo crearemos vacío durante el evento. Se permiten librerías open source, pero **no reutilizar desarrollo de otros proyectos personales**.

Esta precisión reemplaza restricciones históricas sobre investigar o llevar documentación y el resumen anterior que solo mencionaba repo/código. Marea es un ejercicio para aprender Flutter creado durante esta investigación, no un proyecto personal; la transcripción no resuelve expresamente la reutilización de su código. No clasificarlo como desarrollo personal prohibido ni afirmar una autorización específica no expresada. Las referencias antiguas a comenzar a las 09:00 quedan subordinadas al fin de la bienvenida. La elección de solución sigue dependiendo de la investigación.

**Trazabilidad:** se leyó la transcripción pegada por Alex; no se escuchó ni verificó aquí el audio. El documento vinculado conserva sus palabras y distingue la respuesta de nuestras decisiones prácticas.

**Actualización:** 22 de octubre de 2026
**Estado:** análisis comparativo; no se ha elegido ni validado una solución.
**Pregunta de diseño:** ¿cómo facilitar pausas físicas breves durante estudio o trabajo prolongado frente a pantallas, sin añadir otra obligación ni interrumpir innecesariamente el hilo de la tarea?

## 1. Lectura ejecutiva

La solución debe seguir abierta. La evidencia no justifica asumir que tiene que ser una aplicación, ni que una app sea superior a una señal física u organizativa. Sí hay evidencia directa de que algunas intervenciones de pausas y sedentarismo pueden funcionar en ciertos contextos; no existe evidencia suficiente para asegurar que una función concreta de nikucode cambie el hábito de estudiantes/programadores.

El problema de diseño más importante que sigue sin resolverse es **qué barrera domina en una ocasión real**:

1. **No advertir el tiempo o olvidarse** de hacer una pausa.
2. **Advertirlo, pero posponerlo** por no perder el hilo o porque la tarea parece urgente.
3. **No poder ejecutar la acción** en el lugar o momento disponible (cansancio, espacio, ropa, movilidad, contexto social, falta de una idea simple).
4. **Usar otra pantalla como descanso**, que puede prolongarse y no producir movimiento.
5. **Rechazar las herramientas que se sienten como otra obligación**, vigilancia o examen de disciplina.

Son hipótesis basadas en el relato del equipo y en alternativas plausibles, no proporciones medidas ni un diagnóstico. Más de una barrera puede coexistir.

**Recomendación de proceso:** antes de elegir tecnología, analizar episodios recientes y determinar qué barrera aparece. Después elegir una alternativa que actúe sobre esa barrera y someterla a una prueba mínima. No escoger la idea que resulte más vistosa ni la que tenga más funcionalidades.

## 2. Qué significa “evidencia” en esta matriz

- **Directa:** el estudio midió tiempo sentado, pausas o movimiento en el contexto estudiado. No implica que la evidencia se transfiera automáticamente a estudiantes/programadores o a nuestro producto.
- **Indirecta:** el estudio examinó un mecanismo relacionado (por ejemplo, interrupciones de una tarea o aperturas de aplicaciones), pero no demostró que aumente las pausas físicas.
- **Plausibilidad:** razonamiento de diseño que todavía requiere prueba propia.
- **Evidencia de componente:** la literatura apoya una clase de intervención o varios componentes combinados; no permite atribuir el efecto a cada pieza individual.

Las categorías cualitativas de viabilidad y riesgo que siguen son **juicios de planificación del equipo**, no resultados publicados ni estimaciones estadísticas.

## 3. Matriz comparativa de alternativas

| Familia de alternativa | Qué mecanismo probaría | Evidencia y transferibilidad | Viabilidad para un MVP de 1–2 días | Brecha crítica / cómo podría fallar | Prueba más barata antes de construir |
|---|---|---|---|---|---|
| **A. Aviso digital simple** (temporizador o aviso elegido por la persona) | Hacer más visible la oportunidad de levantarse o moverse. | **Evidencia mixta y cuantificación en revisión:** el metaanálisis de Leppe-Zamora et al. (2025) queda en cuarentena por problemas de extracción/cálculo detectados en una auditoría previa del equipo; no usar sus efectos agregados como estimaciones fiables. Otro metaanálisis de intervenciones digitales combinadas encontró −29,9 min por 8 h, pero no identifica qué componente causó el efecto. En un RCT de 57 universitarios, los mensajes diarios no produjeron un efecto significativo en pausas activas; en otro RCT de 77 estudiantes de medicina el cambio entre grupos tampoco fue significativo. | **Alta** para simular un aviso y su flujo; **media** para notificaciones fiables en un dispositivo/plataforma concreta. | Puede volverse un aviso más que se ignora, llegar en plena concentración o aumentar la sensación de obligación. No se conoce el intervalo adecuado para este equipo. | Preguntar por episodios recientes: ¿la persona no se dio cuenta o sí se dio cuenta y aplazó? Comparar en un escenario aviso genérico vs. acción concreta, sin cambiar más variables. |
| **B. Señal ligada a una transición de tarea** (por ejemplo, cuando termina un bloque, prueba, capítulo o paso elegido por la persona) | Evitar interrumpir un tramo de concentración y ofrecer una pausa cuando hay una frontera natural; opcionalmente, dejar una nota mínima para retomar. | **Mixta:** la evidencia laboral sobre intervenciones multicomponente respalda que las señales y apoyo organizativo pueden ayudar, sin aislar el papel de los límites de tarea. Una revisión de 33 experimentos de laboratorio encontró que intervenciones para manejar interrupciones mejoraron precisión y redujeron el tiempo para retomar tareas. Esto apoya explorar el coste de retomar, **no demuestra** que una señal en una transición aumente las pausas físicas. | **Alta** si la transición la marca la propia persona o es un paso visible; **baja–media** si se intenta inferir automáticamente la tarea desde IDE, pantalla, actividad o sensores. | Las tareas no siempre ofrecen una frontera clara; una nota de reanudación puede añadir fricción; detectar el contexto automáticamente podría implicar permisos o privacidad innecesarios. | Entrevista sobre la última ocasión en que quiso pausar y siguió trabajando. Probar un flujo en papel con “pausar ahora / al terminar este paso / no ahora”. Comprobar si la opción resuelve una situación relatada, no solo si gusta. |
| **C. Señal física/analógica** (tarjeta, objeto táctil, ficha que se gira o elemento visible en el escritorio) | Convertir la pausa en algo visible y disponible sin exigir abrir otra pantalla. | **Plausibilidad / evidencia indirecta para este uso concreto.** Las señales y los planes vinculados a contexto tienen fundamento conductual, pero esta revisión no ha identificado un ensayo que demuestre que un objeto de escritorio específico aumente las pausas físicas entre programadores. | **Muy alta**: coste y complejidad mínimos; funciona en cualquier sistema y no necesita permisos. | La señal puede desaparecer en el fondo visual, olvidarse o no ayudar cuando la persona ya está absorbida en una tarea. No basta con poner algo bonito en el escritorio. | Simular tres señales distintas con papel u objetos ya disponibles. Preguntar qué situación real las haría visibles y útiles y dónde se pondrían; luego probar en una sesión corta si se recuerdan espontáneamente. |
| **D. Cambio de entorno físico** (facilitar levantarse, acceso a agua, objeto que requiera caminar, espacio libre para moverse, estación sentarse/de pie) | Reducir el esfuerzo práctico o facilitar una alternativa al estar sentado. | **Directa para determinadas intervenciones de entorno laboral:** revisiones de estaciones sentarse/de pie y estrategias multicomponente hallan reducciones del tiempo sentado en trabajadores de oficina. Estas intervenciones suelen requerir equipo, cambios de espacio o apoyo organizativo; no prueban que un objeto sencillo o una modificación doméstica tenga el mismo efecto. | **Alta** para una intervención de organización del espacio sin hardware; **baja** para replicar un escritorio ajustable o un sistema laboral en una hackatón. | Puede depender de recursos, espacio, accesibilidad, clima o condiciones del lugar; ponerse de pie no siempre equivale a dar una pausa física útil. | Mapeo breve del lugar de estudio/trabajo: ¿qué acción física es viable sin preparación ni desplazamiento incómodo? Probar una sola modificación del entorno, no comprar hardware. |
| **E. Acuerdo organizativo o social voluntario** (pausa elegida con compañero/a, cierre de bloque, pequeña regla de sesión o pausa compartida) | Establecer una norma o momento social que convierta la pausa en parte legítima de la tarea. | **Evidencia de componente, no aislada:** los metaanálisis de intervenciones laborales multicomponente incluyen información, apoyo organizativo e influencias sociales y hallan reducciones del sedentarismo. No permiten afirmar que el compañero o el acuerdo sea el elemento eficaz por sí solo; el contexto laboral no equivale a un equipo de dos estudiantes. | **Muy alta** para probar un protocolo y mostrarlo; no requiere aplicación. | Puede convertirse en presión, vigilancia mutua o una interrupción para quien no esté disponible. Requiere que ambas personas acepten el acuerdo y que se permita decir “no”. | Ensayar durante una sesión normal una única regla optativa, p. ej. “al terminar un bloque, cualquiera puede proponer una pausa de un minuto; ambos pueden rechazarla sin explicación”. Registrar solo si ayuda o molesta, sin nombres ni datos personales. |
| **F. Fricción antes de continuar con otra pantalla** (pausa intencional antes de abrir una red/feed o al pasar a descanso digital) | Romper el automatismo de cambiar de aplicación y ofrecer una alternativa fuera de pantalla. | **Indirecta:** el estudio de one sec halló una reducción de aperturas efectivas de aplicaciones objetivo en un estudio de campo y destacó la opción de cancelar; ese resultado **no demuestra** más pausas físicas ni menor sedentarismo. | **Baja–media:** una pantalla/flujo se simula fácil; una intervención real a nivel sistema depende de Android/iOS, permisos y políticas. | Puede tratar el síntoma equivocado si la barrera principal es olvido, fatiga o temor a perder el hilo. Puede añadir una interrupción o una capa de bloqueo más. | Preguntar si el descanso digital es una parte frecuente del episodio. Probar una tarjeta de decisión fuera del sistema operativo, sin bloquear aplicaciones ni monitorizar uso. |
| **G. Combinación mínima** (una señal + una acción concreta + opción de hacerla/posponer/rechazar; quizás señal física de apoyo) | Hacer evidente una oportunidad, facilitar el primer movimiento y preservar autonomía. | **Combinación no validada como paquete.** Los prompts se han estudiado en contextos relevantes, pero el tamaño de efecto del metaanálisis de Leppe-Zamora está en cuarentena y los ensayos estudiantiles citados tuvieron resultados nulos entre grupos. Las intervenciones digitales combinadas muestran resultados agrupados, pero no permiten atribuir efecto a esta mezcla concreta. La opción de posponer/rechazar tiene apoyo indirecto en investigación sobre elección e interrupción de aperturas digitales. | **Alta** si se mantiene en un único ciclo. **Media** si se suman demasiados componentes. | No se sabrá qué elemento aporta valor si se cambian varios a la vez. La combinación aún podría resultar una obligación extra. | Comparar una variable por vez: primero acción específica vs. invitación general con el resto constante; solo después estudiar el aporte de una señal física o de un marcador para retomar. |
| **H. Educación breve / mascota / puntos / rachas / recompensas** | Aumentar significado, recordación o repetición mediante contenido o juego. | **Indirecta y heterogénea:** la gamificación en salud tiene efectos promedio pequeños en algunos resultados de actividad física (un metaanálisis estimó alrededor de +489 pasos/día), pero no demuestra eficacia para este caso ni identifica que una mascota o racha sea necesaria. Las revisiones de microaprendizaje encuentran resultados cognitivos más consistentes que conductuales. | **Media–alta** para un prototipo visual, pero **baja** para construir y validar bien un sistema de progresión completo. | Añade lectura y tiempo de pantalla; rachas, castigos o pérdida de progreso pueden agravar la sensación de obligación; puede distraer del comportamiento físico. | No implementarlo aún. Solo explorarlo si las entrevistas identifican falta de motivación/recordación como barrera principal y no una barrera de oportunidad o contexto. Comparar primero el comportamiento objetivo sin gamificación. |

### Síntesis de la matriz

- Si predomina **olvidarse/no advertir el tiempo**, comparar un aviso digital simple con una señal física visible.
- Si predomina **posponer para no perder el hilo**, explorar la transición de tarea y la opción de reanudar con un recordatorio mínimo; no asumir que necesita IA.
- Si predomina **la acción no es practicable**, primero ofrecer un movimiento viable sin equipo y reducir los pasos/contexto requeridos; más notificaciones no resuelven ese problema.
- Si predomina **el descanso se va a otra pantalla**, explorar una transición fuera de pantalla o fricción voluntaria, sin asumir que bloquear aplicaciones es la solución.
- Si predomina **el rechazo a otra obligación**, priorizar el control de la persona, la posibilidad de no hacerlo y la ausencia de castigos/rachas. Esto debe probarse, no declararse resuelto por la redacción.

## 4. Evidencia que más cambia la decisión

### Revisión crítica del metaanálisis de avisos por computador

**No utilizar por ahora las cifras agregadas de Leppe-Zamora et al. (2025) como estimaciones fiables.** Según la auditoría previa del equipo realizada durante el trabajo con OpenCode, se detectaron problemas de extracción/cálculo: errores estándar de Swartz tratados como desviaciones estándar, orientación inconsistente de grupos según el resultado y tamaños de grupo incorrectos para el resultado de pasos. El equipo reporta haber reproducido los agregados con esas entradas; por ello quedan suspendidas las cifras antes citadas de −12,46 minutos y +1.030 pasos hasta resolver la discrepancia a partir de datos/tablas originales. Esta edición incorpora el resultado de aquella auditoría, pero no vuelve a reproducir sus cálculos de forma independiente.

El artículo se conserva en la bibliografía para trazabilidad, no como prueba cuantitativa favorable. Las intervenciones digitales multicomponente de Parés-Salomón et al. (2024) siguen siendo un antecedente separado, con componentes mezclados y sin atribución causal a una función específica. Además, los ensayos estudiantiles citados tuvieron resultados nulos entre grupos. Por tanto, una señal sencilla puede mantenerse como **candidata barata de comparación**, no como ganadora respaldada por aquel tamaño de efecto. DOI del artículo bajo revisión: [10.1186/s12966-025-01781-0](https://doi.org/10.1186/s12966-025-01781-0).

### Evidencia a favor de no descartar componentes organizativos

Parés-Salomón et al. (2024) incluyeron 19 estudios de intervenciones digitales en empleados de oficina (11 en el metaanálisis), con una reducción agrupada de 29,9 minutos sentado por jornada de 8 horas. Las intervenciones empleaban combinaciones de información, orientación, prompts y apoyo organizativo/social; el resultado no permite saber qué componente fue responsable ni asegurar la misma magnitud en estudiantes. DOI: [10.1186/s12966-024-01595-6](https://doi.org/10.1186/s12966-024-01595-6).

### Contraevidencia importante

Teuber et al. (2022) no encontró un efecto estadísticamente significativo de mensajes motivacionales diarios en 57 estudiantes que estudiaban en casa. En un RCT de estudiantes de medicina (N=77), el cambio entre grupos en tiempo sedentario no fue significativo para vibración cada 30 minutos. Estos resultados no demuestran que los avisos sean inútiles, pero sí desaconsejan considerarlos una solución suficiente por defecto. [Teuber et al.](https://doi.org/10.3389/fspor.2022.1024996) · [Wafi et al.](https://doi.org/10.3390/healthcare12212133).

### Evidencia relevante para la barrera “perder el hilo”

Una revisión sistemática y metaanálisis de 33 experimentos de laboratorio (49 intervenciones) encontró que las intervenciones destinadas a reducir las consecuencias de las interrupciones mejoraron la precisión en la tarea principal y redujeron el tiempo de reanudación. Esto respalda considerar la preparación para retomar una tarea, pero no demuestra que un marcador o una nota de “siguiente paso” aumente las pausas físicas. DOI: [10.1016/j.apergo.2021.103506](https://doi.org/10.1016/j.apergo.2021.103506).

### Evidencia relevante para una adaptación compleja

Una revisión de JITAI para actividad física (37 estudios; 6.939 participantes) encontró heterogeneidad alta y evidencia inconclusa para sedentarismo medido objetivamente. No hay fundamento suficiente para iniciar con IA, sensores o detección automática de contexto sin demostrar que una regla sencilla no resuelve el problema. DOI: [10.3389/fpubh.2026.1934024](https://doi.org/10.3389/fpubh.2026.1934024).

## 5. Prueba mínima recomendada: diagnosticar primero, comparar después

No comenzar con “¿qué app te gustaría?”. La preferencia declarada no demuestra uso real ni eficacia. Empezar con la última ocasión concreta y dejar que la persona describa qué sucedió.

### Prueba 0 — diagnóstico breve de la barrera

**Objetivo:** decidir qué mecanismo merece una primera prueba. No demostrar eficacia ni estimar prevalencia.

**Muestra exploratoria:** 5–8 personas que estudien o trabajen con pantalla durante periodos prolongados, elegidas por conveniencia. Esta cantidad sirve para descubrir fricciones iniciales, no para generalizar o estimar porcentajes poblacionales.

**Guion (5–7 minutos):**

1. “Piensa en la última vez que estuviste más tiempo del previsto frente a una pantalla. ¿Qué estaba pasando justo antes de seguir?”
2. “¿En qué momento, si es que ocurrió, pensaste en levantarte o moverte?”
3. “¿Qué hizo que siguieras sentado/a?”
4. “¿Qué habría hecho difícil pausar en ese momento?”
5. Solo después de escuchar el episodio: “Si cambiaras una cosa para esa situación concreta, ¿qué tendría que pasar o qué tendría que ser más fácil?”

**Codificación posterior, sin obligar a una sola categoría:** no advertir el tiempo; no querer interrumpir/perder el hilo; no poder realizar el movimiento/contexto; seguir con descanso en pantalla; rechazo a presión/obligación; otro. Una persona puede dar varios motivos.

**Registro:** contar categorías y registrar frases sin nombres, ubicaciones, datos de salud ni detalles identificables. No grabar audio ni volcar relatos identificables a herramientas de IA. No presentar estas conversaciones como una encuesta representativa.

**Regla de decisión:** si una barrera se repite en varios relatos concretos y explica qué ocurrió antes de seguir sentado, elevarla como primera hipótesis. Si los motivos se dispersan, no fingir que existe un ganador: escoger el experimento más barato entre dos candidatos y dejar explícita la incertidumbre. El umbral exacto es una regla práctica del equipo, no un umbral estadístico validado.

### Prueba 1 — pretotipo de mecanismo

Seleccionar **solo dos alternativas** en función de la Prueba 0. Mostrar dos versiones neutras con el mismo escenario y nivel visual; mantener constantes los factores no estudiados.

Ejemplos:

- Si predomina el olvido: señal física visible vs. aviso digital configurable.
- Si predomina perder el hilo: aviso en cualquier momento vs. opción “al terminar este paso”, con igual texto y aspecto.
- Si predomina que la acción parece difícil: movimiento específico sin equipo vs. invitación vaga a “hacer una pausa”.
- Si predomina el descanso en pantalla: transición voluntaria fuera de pantalla vs. aviso genérico, sin implementar bloqueo de aplicaciones.

**Qué observar:** si entienden qué hacer sin explicación; si pueden señalar cuándo actuarían; qué opción usarían para posponer/rechazar; qué fricción anticipan; si la alternativa parece encajar con el episodio real contado. Preguntar “¿te gusta?” puede complementar, pero no debe ser el criterio principal.

**Tamaño orientativo:** 5–8 personas para detectar problemas de comprensión, no para demostrar superioridad. Alternar el orden de presentación si se comparan dos alternativas.

## 6. Criterios para seleccionar el MVP

Puntuar cada criterio como **cumple / parcialmente / no cumple**, dejando la justificación escrita:

1. **Encaja con una barrera que apareció en episodios reales**, no solo con una explicación inventada por el equipo.
2. **Produce una oportunidad clara de acción física breve** fuera de la pantalla.
3. **La persona mantiene control:** puede posponer o no hacerlo sin castigo, vergüenza ni pérdida de progreso.
4. **No requiere que la persona abra y navegue otra app** para recibir valor básico, salvo que haya una razón observada.
5. **Puede demostrarse y comprobarse en el tiempo disponible** sin sensores, cuentas, backend ni permisos difíciles, a menos que sean esenciales para la hipótesis elegida.
6. **Permite medir un resultado observable** y registrar también rechazo, molestia o interferencia.

### MVP mínimo orientado a una sola conducta

El MVP será distinto según la barrera:

- **Olvido:** una sola señal y una acción física concreta.
- **Pérdida del hilo:** una señal en la transición escogida y, solo si la prueba lo justifica, una forma de marcar el siguiente paso.
- **Dificultad de ejecutar:** una opción de movimiento breve y realizable en el contexto declarado, con alternativa si no es posible.
- **Descanso digital prolongado:** una transición voluntaria fuera de pantalla que ofrece acción física, sin bloqueo obligatorio como premisa.
- **Resistencia a obligaciones:** una función de baja presión con salida explícita; ninguna racha ni penalización en el núcleo.

No comenzar con registro/login, perfil, sincronización, analítica personal, overlays, IA, sensores, mascota ni economía de puntos sin evidencia de que resuelven una barrera prioritaria.

## 7. Métricas y límites de interpretación

Durante un pretotipo: comprensión sin ayuda, pasos requeridos, elección realizada, fricción, interferencia percibida y autonomía. Un prototipo funcional puede demostrar funcionamiento técnico; no demuestra cambio real de hábito.

En un futuro ensayo de campo, el resultado principal tendría que ser **pausas físicas breves completadas por oportunidad elegible**, no notificaciones mostradas, aperturas de app, minutos de engagement o intención declarada. También deberían medirse posponer/rechazar, molestias e interrupciones. Solo una prueba longitudinal con comparación adecuada podría apoyar afirmaciones más fuertes de eficacia; el equipo no debería afirmar reducción de dolor, prevención clínica ni cambio de hábito a partir de una demo.

## 8. Bibliografía seleccionada

1. Leppe-Zamora J, et al. (2025). Computer prompts and sedentary behaviour. *International Journal of Behavioral Nutrition and Physical Activity*. https://doi.org/10.1186/s12966-025-01781-0. **Resultado cuantitativo en cuarentena por auditoría del equipo; no citar sus efectos agrupados hasta resolver errores detectados.**
2. Parés-Salomón I, et al. (2024). Digital workplace interventions to reduce sedentary behaviour. *International Journal of Behavioral Nutrition and Physical Activity*. https://doi.org/10.1186/s12966-024-01595-6
3. Zhou Q, et al. (2026). Digital health interventions on college students’ lifestyle behaviours. *Journal of Medical Internet Research*. https://doi.org/10.2196/82192
4. Teuber M, Leyhr D, Sudeck G. (2022). Digital nudging of physical-activity breaks in home studying. *Frontiers in Sports and Active Living*. https://doi.org/10.3389/fspor.2022.1024996
5. Wafi AM, et al. (2024). Smartphone vibration feedback for sedentary time in medical students. *Healthcare*. https://doi.org/10.3390/healthcare12212133
6. Ismail T, Al Thani D. (2022). Just-in-time adaptive intervention for sedentary behaviour at work. *JMIR Formative Research*. https://doi.org/10.2196/34309
7. Yang S, et al. (2026). JITAI for physical activity: systematic review. *Frontiers in Public Health*. https://doi.org/10.3389/fpubh.2026.1934024
8. Grüning DJ, et al. (2023). Directing smartphone use through the self-nudge app one sec. *PNAS*. https://doi.org/10.1073/pnas.2213114120
9. (2021). Interventions to reduce negative consequences of interruptions on task performance: systematic review and meta-analysis. *Applied Ergonomics*. https://doi.org/10.1016/j.apergo.2021.103506
10. Kompf J. (2020). Implementation intentions for exercise and physical activity: systematic review. *Journal of Physical Activity and Health*. https://doi.org/10.1123/jpah.2018-0720
11. Sedentary-work interventions including environmental support: systematic review and meta-analysis (24 studies, N=3.169). PubMed. https://pubmed.ncbi.nlm.nih.gov/38503064/
12. Multicomponent workplace interventions to reduce sedentary behaviour (11 RCTs, N=1.894). PMC. https://pmc.ncbi.nlm.nih.gov/articles/PMC10413238/

---

**Decisión registrada a 22-10-2026:** no hay una solución elegida. Próximo paso recomendado: ejecutar la Prueba 0, resumir los motivos observados sin identificadores y seleccionar dos mecanismos para un pretotipo. La señal digital sigue siendo una candidata por la evidencia directa disponible, no la opción predeterminada ni una conclusión de eficacia.
