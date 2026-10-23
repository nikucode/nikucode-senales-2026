# Diseño móvil, confort percibido y bienestar emocional

Fecha: 23-10-2026. Estado: revisión narrativa dirigida y propuesta de evaluación; no es una revisión sistemática ni una validación clínica del producto.

## 1. Pregunta y límite principal

**Pregunta:** ¿qué decisiones de apariencia e interacción tienen mejor sustento para que la app móvil de nikucode resulte clara, poco intrusiva y emocionalmente cómoda durante una pausa?

La literatura no permite garantizar comodidad ni mejora de salud mental mediante una apariencia. La estética puede influir en primeras impresiones, confianza, facilidad percibida y disposición a usar una intervención; esos resultados no equivalen a reducción de ansiedad, estrés clínico, dolor o cambio conductual. En este proyecto, «confort» se tratará como un resultado de experiencia que debe observarse: comprensión, esfuerzo, presión percibida, intrusión, confianza, agrado y facilidad para salir.

La app tampoco es una intervención de salud mental. La literatura de salud digital se usa de forma indirecta porque estudia interfaces en contextos sensibles, no para atribuir efectos terapéuticos a nikucode.

## 2. Método breve

Se revisó primero la documentación vigente del repositorio para no repetir búsquedas, en particular la investigación de estética, la auditoría científica, la matriz de evidencia y el protocolo de validación visual. Después se realizó una búsqueda web dirigida de revisiones y estudios primarios sobre estética de interfaces, color y emoción, diseño de intervenciones digitales de salud y aplicaciones de salud mental.

Se priorizaron artículos revisados por pares, texto completo o resumen primario y resultados que cambian una decisión del MVP. No se hizo búsqueda exhaustiva en bases bibliográficas, doble cribado, evaluación formal de riesgo de sesgo ni metaanálisis propio. Por ello, este documento sirve para tomar decisiones provisionales y diseñar pruebas, no para afirmar causalidad clínica.

## 3. Hallazgos que sí cambian el diseño

| Hallazgo | Evidencia | Límite | Decisión para nikucode |
|---|---|---|---|
| Una presentación visual cuidada puede mejorar estética y usabilidad percibidas. | Perrig et al. (2023), experimento aleatorizado con 281 participantes: la variante más estética obtuvo mayores puntuaciones de estética percibida (`d=1,26`) y usabilidad percibida (`d=0,86`); los resultados objetivos de tarea fueron mixtos. | App web móvil y tarea de contenido, no pausas ni salud mental. | El acabado visual merece tiempo, pero se evalúa separado de comprensión, éxito de tarea y conducta física. |
| En interfaces de salud, simplicidad y apariencia de trabajo cuidado influyen más consistentemente que colorido o novedad. | Denison-Day et al. (2023), estudio cuasiexperimental con 601 participantes y nueve estímulos: simplicidad y *craftsmanship* predijeron facilidad, utilidad, disfrute y confianza percibidas; los efectos directos sobre intención fueron modestos. | Estímulos estáticos e intención declarada, no uso real ni resultado clínico. | Jerarquía clara, alineación, espaciado consistente y estados completos tienen prioridad sobre decorar o aumentar colores. |
| Los colores poseen asociaciones emocionales relativamente consistentes, pero asociación no significa emoción causada. | Jonauskaite y Mohr (2025), revisión sistemática de 132 artículos, 42.266 participantes y 64 países: tonos claros se asociaron con emociones positivas; azul/verde/blanco con valencia positiva y baja activación. Los autores indican que falta demostrar si esas asociaciones se traducen en emociones experimentadas en contextos aplicados. | Estudios muy heterogéneos y, en gran parte, asociaciones abstractas fuera de interfaces. | Los pasteles fríos/cálidos suaves son una hipótesis de identidad, no una prescripción psicológica. Elegirlos por legibilidad, coherencia y prueba con usuarios. |
| El efecto del color depende del contexto, la experiencia y la persona. | Elliot (2015), revisión teórica y empírica: la psicología del color todavía presenta problemas de control, muestras y generalización. Garrido et al. (2024), talleres con 24 jóvenes, encontró preferencias y efectos percibidos contextuales; no una paleta universal. | La revisión de 2015 no es específica de UI; el estudio de 2024 es cualitativo, pequeño y sobre una app musical de manejo del ánimo. | No afirmar «azul calma» o «rosa reduce ansiedad». Ofrecer tema del sistema cuando sea viable y comprobar la paleta en los dispositivos reales. |
| Acumular técnicas persuasivas no demuestra mayor eficacia ni participación. | Valentine et al. (2025), revisión y metaanálisis de 92 RCT de apps de salud mental: no encontró asociación significativa entre cantidad de principios persuasivos y eficacia (`b=0,01`, `p=0,804`), ni con finalización en el subconjunto comparable (`r=0,21`, `p=0,43`). | Apps terapéuticas heterogéneas; la codificación de principios se obtuvo de descripciones y las métricas de participación variaron mucho. | No añadir rachas, premios, mascota, presión social o elogios para hacer la interfaz «amable». El MVP prioriza autonomía y tarea principal. |
| La evaluación de usabilidad en salud mental suele ser limitada y no sustituye diseño participativo. | Inal et al. (2020), revisión sistemática de 42 estudios de tecnologías móviles de salud mental: predominaron muestras pequeñas y evaluaciones sumativas con un solo cuestionario; hubo pocos relatos de diseño participativo. | Intervenciones de salud mental y literatura hasta 2018. | Combinar observación de tareas, preguntas abiertas y medidas breves; no declarar validación por una escala o por opinión del equipo. |

