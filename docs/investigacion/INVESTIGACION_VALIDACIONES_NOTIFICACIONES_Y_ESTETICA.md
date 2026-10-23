# Investigación: validaciones experimentales de notificaciones, estética y usabilidad

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Continuidad 22-10-2026:** [investigación de estética, estructura y accesibilidad](../INVESTIGACION_ESTETICA_ESTRUCTURA_ACCESIBILIDAD_2026-10-22.md), con contraste de Perrig, fuentes adicionales, estrategias actuales de Opal y propuesta de interfaz pendiente de prueba. Según la aclaración oficial comunicada por Alex, solo el repositorio y el código a presentar deben esperar al evento; las restricciones históricas de este documento sobre preparar diseño previamente quedan reemplazadas.

**Actualización:** 19 de octubre de 2026
**Proyecto:** nikucode · Hackatón Señales de Makana 2026
**Propósito:** identificar estudios que ya hayan probado intervenciones semejantes y adaptar sus métodos a un pretotipo en Canva, sin presentar una prueba pequeña como evidencia estadística de eficacia.

## 1. Pregunta de investigación

¿Qué aspectos de una notificación conceptual para facilitar una pausa física breve conviene probar antes de programar: el mensaje, la acción sugerida, la estética visual, la posibilidad de posponer/rechazar o la contextualización?

La pregunta debe descomponerse. Los estudios disponibles miden resultados diferentes —estética percibida, usabilidad percibida, aperturas de apps, engagement inmediato o adherencia a una medición de salud— y no existe un estudio único que prediga el éxito del flujo de nikucode.

## 2. Estudios que se parecen a nuestra validación

### V01 — Estética de aplicaciones móviles: experimento con dos variantes visuales

**Referencia:** Perrig, S. A. C., Ueffing, D., Opwis, K., & Brühlmann, F. (2023). *Smartphone app aesthetics influence users' experience and performance*. Frontiers in Psychology, 14, 1113842. DOI: https://doi.org/10.3389/fpsyg.2023.1113842
**Diseño y muestra:** experimento online con 281 personas usuarias de móvil; asignación aleatoria a una versión estética (n=139) o menos estética (n=142) de la misma aplicación web. Se intentó manipular la estética manteniendo igual el resto de la funcionalidad. Se midieron estética percibida (VisAWI), usabilidad percibida (UMUX) y desempeño en preguntas sobre el contenido.
**Resultados:** la variante estética recibió puntuaciones mayores de estética percibida (d=1,26; p<0,0001) y usabilidad percibida (d=0,86; p<0,0001). No se encontraron diferencias significativas en tiempo de respuesta (p=0,60) ni en puntuación de desempeño con la prueba t convencional (p=0,07); el propio artículo describe evidencia mixta para desempeño objetivo.
**Qué permite afirmar:** el aspecto visual puede modificar sustancialmente la evaluación subjetiva de una interfaz móvil, incluso manteniendo la funcionalidad.
**Qué no permite afirmar:** que una tarjeta de notificación más bonita genere más pausas, más retención o mejor salud. El estudio utilizó una app web funcional, no una notificación sobre una red social.
**Aplicación:** merece la pena comparar dos direcciones visuales por separado, conservando iguales el mensaje, las acciones, la posición y el contexto.

### V02 — one sec: estudio de campo y experimento que separó los componentes

**Referencia:** Grüning, D. J., Riedel, F., & Lorenz-Spreen, P. (2023). *Directing smartphone use through the self-nudge app one sec*. PNAS, 120(8), e2213114120. DOI: https://doi.org/10.1073/pnas.2213114120
**Estudio de campo:** las principales análisis de comportamiento incluyeron a 280 usuarios que completaron seis semanas. En el 36% de los intentos de abrir una app objetivo, la persona cerró la app después de la intervención; los intentos de apertura cayeron un 37% entre la primera semana y el periodo de uso; las aperturas efectivas se redujeron un 57% al comparar el comienzo con la sexta semana. El análisis principal de campo excluyó de los análisis a quienes abandonaron antes de las seis semanas; el artículo presenta análisis complementarios que incluyen abandonos.
**Experimento controlado preregistrado:** n=500, asignación aleatoria a condiciones para separar tres componentes: mensaje de reflexión, demora breve y opción explícita de cancelar el intento. La opción de cancelar tuvo el efecto más fuerte; la demora también redujo el consumo; el mensaje reflexivo por sí solo no produjo un efecto comparable.
**Qué permite afirmar:** es evidencia particularmente relevante de que devolver una opción explícita a la persona y crear una pequeña fricción pueden ayudar a reconsiderar una apertura automática.
**Qué no permite afirmar:** que el mismo efecto vaya a ocurrir con pausas físicas; que el 57% sea una predicción para nikucode; o que el diseño haya mejorado la conducta de salud. El estudio de campo tuvo autoselección y el resultado principal fue de uso de apps, no de movimiento físico.
**Aplicación:** conservar una opción clara para posponer o descartar; no asumir que añadir texto reflexivo o una estética llamativa es la parte eficaz.

