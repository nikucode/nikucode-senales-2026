# Referentes visuales, tema oscuro y especificación ligera

**Fecha:** 23 de octubre de 2026  
**Estado:** revisión dirigida para orientar el pretotipo. Las referencias comerciales y los premios no demuestran eficacia conductual; las propuestas visuales siguen pendientes de evaluación con personas.

## Síntesis para decidir

Probar una identidad propia basada en **una corriente o estela de agua que abre un intervalo en la jornada**: una forma central que se transforma entre propuesta, guía y regreso. El nombre de trabajo puede ser **«Marea»**, sujeto a revisión del equipo. Esto ofrece un motivo reconocible sin recurrir a gemas, mascotas, rachas o un dashboard. La dirección puede combinar composición limpia con una capa visual líquida inspirada en interfaces de principios de los 2000, pero con mucho menos detalle que el Frutiger Aero histórico.

Probar en paralelo una variante oscura de tinta azul petróleo y reflejos suaves, manteniendo como control la versión cálida clara actual. No afirmar que el tema oscuro sea calmante: hay evidencia de preferencias y de carga subjetiva en contextos específicos, no de calma, mejor ánimo ni más pausas en esta app. Mantener fija la estructura, el contenido y los controles para poder comparar solo el tratamiento visual.

## Qué aprender de los Apple Design Awards 2025