## 4. Traducción a una dirección visual móvil

### Requisitos antes que preferencias

1. Una acción principal clara por pantalla y salida visible en todo momento.
2. Controles táctiles de al menos `48×48 dp`, texto escalable y ausencia de información transmitida solo mediante color.
3. Contraste de texto normal de al menos `4,5:1` y de componentes/estados relevantes de al menos `3:1`, usando WCAG como referencia y comprobando la implementación Android real.
4. Sin animación continua, parpadeos, sonido obligatorio ni cuenta regresiva que impida terminar o apartar la mirada.
5. Estados predecibles para aviso apagado, permiso denegado, programación, cancelación, guía detenida y guía terminada.
6. Lenguaje invitacional y descriptivo. Evitar culpa, diagnóstico, urgencia falsa y afirmaciones como «cumpliste», «recuperaste energía» o «hiciste una pausa saludable».

### Paleta candidata, no terapéutica

Se conserva la paleta ya contrastada en el proyecto:

- fondo cálido `#FAF8F5`;
- texto principal `#202124`;
- acción primaria `#62567A` con texto blanco;
- superficies opcionales lavanda `#EAE2F4`, rosa `#F4E1E7` y verde `#E0EEE5`.

Estos pares sólidos tienen contrastes previamente calculados entre `6,33:1` y `15,19:1` para los usos documentados. No se deduce de ello que reduzcan estrés. Los pasteles se usarán en superficies secundarias, no para ocultar jerarquía ni estados. Rojo o naranja intenso se reservará para información que realmente requiera atención y nunca será la única señal de error.

### Composición propuesta

- Fondo mayormente neutro, una superficie de apoyo y un solo acento dominante por pantalla.
- Tipografía del sistema, cuerpo inicial de `16–18 sp`, dos pesos principales y líneas de longitud moderada.
- Espaciado consistente y agrupación por función; evitar mosaicos, métricas, rachas o catálogos en Inicio.
- Ilustración pequeña y estática solo si no desplaza instrucciones o controles. Sin mascota en el MVP.
- Botón principal lleno; acciones secundarias con menor énfasis pero legibles. «Ahora no» y «Detener» no se esconden ni se presentan como fallo.
- Respetar tema y reducción de movimiento del sistema cuando la implementación lo permita. El modo oscuro será una adaptación de accesibilidad/preferencia, no una promesa de beneficio psicológico.

## 5. Hipótesis de diseño comprobable

> Una interfaz de baja complejidad, visualmente cuidada y con control explícito será percibida como más clara y menos presionante que una interfaz más decorada o persuasiva, sin necesitar afirmar un efecto sobre salud mental.

La hipótesis tiene tres componentes que deben medirse por separado:

1. **Claridad:** la persona comprende la propuesta y encuentra actuar, cambiar, posponer, rechazar y detener.
2. **Confort percibido:** informa baja presión/intrusión y puede explicar qué elemento le resulta cómodo o incómodo.
3. **Atractivo/confianza:** considera la interfaz agradable y suficientemente cuidada para usarla.

Ninguno demuestra que la persona se movió, que disminuyó su estrés o que la app protege su salud mental.

## 6. Prueba A/B exploratoria durante la hackatón

Comparar dos prototipos con **idénticos textos, flujo, controles, tamaños y orden**:

- **A · sobria:** fondo neutro, violeta como único acento, sin ilustración.
- **B · cálida:** mismas posiciones y jerarquía, superficies pastel y una ilustración estática pequeña.

Usar 5–8 participantes de conveniencia que estudien o trabajen con pantallas. Alternar qué variante ven primero. Esta muestra sirve para hallar problemas y patrones cualitativos, no para estimar preferencias de una población ni declarar una variante estadísticamente superior.

### Tareas

1. Interpretar una propuesta sin explicación previa.
2. Cambiar una propuesta que no resulta adecuada.
3. Posponer y después cancelar.
4. Rechazar sin iniciar una guía.
5. Iniciar y detener una guía.

### Registro mínimo por participante

- tarea completada sin ayuda y errores críticos;
- primer elemento observado;
- facilidad posterior a cada tarea, escala 1–7 tipo SEQ;
- «¿Cuánta presión sentiste para aceptar?», 1–7, pregunta exploratoria no validada;
- «¿Qué tan intrusiva te resultó?», 1–7, pregunta exploratoria no validada;
- «¿Qué parte se sintió cómoda o incómoda y por qué?»;
- preferencia final y razón, sin tratarla como el único resultado.

### Criterio de decisión previo

Se descarta o modifica cualquier variante donde se repita un error crítico: no encontrar salida, interpretar obligación, confundir guía terminada con movimiento verificado, o no poder leer/accionar un control. Entre variantes sin errores críticos repetidos, se prefiere la que muestre menos confusión y presión observadas. Si los resultados son mixtos, se conserva la versión más sencilla de implementar y se registra incertidumbre.

No se almacenan nombres, diagnósticos ni respuestas clínicas. Si se publican resultados, usar recuentos y citas anonimizadas; no porcentajes generalizables ni afirmaciones de salud mental.

## 7. Conclusión operativa

La dirección más defendible para el móvil es **cálida, sobria, predecible y controlable**, no «terapéutica». La evidencia apoya cuidar simplicidad y acabado porque afectan percepción de facilidad y confianza. No respalda una paleta universalmente calmante ni que una estética bonita mejore por sí sola salud mental o conducta.

Para el MVP: implementar primero estructura y accesibilidad, aplicar la paleta candidata con moderación y comparar una variante sobria con otra cálida. El objetivo verificable no es emocional ni clínico: es ofrecer control, salida y estados honestos, y comprobar que se comprendan; el confort percibido debe evaluarse con personas.

## 8. Referencias principales

1. Perrig, S. A. C., Ueffing, D., Opwis, K., & Brühlmann, F. (2023). *Smartphone app aesthetics influence users' experience and performance*. Frontiers in Psychology, 14, 1113842. https://doi.org/10.3389/fpsyg.2023.1113842
2. Denison-Day, J. L., Muir, S., Newell, C., & Appleton, K. M. (2023). *The Role of Aesthetics in Intentions to Use Digital Health Interventions*. PLOS Digital Health, 2(6), e0000274. https://doi.org/10.1371/journal.pdig.0000274
3. Jonauskaite, D., & Mohr, C. (2025). *Do we feel colours? A systematic review of 128 years of psychological research linking colours and emotions*. Psychonomic Bulletin & Review, 32, 1457–1486. https://doi.org/10.3758/s13423-024-02615-z
4. Elliot, A. J. (2015). *Color and psychological functioning: a review of theoretical and empirical work*. Frontiers in Psychology, 6, 368. https://doi.org/10.3389/fpsyg.2015.00368
5. Garrido, S., Doran, B., Oliver, E., & Boydell, K. (2024). *Desirable design: What aesthetics are important to young people when designing a mental health app?* Health Informatics Journal, 30(4). https://doi.org/10.1177/14604582241295948
6. Valentine, L., et al. (2025). *A meta-analysis of persuasive design, engagement, and efficacy in 92 RCTs of mental health apps*. npj Digital Medicine, 8, 229. https://doi.org/10.1038/s41746-025-01567-5
7. Inal, Y., Wake, J. D., Guribye, F., & Nordgreen, T. (2020). *Usability Evaluations of Mobile Mental Health Technologies: Systematic Review*. Journal of Medical Internet Research, 22(1), e15337. https://doi.org/10.2196/15337
8. W3C. *Web Content Accessibility Guidelines (WCAG) 2.2*. https://www.w3.org/TR/WCAG22/