### V03 — Mensajes de salud contextuales: ensayo microrrandomizado

**Referencia:** Bidargaddi, N. et al. (2018). *To Prompt or Not to Prompt? A Microrandomized Trial of Time-Varying Push Notifications to Increase Proximal Engagement With a Mobile Health App*. JMIR mHealth and uHealth, 6(11), e10123. DOI: https://doi.org/10.2196/10123
**Diseño y muestra:** 1.255 usuarios de una app comercial de bienestar laboral, observados durante 89 días. En puntos elegibles y aleatorizados, se enviaba o no un mensaje de salud adaptado al contexto. El resultado primario fue completar el autorregistro en la app durante las 24 horas siguientes.
**Resultado:** cuando se enviaba el mensaje contextualizado, la probabilidad de engagement en las siguientes 24 horas fue 3,9% mayor en términos relativos (RR=1,039; IC 95% 1,01–1,08; p<0,05). El efecto se atenuó con el tiempo, aunque el cambio en la atenuación no fue significativo (p=0,84).
**Qué permite afirmar:** una notificación contextualizada puede producir un aumento inmediato pequeño; la eficacia de una señal depende de qué se mida, cuándo y en qué contexto.
**Qué no permite afirmar:** que un mensaje vaya a lograr una pausa física; el outcome fue autorregistro en una app, no un comportamiento físico observado.
**Aplicación:** para una prueba de campo futura, registrar respuesta inmediata y carga percibida por separado; no confundir abrir la app con realizar la conducta objetivo.

### V04 — Personalización y horario: ensayo factorial aleatorizado

**Referencia:** *Increasing Engagement in the Electronic Framingham Heart Study: Factorial Randomized Controlled Trial* (2023). JMIR. DOI: https://doi.org/10.2196/40784
**Diseño y muestra:** 655 participantes asignados en un ensayo factorial que comparó mensajes personalizados con mensajes estándar, y además mañana con tarde y fin de semana con días laborables. Edad media: 53 años (DE=9). El resultado fue la transmisión de mediciones de presión arterial y frecuencia cardiaca desde dispositivos.
**Resultados:** mensajes personalizados elevaron la transmisión de presión arterial respecto a mensajes estándar: 45,4% frente a 30,9% al mes (+14,5 puntos porcentuales; p<0,001), 38,9% frente a 28,8% a los tres meses (+10,1 puntos; p=0,006) y 36,8% frente a 22,4% a los seis meses (+14,4 puntos; p<0,001). Para frecuencia cardiaca a seis meses, 66,2% frente a 56,2% (+10 puntos; p=0,02). No se encontraron diferencias convincentes entre mensajes de mañana/tarde ni fin de semana/días laborales para los resultados principales.
**Qué permite afirmar:** cierto grado de personalización contextual puede mejorar adherencia a tareas de monitorización sanitaria.
**Qué no permite afirmar:** que personalizar una tarjeta o usar el nombre del usuario mejore las pausas; la población y la conducta son muy diferentes. Tampoco demuestra que haya un horario universal óptimo.
**Aplicación:** no priorizar la personalización ni el horario sobre una acción clara sin una razón contextual. Una versión posterior puede evaluar contexto, pero no es una función necesaria para el pretotipo inicial.

### V05 — Mensajes enmarcados como ganancia o pérdida