Apple premia innovación, diseño e integración tecnológica; sus descripciones son evaluaciones editoriales del premio, no ensayos sobre resultados de salud. Además, **Opal fue finalista en Impacto Social; el ganador de Apps fue Watch Duty**. [Apple Design Awards 2025](https://developer.apple.com/design/awards/2025/)

| Referente y reconocimiento | Principio transferible | Aplicación posible en nikucode | Límite / no copiar |
|---|---|---|---|
| **CapWords**, ganador, Delight & Fun | Una acción concreta convierte objetos cotidianos en aprendizaje; transiciones y detalles sensoriales refuerzan una idea sencilla. | Que la pausa se entienda en segundos y que la estela cambie de manera expresiva al pasar de propuesta a guía y regreso. | No añadir cámara, sonidos, stickers o estímulos constantes. Apple describe una experiencia premiada, no mide aprendizaje para nuestro caso. |
| **Train Fitness**, finalista, Inclusivity | Diseñar para no depender siempre de mirar y tocar la pantalla; contemplar explícitamente modos y capacidades diversas. | Instrucción que puede dejarse de mirar, lectura accesible y alternativas de interacción. | No inferir movimiento con sensores ni añadir seguimiento; su implementación depende del ecosistema Apple y no valida un ejercicio universal. |
| **Evolve: Daily Self-Care Coach**, finalista, Inclusivity | Tono directo e inclusivo, voces diversas y cuidado al definir para quién es el servicio. | Lenguaje que invita sin culpa, y contenido adaptable sin exigir revelar identidad o datos personales. | No presentar la app como espacio clínico ni prometer efectos de afirmaciones, respiración o journaling. |
| **Play**, ganador, Innovation | Hacer que prototipar interacción compleja sea accesible y visual. | Probar el recorrido como una secuencia interactiva y revisar cómo se siente el cambio entre estados antes de expandir funciones. | El premio es a una herramienta de prototipado; no implica que nikucode deba copiar su interfaz o que una animación mejore conducta. |
| **Opal**, finalista, Impacto Social | Marca visual consistente y un motivo reconocible pueden dar continuidad a distintas pantallas. | Mantener una metáfora propia durante el recorrido; observar su onboarding solo como referencia de progresión. | No copiar gema, iluminación, paleta, textos, onboarding, puntajes o bloqueo. La nominación no prueba que su estética cause mejores resultados. |

La lista oficial describe a CapWords como aprendizaje mediante fotografías, animación y sonidos; a Train Fitness como seguimiento del entrenamiento sin interacción con pantalla y modos específicos; a Evolve como autocuidado orientado a la comunidad LGBTQ+; y a Play como prototipado visual integrado con SwiftUI/Xcode. Estas descripciones ayudan a extraer decisiones de oficio y accesibilidad, no resultados causales para nuestra intervención. [Apple Developer](https://developer.apple.com/design/awards/2025/) · [Historia de diseño de CapWords](https://developer.apple.com/articles/capwords/).

## Tema oscuro: qué se sabe

Un estudio cualitativo de codiseño con 25 jóvenes de 13–25 años, desarrollado para una app musical de manejo del ánimo, identificó preferencias por simplicidad, sutileza y, en varios participantes, paletas oscuras asociadas con sofisticación o comodidad. También aparecieron asociaciones de oscuridad con tristeza; los participantes advirtieron que colores demasiado brillantes pueden sentirse estridentes. Los autores recalcan que las preferencias son contextuales y que el estudio pequeño no debe generalizarse. Esto sustenta **probar** un oscuro sobrio, no llamarlo calmante ni terapéutico. [Garrido et al., 2024](https://doi.org/10.1177/14604582241295948).

Un experimento de seguimiento ocular de 2025 comparó modos claros y oscuros en dashboards con 15 participantes analizables (13 en algunas métricas), en un laboratorio tenue. El oscuro redujo la carga mental subjetiva y mostró ventajas de exactitud, confianza y fijaciones en tareas de complejidad media; no hubo diferencias significativas globales en tiempo de tarea. La pupila mostró otra dirección que el autoinforme, y el estudio no examinó pausas ni sensación de calma. No se puede extrapolar a una propuesta de una sola acción. [Ettling et al., ETRA 2025](https://doi.org/10.1145/3715669.3725879).

La legibilidad depende también de iluminación, tamaño, contraste y duración de lectura. Un estudio de lectura breve encontró ventajas para polaridad positiva (texto oscuro en fondo claro) en algunas condiciones; esto no invalida un tema oscuro, pero refuerza que debe comprobarse con nuestro contenido y contextos. [Dobres et al., 2017](https://pubmed.ncbi.nlm.nih.gov/28166901/). Apple recomienda que las interfaces oscuras se adapten a la preferencia del sistema y al contexto de luz; es una guía de plataforma, no evidencia clínica. [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/dark-mode).

**Decisión recomendada:** tema oscuro como variante o preferencia del sistema en una etapa posterior. Para el pretotipo actual, crear una comparación visual, no cambiar a oscuro como única opción. Medir comprensión del siguiente paso, localización de «Ahora no» y «Detener», errores, esfuerzo percibido y preferencia por separado. No medir «calma» como si la paleta la hubiera causado con una pregunta aislada.

## Lenguajes visuales: posibilidades y riesgos

| Lenguaje | Aporte que se puede explorar | Riesgo / afirmación no respaldada | Uso acotado propuesto |
|---|---|---|---|
| **Liquid / fluid design** | Una metáfora continua puede dar continuidad entre estados. | «Fluido» no significa automáticamente intuitivo; el vidrio/transparencia puede bajar contraste y difuminar límites. | Una forma vectorial central que cambia una vez al navegar; controles sólidos y delimitados. |
| **Organic modernism** | Curvas, composición editorial y asimetría pueden evitar la sensación de plantilla corporativa. | No hay una ventaja sanitaria demostrada de las curvas. Asimetría excesiva puede dificultar localizar acciones. | Curvas en ilustración/fondo; posición y etiqueta de acciones consistentes. |
| **Frutiger Aero / nostalgia tecnológica** | Cielo, agua y reflejos pueden proporcionar una identidad juguetona y reconocible. | Es una categoría cultural/estética, no una intervención probada. El maximalismo, el bokeh o las burbujas pueden aumentar ruido visual o mareo. | Referencia cromática y material, no recreación literal: una sola estela acuática y pocos reflejos. |
| **Claymorphism** | Sensación táctil, blanda y amable. | Sombras tenues pueden borrar bordes, foco, estados y límites de controles. | No usar sombras como único indicador; dar contorno/contraste y foco visibles. |
| **Soft UI / neumorfismo** | Continuidad entre superficie y fondo, apariencia suave. | Bajo contraste de componentes; control y superficie pueden confundirse. | Evitar en acciones principales. Sombras solo decorativas, nunca necesarias para reconocer una acción. |
| **Glassmorphism / Liquid Glass** | Profundidad y translucidez pueden aportar sensación de ligereza. | Legibilidad cambia según lo que quede detrás; muchas capas pueden distraer y aumentar coste de renderizado. | Vidrio solo en ornamento no textual, con fondo estable; ningún texto, estado o control sobre superficie variable. |

Los nombres de estilo no constituyen evidencia de usabilidad. La accesibilidad debe verificarse sobre la interfaz renderizada: WCAG 2.2 exige, entre otras cosas, contraste mínimo de texto normal de 4,5:1 en web, que el color no sea el único canal de información y tolerancia a ampliación/reflujo en criterios definidos. Transparencias requieren comprobar el peor fondo posible; una cifra calculada sobre un color plano no basta. [W3C WCAG 2.2](https://www.w3.org/TR/WCAG22/).

## Dirección de arte y flujo candidato

**Nombre visual de trabajo: «Marea»** (no decisión de marca). El elemento principal es una línea/onda abierta, como un espacio que se hace en la tarea. Debe ser original y dibujado para el proyecto. No incluir puntuación, mascota obligatoria ni metáforas de productividad.

- **Composición:** una etapa por pantalla, motivo visual al centro, título breve y una acción principal inmediatamente reconocible. Opciones secundarias siguen visibles abajo y mantienen orden en todos los estados. En escritorio se centra el mismo núcleo dentro de un campo amplio; no se expande a dashboard.
- **Color:** comparar fondo claro cálido con fondo oscuro azul tinta/petróleo. En ambas, acentos suaves verdosos, lilas o agua; evitar texto en gradientes. El color no comunica por sí solo éxito, error o disponibilidad.
- **Material:** probar una estela translúcida decorativa en el fondo, sin card de vidrio ni capas detrás de las instrucciones. Base opaca de alto contraste.
- **Transiciones:** un morph/cambio de trazo de 180–280 ms al cambiar de estado, sin loops, parallax, rebote o desplazamiento que obligue a seguir con la mirada. Respetar `prefers-reduced-motion`/la configuración del sistema; en reducción, cambio inmediato sin pérdida de estado.
- **Texto:** una frase funcional por etapa. La guía permite apartar la vista; «Detener» y «Ahora no» permanecen como etiquetas textuales.

La iteración implementada el 23-10 usa la variante oscura: composición central, base azul tinta, reflejos acuáticos, forma líquida propia, botones ovalados sólidos y una transición breve del estado completo que respeta movimiento reducido. `flutter analyze --no-pub` pasó; el render headless pasó 20 comprobaciones y generó ocho capturas. La ventana Linux no se pudo abrir en esta sesión por falta de display. Quedan pendientes comparación con el tratamiento claro, contraste sobre las superficies renderizadas en varios dispositivos, teclado/lector y observación de comprensión con personas. Las capturas y sus límites están en [evidencia del prototipo](PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).

## Experimento visual pequeño

Comparar 2×2 solo si hay tiempo y personas suficientes: claro/oscuro × orgánico sobrio/líquido más expresivo. Mantener contenido, posición de botones, flujo y tipografía iguales. Si son pocas personas, comparar primero claro frente a oscuro con la misma ilustración, para no confundir variables.

1. Tarea sin explicación: «Te gustaría hacer una pausa ahora. ¿Qué harías?». Observar si encuentra cómo empezar, cambiar o rechazar.
2. «¿Cómo detendrías esta guía?» y «¿qué ocurre si no quieres hacerlo ahora?». No inducir respuesta.
3. Registrar éxito sin ayuda, errores, dudas, uso de controles, lectura en pantalla y preferencia. Preferencia no equivale a facilidad ni a que se vaya a usar de nuevo.
4. Probar teclado/lector y texto ampliado en la versión implementada; la maqueta no acredita accesibilidad de tecnología asistiva.
5. Si la muestra es pequeña, usar hallazgos como problemas observados, no porcentajes representativos.

## Aplicación ligera de Spec-Driven Development (SDD)

No encontramos una modificación SDD persistida en la guía/estado al revisar la rama antes de esta actualización, pese a que la conversación de Copilot pegada indicaba que ya se había aplicado. Se integra ahora en la guía del proyecto para mantener una sola fuente de verdad.

OpenSpec propone explorar, proponer, revisar, aplicar y archivar cambios; Spec Kit utiliza especificación, plan, tareas, implementación y convergencia. Son flujos de sus herramientas, no un estándar común ni una garantía de calidad. Para el tiempo y tamaño de este proyecto basta un ciclo manual breve, sin instalar CLI ni duplicar la guía. [OpenSpec Quickstart](https://openspec.dev/docs/quickstart) · [Spec Kit Quickstart](https://github.github.io/spec-kit/quickstart.html) · [Kiro Specs](https://kiro.dev/docs/specs/).

1. **Explorar:** describir persona, problema concreto, hipótesis y alternativa considerada.
2. **Especificar:** escribir una condición observable en lenguaje de usuario y enlazarla con AC existente; crear un AC solo si hay una condición nueva.
3. **Revisar:** el equipo acepta, cambia o posterga el alcance antes del código.
4. **Implementar:** un corte vertical, responsable y rutas de archivos explícitos.
5. **Verificar:** registrar versión/destino, resultado y límites. Estados: propuesta → aceptada → implementada → verificada en alcance indicado; o aplazada/descartada.
6. **Cerrar:** actualizar esta guía, estado compartido y evidencia; dejar la especificación vigente como fuente y archivar solo decisiones reemplazadas.

**Ficha mínima por cambio:** `Problema | Hipótesis | Requisito observable | AC | Fuera de alcance | Responsable | Evidencia/entorno | Estado | Límite`.

**Ejemplo de tema y transición:** requisito propuesto: «Con la opción de movimiento reducido activa, el cambio entre propuesta y guía no ejecuta la transición decorativa y conserva el foco en la acción principal». Se enlaza a AC10; verificar en el destino real y anotar sistema/versión. Un widget test podría demostrar que un estado se construyó sin animación bajo una preferencia simulada; no demuestra uso accesible con lector de pantalla. «La variante oscura se siente calmante» no es un requisito técnico: queda como pregunta de investigación con personas, no como AC de código.

## Referencias

- Apple, [Design Awards 2025](https://developer.apple.com/design/awards/2025/) y [detrás del diseño de CapWords](https://developer.apple.com/articles/capwords/).
- Garrido et al. (2024), [*Desirable design: What aesthetics are important to young people when designing a mental health app?*](https://doi.org/10.1177/14604582241295948).
- Ettling et al. (2025), [*An Eye Tracking Study on the Effects of Dark and Light Themes on User Performance and Workload*](https://doi.org/10.1145/3715669.3725879).
- Dobres et al. (2017), [*The effects of age, font size and display polarity on glance legibility*](https://pubmed.ncbi.nlm.nih.gov/28166901/).
- W3C, [Web Content Accessibility Guidelines 2.2](https://www.w3.org/TR/WCAG22/).
- [OpenSpec](https://openspec.dev/docs/quickstart), [GitHub Spec Kit](https://github.github.io/spec-kit/quickstart.html), [Kiro Specs](https://kiro.dev/docs/specs/).