**Referencia:** *Effects of Framed Mobile Messages on Beliefs, Intentions, Adherence, and Asthma Control: A Randomized Trial* (2024). DOI: https://doi.org/10.3390/pharmacy12010010
**Diseño y muestra:** ensayo aleatorizado con 43 estudiantes universitarios de 18–29 años con asma; mensajes que enfatizaban ganancias o pérdidas se enviaron tres veces por semana durante ocho semanas. La retención en el estudio fue del 100% y el engagement comunicado con los mensajes fue 85,9%.
**Resultados:** las intenciones de medicación y el control del asma cambiaron entre el inicio y el final en el conjunto; no hubo diferencias significativas entre los grupos de mensajes de ganancia y pérdida en los resultados comparados.
**Qué permite afirmar:** un alto porcentaje de interacción con mensajes no implica que un marco motivacional concreto sea superior.
**Qué no permite afirmar:** que los mensajes positivos, negativos o motivadores funcionen igual para pausas; muestra pequeña, contexto clínico específico.
**Aplicación:** no asumir que una frase positiva o una advertencia motivará más. Comparar el mensaje con criterio y evitar culpa o amenaza como mecanismo por defecto.

### V06 — Tamaño de muestra en tests de usabilidad

**Referencia:** Faulkner, L. (2003). *Beyond the five-user assumption: Benefits of increased sample sizes in usability testing*. Behavior Research Methods, 35, 379–383. DOI: https://doi.org/10.3758/BF03195514
**Diseño:** se estudiaron 60 usuarios y se extrajeron conjuntos aleatorios de distinto tamaño para comprobar cuántos problemas de usabilidad conocidos detectaban.
**Resultados:** conjuntos de cinco participantes detectaron entre el 55% y el 99% de los problemas identificados en el conjunto total; la media fue 85,55%. Para conjuntos de diez, el mínimo observado fue 82% y la media 94,69%; para conjuntos de veinte, el mínimo fue 95% y la media 98,4%.
**Interpretación correcta:** cinco participantes pueden ayudar a detectar problemas evidentes, pero el resultado depende de quién participa; cinco no es un número mágico ni una muestra estadísticamente representativa.
**Aplicación:** 5–8 personas cercanas pueden servir para un primer estudio cualitativo y localizar confusiones. No se deben reportar porcentajes de preferencia como estimaciones poblacionales ni declarar cuál diseño es estadísticamente ganador.

### V07 — Instrumentos breves de estética y usabilidad

- **VisAWI-S:** versión breve de cuatro ítems del inventario de estética visual de sitios web. Se validó en tres estudios con un total de 1.673 participantes y proporciona una medida breve de estética percibida. Referencia: Moshagen & Thielsch (2013), https://doi.org/10.1080/0144929X.2012.694910. El contexto original son sitios web; si se reescriben los ítems para una notificación, la versión adaptada ya no debe presentarse como instrumento validado para notificaciones.
- **UMUX-Lite:** cuestionario de dos ítems para medir usabilidad percibida; sus dos muestras iniciales mostraron fiabilidades de 0,82 y 0,83 y correlaciones de 0,81 con SUS. Referencia: https://doi.org/10.1145/2470654.2481287. Es más apropiado cuando se evalúa un sistema interactivo que una tarjeta estática.
- **Single Ease Question (SEQ):** medida de una pregunta posterior a una tarea, habitualmente con escala de siete puntos, para la facilidad/dificultad percibida de completar una tarea. Para nuestro Canva sería una adaptación exploratoria si la tarea es solo interpretar una tarjeta; no mide eficacia conductual ni estética por sí sola. Referencia sobre instrumentos de usabilidad: https://www.frontiersin.org/journals/digital-health/articles/10.3389/fdgth.2026.1938990/full.

**Recomendación de medición:** con cinco u ocho personas, priorizar observación y preguntas abiertas. Se pueden añadir ítems de 1–7 sobre claridad, intrusión y apariencia, pero identificarlos como preguntas exploratorias creadas por el equipo. No sumar esos ítems ni tratarlos como una escala validada.

### V08 — Coste cognitivo de las notificaciones de redes sociales

**Referencia:** Fournier et al. (2026). *Attention hijacked: How social media notifications disrupt cognitive processing*. Computers in Human Behavior, 179, 108926. DOI: https://doi.org/10.1016/j.chb.2026.108926.
El estudio reporta una ralentización transitoria del procesamiento cognitivo de aproximadamente siete segundos tras una notificación de estilo redes sociales en una tarea experimental; el efecto se relacionaba con saliencia, asociación aprendida y relevancia percibida.
**Aplicación:** la notificación no debe maximizar el sobresalto visual. Probar legibilidad y visibilidad sin asumir que un color muy intenso, animación o sonido mejora el resultado.

## 3. Qué se sabe de las validaciones y qué no

**Evidencia relativamente directa:** estudios de recordatorios y sedentarismo, pero los resultados varían y no todos los ensayos obtienen diferencias significativas.

**Evidencia relevante pero indirecta:** estética de interfaces móviles, interrupciones de apertura de apps, mensajes personalizados y métodos para optimizar notificaciones de salud.

**No encontrado en esta búsqueda:** un ensayo publicado que compare de forma directa los estilos visuales de una notificación superpuesta a Reels —estilo nativo/discreto frente a estilo amable/de marca— midiendo pausas físicas realizadas. Tampoco encontramos evidencia de que una tarjeta en Canva permita estimar retención, efecto sobre sedentarismo o probabilidad comercial de nikucode.

## 4. Protocolo recomendado para el Canva

### Fase A — Comprender la experiencia actual (sin enseñar soluciones)

**Propósito:** identificar barreras y lenguaje real, no validar una app.
**Participantes:** 5–8 personas cercanas que estudien o trabajen habitualmente frente a pantallas, como muestra de conveniencia.
**Pregunta inicial:** «Cuéntame la última vez que pasaste más tiempo frente a una pantalla del que pretendías o te costó hacer una pausa».
**Preguntas de seguimiento:** qué hacía; qué ocurrió justo antes; si pensó en parar; qué le dificultó hacerlo; qué estrategia intentó; qué hizo después. Evitar sugerir que el problema se debe a adicción, pereza o falta de disciplina.
**Resultado:** registro anónimo de patrones y excepciones, no una estimación de prevalencia.

### Fase B — Probar el mensaje y la acción (mantener estética constante)

Crear dos tarjetas sobre el mismo fondo simulado de una pantalla móvil:

- **A, invitación general:** «¿Te vendría bien una pausa?» + frase breve no directiva.
- **B, acción concreta:** sugerencia física breve y viable + la misma opción para actuar, posponer o rechazar.

Mantener idénticos el fondo, tamaño, color, icono, disposición y botones. Alternar qué versión se muestra primero. Pedir a la persona que describa con sus propias palabras qué propone, qué haría en ese contexto y qué le resultaría molesto. No explicar el objetivo hasta terminar.

**Pregunta de decisión:** ¿la versión concreta reduce dudas sobre qué se puede hacer sin hacer que la invitación se sienta más intrusiva? Si no hay patrón claro, conservar la incertidumbre y modificar el pretotipo.

### Fase C — Probar la estética (con el contenido ya fijado provisionalmente)

Crear dos versiones que solo difieran en la dirección visual:

1. **Discreta/nativa:** tarjeta compacta, jerarquía simple y sin mascota.
2. **Cálida/de marca:** misma estructura, texto, ubicación y controles; cambiar paleta, tratamiento gráfico e icono pequeño.

No comparar dos tarjetas si una tiene más texto, botones o ilustraciones grandes, porque se estarían cambiando varias variables. Alternar el orden y preguntar:

1. «¿Qué entendiste que te propone?»
2. «¿Qué viste primero?»
3. «¿Qué tan fácil fue entender la propuesta?» (1=muy difícil, 7=muy fácil; pregunta exploratoria adaptada)
4. «¿Qué tan inoportuna o intrusiva te resultaría mientras ves un Reel?» (1=nada, 7=mucho)
5. «¿Qué te da confianza, qué te parece artificial y qué quitarías?»

No preguntar solo cuál es más bonita. Registrar si la persona entiende la acción, identifica los controles y detecta algo invasivo/confuso.

### Fase D — Criterios definidos de antemano

Antes de empezar, registrar:
- **Resultado principal del pretotipo:** comprensión sin explicación de lo que propone la notificación.
- **Resultados secundarios:** interpretación de la acción, facilidad percibida, intrusión percibida y comentarios de mejora.
- **Errores críticos:** la persona piensa que se le obliga, no identifica cómo rechazarla, cree que interrumpe una tarea urgente, o confunde la acción propuesta.
- **Decisión:** continuar si el concepto se entiende y no aparecen problemas críticos repetidos; modificar si surgen confusiones consistentes; descartar una variable visual si no aporta una mejora observable o aumenta la intrusión.

Un umbral como «4 de 5 personas entienden la propuesta» puede servir de regla práctica del equipo si se fija antes de la prueba, pero no es un estándar científico ni prueba superioridad estadística. Con una muestra de conveniencia de 5–8 personas, informar recuentos y citas anónimas; no porcentajes generalizables, p-valores ni «tasa de conversión».

## 5. Qué NO puede demostrar un mockup de Canva

- No demuestra que la notificación pueda implementarse encima de Instagram en iOS o Android.
- No mide que una persona realmente haga una pausa ni cuánto se reduce el sedentarismo.
- No demuestra retención, adopción sostenida ni voluntad de pagar.
- No demuestra que la estética cause mejor conducta.
- No permite generalizar desde amistades/familiares a todos los estudiantes o trabajadores.

Una siguiente prueba con prototipo funcional tendría que medir comportamiento, no solo intención: oportunidades elegibles, avisos enviados, acción realizada, posposición/rechazo, pausas no deseadas y carga percibida. Un ensayo microrrandomizado (MRT) podría estudiar después si enviar o no una señal en ocasiones elegibles modifica la probabilidad de una pausa próxima; requiere suficiente muestra, repetición, consentimiento, estrategia analítica y planificación, por lo que no es apropiado como inferencia durante un test pequeño previo.

## 6. Nota de reglas de la hackatón

La preparación metodológica, los guiones de entrevista genéricos y el aprendizaje a partir de literatura son distintos de producir anticipadamente la entrega competitiva. Antes de presentar al evento un mockup específico de la solución o usarlo como parte de la entrega, revisar las bases vigentes o consultar a la organización si el trabajo visual previo está permitido. El producto competitivo debe respetar la regla comunicada de comenzar el viernes y no usar datos personales reales. No incluir respuestas identificables ni datos sensibles de participantes en el repositorio, demo o herramientas de IA.

## 7. Referencias principales

1. Perrig et al. (2023). *Smartphone app aesthetics influence users' experience and performance*. Frontiers in Psychology. https://doi.org/10.3389/fpsyg.2023.1113842
2. Grüning et al. (2023). *Directing smartphone use through the self-nudge app one sec*. PNAS. https://doi.org/10.1073/pnas.2213114120
3. Bidargaddi et al. (2018). *To Prompt or Not to Prompt?* JMIR mHealth and uHealth. https://doi.org/10.2196/10123
4. *Increasing Engagement in the Electronic Framingham Heart Study: Factorial Randomized Controlled Trial* (2023). JMIR. https://doi.org/10.2196/40784
5. *Effects of Framed Mobile Messages on Beliefs, Intentions, Adherence, and Asthma Control: A Randomized Trial* (2024). JMIR. https://doi.org/10.3390/pharmacy12010010
6. Faulkner (2003). *Beyond the five-user assumption*. Behavior Research Methods. https://doi.org/10.3758/BF03195514
7. Moshagen & Thielsch (2013). *A short version of the visual aesthetics of websites inventory*. Behaviour & Information Technology. https://doi.org/10.1080/0144929X.2012.694910
8. Finstad (2013). *The Usability Metric for User Experience (UMUX-LITE)*. CHI. https://doi.org/10.1145/2470654.2481287
9. Fournier et al. (2026). *Attention hijacked: How social media notifications disrupt cognitive processing*. Computers in Human Behavior. https://doi.org/10.1016/j.chb.2026.108926
10. Qian et al. (2022). *The Micro-Randomized Trial for Developing Digital Interventions: Experimental Design and Data Analysis Considerations*. Psychological Methods. https://doi.org/10.1037/met0000283

## Estado

- **EVIDENCIA EXTERNA:** existen estudios que comparan estética, opciones de cancelar, demora/fricción, personalización y envío contextual de notificaciones.
- **INTERPRETACIÓN:** la opción de elección y la claridad de acción merecen prioridad; la estética tiene valor principalmente demostrado en percepción/usabilidad, no en pausas físicas.
- **HIPÓTESIS:** una notificación concreta y de baja intrusión facilitará mejor el paso a una pausa en nikucode que una invitación general.
- **PENDIENTE:** probar el Canva con personas del público de interés, documentar resultados sin datos identificables y no extrapolar a eficacia o retención.
