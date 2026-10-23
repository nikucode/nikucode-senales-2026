# Investigación integral y decisiones para el MVP

Fecha: 23-10-2026, preparación antes de la bienvenida. Ejecución del [prompt V2](investigacion/PROMPT_MAESTRO_INVESTIGACION_INTEGRAL_2026-10-23.md). Investigación dirigida e integración del acervo existente, no revisión sistemática ni evaluación propia de eficacia. La app competitiva no se desarrolló en este bloque.

## 1. Dictamen y decisiones que ahorran trabajo

Recomendación del asistente para revisar al iniciar: **construir un recorrido pequeño que ayude a pasar de una tarea a una pausa viable, conservando control y una salida rápida en computador y celular**. Una oportunidad perceptible y una propuesta comprensible son hipótesis plausibles; su combinación no está validada para nikucode.

El progreso consiste en convertir dudas generales en decisiones y comprobaciones concretas. No corresponde elegir una app cargada de funciones ni continuar buscando hasta declarar certeza. Lo que más podría invalidar la demo es que el aviso no llegue al contexto prometido, que la propuesta física no sea viable o que la experiencia añada obligación.

Cambios de esta integración:

- El control explícito se conserva, pero no se afirma que añadir opciones mejore siempre la conducta. Se propone una opción inicial modificable, sin configuración extensa.
- La oportunidad social se convierte en condición del caso de uso: no todo rechazo es una oportunidad perdida por la app. No se interpretan rechazos como poca motivación.
- Se propone **programación puntual**, sin recurrencia automática inicial, para cerrar un contrato implementable. Esto se somete a prueba técnica y revisión del equipo; no es una frecuencia saludable.
- Se concreta contenido candidato: caminar si es adecuado y una alternativa de movimiento habitual elegido. No se receta una rutina ni se equiparan sus desenlaces.
- La señal depende del sistema. Flutter es una candidata si los dispositivos/herramientas lo permiten; responsive no garantiza aviso con app cerrada.
- La estética se convierte en una dirección lista para aplicar y comprobar, evitando otra ronda de elección visual antes del recorrido funcional.
- La revisión cruzada R05 detectó dos huecos de contrato: entrega del SO durante una propuesta y confusión entre hora programada/caducidad. Se corrigieron guía, ficha y documento técnico: abrir consume/cancela la invitación; validez por identificador/generación, sin TTL adicional inicial. No se garantiza impedir un banner ya entregado. Son correcciones de diseño, no bugs observados.

Detalles para ejecutar: [guía de implementación y aceptación](GUIA_IMPLEMENTACION_Y_ACEPTACION_2026-10-23.md). Estado operativo: [estado compartido](ESTADO_COMPARTIDO.md).

## 2. Método, alcance y cola de decisiones

Insumos: prompt vigente, auditoría/ficha/matriz recientes, informe de interfaz, flujo de herramientas y contexto de evento. Se reutilizaron resultados anteriores; no se reabrieron metaanálisis en cuarentena ni pruebas de competidores ya documentadas. Dos encargos independientes: R01 evidencia social/contextual, R02 viabilidad técnica. El principal investigó recuperación/contenido, contrastó accesibilidad y documentación actual de Opal e integró decisiones/evaluación/presentación.

Acceso: búsqueda web integrada y apertura de fuentes primarias; archivos locales; comprobaciones de versiones/PATH por R02. No se consultaron directamente PsycINFO, Scopus o una búsqueda completa de PubMed. No hubo selección doble de todos los registros, GRADE, registro prospectivo, conteo PRISMA nuevo, entrevistas ni ensayos humanos. Las fechas de las fuentes no sustituyen su año de campo.

Pregunta PCC: personas adultas en estudio/trabajo con dispositivos; transición a pausas y carga; contextos con autonomía variable. Para evaluar después el paquete, pregunta causal candidata: frente a señal simple acordada, ¿la propuesta directa/modificable facilita iniciar la acción acordada sin mayor carga en oportunidades comparables? Población, ventanas y asignación deben definirse en un protocolo posterior.

Elegibilidad dirigida: estudios y marcos que pudieran cambiar una decisión, originales accesibles, cualitativos pertinentes, fuente local cuando existe, documentación oficial de APIs/normas y productos. Se admitió un resumen primario con límite explícito. Se excluyeron publicidad/testimonios como prueba causal y contextos clínicos como fuente de prescripción general. No se aplicó un filtro cronológico fijo; se buscaron capacidades actuales y fundamentos pertinentes sin confundir novedad con calidad.

| Orden | Decisión | Información faltante | Dependencia / salida |
|---|---|---|---|
| 1 | Qué comportamiento demostramos | Viabilidad de acción y resultado observado | Contenido + definición de inicio; no mide hábito |
| 2 | Cómo llega la propuesta | Sistemas reales y aviso fuera de primer plano | Prueba técnica temprana; puede cambiar arquitectura/promesa |
| 3 | Qué construimos | Contratos de control, errores y accesibilidad | Recorrido vertical de ambos destinos |
| 4 | Qué afirmamos | Evidencia real del artefacto y límites | Demo y pitch actualizados después de probar |
| 5 | Qué ampliamos | Beneficio incremental y recursos | Hoja de expansión; no bloquea núcleo |

## 3. Evidencia decisiva añadida o recontrastada

Los IDs R23 se incorporan a la matriz central. T23 son IDs locales del documento técnico; AUD23/VIS existentes se reutilizan, no cuentan como replicaciones nuevas. La confianza es un juicio narrativo de pertinencia/acceso, no una puntuación GRADE.

| ID | Fuente primaria / acceso | Diseño, hallazgo pertinente y límites |
|---|---|---|
| R23-01 | Albulescu et al. 2022, [artículo PLOS](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0272460). Texto: método, resultados y limitaciones. | Revisión de 19 publicaciones, 22 muestras, N=2335; pausas de hasta diez minutos en empleados/estudiantes sanos. Efectos pequeños en vigor/fatiga; rendimiento global sin mejora significativa. Predominan límites de sesgo y resultados agudos. No valida nuestra dosis, contenido adaptado ni adopción. El resumen y el cuerpo difieren en el p de rendimiento; no se usa ese p como argumento ni se recalcula. |
| R23-02 | [OMS, guía 2020](https://www.who.int/publications/i/item/9789240015128) — presentación, descarga fallida — y [ficha oficial 2024](https://www.who.int/news-room/fact-sheets/detail/physical-activity), definiciones/beneficios. | Referencias de salud pública sobre actividad/sedentarismo y diversidad de poblaciones. Dan relevancia al problema; no acreditan prevención clínica mediante este producto ni un intervalo único. No se afirma lectura completa de la guía. |
| R23-03 | Hadgraft et al. 2016, [texto editorial](https://link.springer.com/article/10.1186/s12889-016-3611-y); métodos/resultados/límites por R01. | Entrevistas a 20 trabajadores/responsables en tres organizaciones de Melbourne, conveniencia y análisis temático. Carga, dependencia del computador, mobiliario y normas condicionan moverse. Organizaciones interesadas y relativamente favorables: transferencia limitada. No estima frecuencia ni efecto de políticas. |
| R23-04 | Pachu et al., [DOI](https://doi.org/10.1080/07448481.2020.1786098), texto [depositado por autor](https://www.researchgate.net/publication/342998590_University_students%27_knowledge_self-efficacy_outcome_expectations_and_barriers_related_to_reducing_sedentary_behavior_a_qualitative_study) tras fallo editorial. | Cuatro grupos, 19 estudiantes de una universidad canadiense; reclutamiento por avisos. Conocimiento puede coexistir con prioridades, normas e infraestructura que dificultan actuar. Muestra restringida y no prueba de intervención. Publicación online 2020, volumen final 2022. |
| R23-05 | Valdebenito et al. 2024, DOI 10.52611/confluencia.2024.948; [PDF revista UDD](https://revistas.udd.cl/index.php/confluencia/en/article/download/948/786/4514), seis páginas por R01. | Diez entrevistas de enfermería en universidad privada de Santiago, campo 2023, nueve mujeres; voluntariado/bola de nieve. Carga, cuidado, traslados, recursos y pares aparecen en relatos. Trata actividad/ejercicio, no esta transición de pantalla; mezcla términos en pasajes. Antecedente local, no prevalencia nacional ni prueba de app. |
| R23-06 | Hiemstra et al. 2024, DOI 10.1093/tbm/ibad047; [resumen primario PubMed](https://pubmed.ncbi.nlm.nih.gov/37584487/), sin texto completo por R01. | Aleatorizado, 148 teletrabajadores, cuatro semanas: estrategias elegidas/asignadas. Sin diferencias significativas en frecuencia de pausas/tiempo sentado; asignación favoreció otros desenlaces. No prueba retirar el rechazo ni número de botones; no había grupo sin intervención. Evidencia parcial contra «más elección siempre mejor». |
| R23-07 | Hadgraft et al. 2017, DOI 10.1186/s12966-017-0530-y; [original PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC5450410/), métodos/apoyo/procesos por R01. | Cualitativo tras Stand Up Victoria: 21 entrevistas y siete personas en dos grupos, intervención multicomponente de doce meses. Apoyos y tensiones organizativas; selección de voluntarios con mayores cambios. No aísla app, liderazgo ni mantenimiento objetivo. |
| R23-08 | [Opal: Sessions](https://opalapp.com/help/what-are-sessions), documentación comercial actual leída. | Describe niveles de restricción, cancelación y pase de emergencia. No son resultados de investigación ni prueba de interfaz usada por nosotros. Contraste de mecanismo: limitar acceso a apps no equivale a iniciar una pausa física. |
| R23-09 | [Opal: Notifications](https://opalapp.com/help/how-to-use-notifications), documentación leída. | Tipos de avisos y desactivación; la propia ayuda diferencia funciones iOS/Android. Inspira explicitar control y destino, sin copiar todo ni dar por probada paridad o eficacia. |
| R23-10 | [BCN: ley 19.628](https://www.bcn.cl/leychile/Navegar?dt=open&idLey=19628), metadatos indexados, apertura incompleta; [BCN ley 21.719](https://www.bcn.cl/leychile/navegar?idNorma=1209272&idParte=10527471&idVersion=2026-12-01), ficha indexada; [Ministerio de Economía](https://www.economia.gob.cl/2026/09/01/gobierno-propone-ampliar-plazo-para-implementar-nueva-ley-de-proteccion-de-datos-y-institucionalidad.htm), nota leída. | A la consulta, BCN muestra ley 19.628 y reforma diferida a 1-12-2026; el ministerio describe propuesta para 2027. No confundir proyecto con postergación aprobada. No se examinó expediente completo ni se emite dictamen de cumplimiento. Revisar vigencia al escalar con datos reales. |

Referencias reutilizadas: AUD23-01…06 para especificación, contexto, desarrollo y aceptabilidad; Iqbal/Teuber/HeartSteps/Bergouignan con límites de la auditoría. VIS-01/Perrig recontrastado en método/tabla 2: se mantiene diferencia entre percepción y desempeño, sin repetir aquí sus cifras. [Original](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2023.1113842/full). [WCAG 2.2](https://www.w3.org/TR/WCAG22/) reconsultado como norma, no eficacia. La matriz conserva referencias previas de hábitos y gamificación; no justifican incorporarlos al MVP.

## 4. Modelo del problema y teoría de cambio candidata

Distinciones operativas: sedentarismo requiere postura/intensidad en vigilia; inactividad física es no alcanzar recomendaciones de actividad; pantalla describe interacción/exposición. Pausa interrumpe tarea, pero puede seguir sentada/en pantalla. Dolor, somnolencia y agotamiento son experiencias diferentes, no detectadas por un reloj de app. Se conserva la terminología SBRN (AUD23-06).

El relato propio y fuentes externas son compatibles con varias configuraciones: no percibir una oportunidad; percibirla sin poder actuar; poder actuar y posponer; iniciar una pausa que añade carga; descansar en pantalla. No se determinó su prevalencia ni su peso en nikucode. La app cubre parte de la secuencia; no crea permiso laboral, tiempo libre o un espacio accesible.

| Contexto/recurso | Proceso hipotético | Componente candidato | Resultado próximo | Qué podría refutar utilidad |
|---|---|---|---|---|
| Tarea que permite parar, canal percibido | Oportunidad más perceptible | Aviso habilitado y entrada directa | Propuesta recibida/comprendida | Aviso no visto, inoportuno o más molesto que útil |
| Acción adecuada ya disponible | Menor preparación | Una propuesta inicial modificable | Inicio acordado tras interrupción de tarea | Elegir/leer toma más esfuerzo que actuar sin app |
| Autonomía real | Control del momento/coste percibido | Cambiar, posponer/rechazar/detener | Uso voluntario y carga aceptable | Presión, posposición infinita o culpa experimentada |
| Acción corporal realizada | Posible interrupción sedentaria/recuperación según actividad | Guía que permite soltar pantalla | Resultado corporal medido aparte | Solo interacción de pantalla o actividad inadecuada |

El cambio sostenido requiere repetición útil en oportunidades reales y seguimiento; no se deduce de esta cadena. COM-B puede ordenar capacidad/oportunidad/motivación; no se lo utiliza como diagnóstico medido ni se acumulan teorías para simular explicación causal. Es más importante especificar la conducta y sus supuestos que citar muchos modelos.

## 5. Decisiones trazables

| ID | Decisión candidata / estado | Base e inferencia | Qué la cambia o comprueba |
|---|---|---|---|
| INT23-D01 | Conservar foco en inicio viable, no educación obligatoria | Postulación + R23-04; saber no garantiza actuar | Observación de episodios y primer uso; no pedir causa única |
| INT23-D02 | Situar el primer caso en tarea individual interrumpible | R23-03/05; restricciones contextuales legítimas | Revisar contexto de usuarios; reuniones/clases no cubiertas por defecto |
| INT23-D03 | Propuesta inicial modificable, sin cuestionario previo extenso | R23-06 limita una promesa universal de elección; inferencia de bajo esfuerzo | Comprensión, preparación, carga y acción real frente a alternativa |
| INT23-D04 | C1 caminar si es adecuado; C2 acción habitual elegida, sin dosis prescrita | R23-02 + distinciones de auditoría; contenido diseñado, no probado | Revisión equipo, adecuación y definición observable; contenido clínico fuera |
| INT23-D05 | Programación puntual; sin recurrencia automática primera versión | Cierra contratos pendientes y reduce complejidad; decisión pragmática | Canal real y utilidad; futura recurrencia requiere política/evaluación |
| INT23-D06 | Señal real por destino antes de ampliar interfaz | T23-01…10; integración no uniforme | Prueba fuera de primer plano en dispositivos disponibles |
| INT23-D07 | Recorridos autónomos en ambos dispositivos; sin cuenta/sync inicial | Alcance confirmado + ausencia de necesidad demostrada de transferencia | Problema adicional observado que justifique coordinación |
| INT23-D08 | Jerarquía breve, paleta cálida candidata y controles claros | VIS-01 + interfaz previa; diseño inferido, no eficacia | Contraste/estados/foco/lector/texto real y comprensión |
| INT23-D09 | Rechazo/stop accesibles, sin presión ni penalización | Valores del caso + TFA; control no equivale a efecto probado | Evaluación de presión/carga experimentadas; no quitar control por tasa de clics |
| INT23-D10 | Sin rachas, mascota funcional, cámara, IA ni bloqueo en núcleo | No hay beneficio incremental demostrado frente al coste del evento | Necesidad concreta y comparación posterior por componente |
| INT23-D11 | Medir software, conducta y momento por separado | AUD23-06 + método; evita métricas equivocadas | Protocolo con fuentes/ventanas/denominadores explícitos |
| INT23-D12 | Escala institucional voluntaria sin panel individual a jefaturas | R23-07 + análisis ético; apoyo no es supervisión | Acuerdos, gobernanza y evaluación independiente de cargas |
| INT23-D13 | Datos mínimos locales y casos sintéticos en demo | Necesidad funcional acotada + reglas evento; no certifica cumplimiento | Análisis de nuevos datos/finalidades al escalar y revisión normativa |
| INT23-D14 | Pitch condicionado al artefacto realmente observado | Regla de atribución científica y criterio del jurado | Actualizar después de AC y retirar promesas de canal fallido |

## 6. Comparación de alternativas y referentes

| Alternativa | Valor candidato | Lo que deja abierto |
|---|---|---|
| Recordatorio del sistema | Muy poco desarrollo y señal familiar | No aporta por sí solo propuesta/adaptación; comparador útil del paquete |
| Temporizador/papel/señal física | Poco dato y posible menor pantalla | Puede ignorarse; no resuelve condiciones organizativas |
| Ajuste de entorno/acuerdo de equipo | Actúa sobre oportunidad y legitimidad | Requiere personas/recursos; no lo sustituye una app |
| Propuesta nikucode | Une invitación, acción y control con salida breve | Valor adicional e inicio aún sin demostrar |
| Opal | Referente de compromiso/control de acceso a dispositivos | Su mecanismo y resultado principal son diferentes; no se adopta bloqueo como respuesta automática |
| Stretchly/Wakeout/Finch | Referentes de presencia breve, acción directa o identidad afectiva | Las pruebas locales y documentación previa no demuestran movimiento, baja carga ni causalidad comercial |

No se midieron ingresos/retención de referentes ni se inspeccionó una nueva versión visual completa esta noche. Los ensayos locales de Stretchly/Wakeout siguen con su alcance específico; no se repitieron. El valor diferencial del MVP es una hipótesis comparativa, no novedad absoluta demostrada.

## 7. Evaluación que responde al problema

**Durante el evento:** funcionamiento y experiencia del artefacto. Usar AC01–AC12 de la guía. Para observación informal voluntaria, acordar primero qué se va a probar y no recolectar datos personales. Preguntas neutrales candidatas: «¿Qué crees que ocurrirá?», «Muéstrame cómo lo dejarías para después», «¿Qué te exigiría parar aquí?», «¿Qué parte te dificultó salir?». No introducir la respuesta deseada ni llamar a esto escala validada o ensayo de eficacia.

**Después:** comparar paquete con una señal simple en condiciones compatibles, o usar una evaluación dentro de persona con periodos/orden que controlen novedad y arrastre si resulta viable. No fijar tamaño sin objetivo/precisión; no convertir una prueba pequeña en estimación de población. Optimizar componentes cuando importe aislarlos, sin imponer una secuencia experimental rígida a toda pregunta.

| Resultado | Medida candidata y denominador | Límite |
|---|---|---|
| Funcionamiento | Casos AC observados por destino/configuración | No acredita eficacia humana |
| Comprensión/carga | Problemas observados + preguntas neutrales tras uso | Separa opinión anticipada de experiencia; no escala validada |
| Inicio corporal | Acción definida observada/declarada dentro de ventana acordada / oportunidades del protocolo | Botón y entrega no son el numerador corporal; no excluir desconocidos silenciosamente |
| Oportunidad/alcance | Oportunidades previstas, elegibles, entrega conocida/desconocida, percepción y respuesta por separado | El sistema no conoce siempre percepción o viabilidad social |
| Distribución temporal | Inicio/fin de periodos según medida apropiada, incluyendo pausas naturales | Actividad de teclado no mide postura; registro puede cambiar conducta |
| Antes de señales tardías | Posterior protocolo que relacione secuencia temporal y experiencia con mínima carga | No se exige síntomas en la demo ni se deduce de «inició pronto» |
| Sedentarismo/recuperación | Medidas diferentes, acordes a actividad y pregunta | No inferir ambos de apertura, postura sola ni ánimo aislado |
| Mantenimiento/hábito | Seguimiento de conducta/carga y automaticidad por separado | Aperturas repetidas y rachas no acreditan hábito |

Condiciones pragmáticas para revisar: función que no cumple su contrato → corregir/retirar la promesa; flujo incomprensible → simplificar antes de adornar; propuesta inadecuada → cambiar contenido/alcance; solo mejora clics → no afirmar cambio corporal. Estas condiciones guían diseño, no son umbrales estadísticos de eficacia.

La programación puntual conserva una carga inicial: recordar prepararla. Reduce complejidad técnica, pero puede limitar utilidad sostenida. Debe evaluarse esa carga; no presentarla como solución ya demostrada al olvido o como eliminación de fuerza de voluntad.

## 8. Expansión y sostenibilidad con condiciones

| Horizonte relativo | Expansión candidata | Necesidad que debe demostrarse | Condición / freno |
|---|---|---|---|
| Tras flujo estable | Más contenido/adaptaciones | Acciones iniciales no son viables o suficientes | Revisión competente, comprensión y resultado propio por actividad |
| Tras uso repetido | Recurrencia configurable | Programación puntual añade carga o se olvida | Evaluar exposición, fatiga y cancelación; no solo más aperturas |
| Tras conocer uso entre destinos | Sync/coordinación | Avisos duplicados o continuidad realmente problemática | Valor supera cuenta/backend/privacidad; alternativa local disponible |
| Tras problema de reanudación observado | Marcador opcional | Perder el hilo dificulta pausar en ese contexto | Comparación propia; no asumir mejora desde Iqbal |
| Tras demanda de apoyo voluntario | Acuerdos con equipos/universidad | Falta oportunidad/legitimidad | No vigilancia ni penalización; recursos y continuidad identificados |
| Tras evidencia de utilidad | Localización/accesibilidad ampliada | Lenguaje/contexto excluyen usuarios | Revisar comprensión y soporte, no solo traducción automática |
| Solo con beneficio incremental claro | Juego, sensores o personalización/IA | Barrera específica no resuelta por versión simple | Medida de beneficio fuera de pantalla, coste/privacidad y salida; detener si añade carga |

Escalabilidad técnica no es adopción social ni evidencia de efecto. Un producto local sin backend reduce ciertas dependencias de operación; no vuelve gratuito el soporte, las actualizaciones, la revisión de contenido o la accesibilidad. Modelo de costes a estimar: distribución/servicios + mantenimiento técnico + contenido/revisión + soporte + comprobaciones de accesibilidad/privacidad. No hay precios, mercado o disposición a pagar medidos. No monetizar la salida, el rechazo o controles básicos como consecuencia automática de un modelo comercial.

El eventual comprador institucional podría valorar métricas incompatibles con el beneficiario. Antes de ese despliegue: finalidad, gobierno de datos, posibilidad real de no participar, recursos y responsable de continuidad. No se propone dashboard individual de cumplimiento.

## 9. Cobertura A–N y cierre

F = fundamentado para decisión provisional; E = explorado con límites; C = requiere comprobación empírica. Un eje puede contener varias clases; ninguno significa eficacia demostrada.

| Eje | Pregunta cubierta / salida | Prioridad | Estado / fundamento | Brecha y próximo paso |
|---|---|---|---|---|
| A | Qué problema/resultado y alternativa | P0 | F/E: relato, AUD23-06, R23-02/04 | Sin prevalencia específica de Chile; observar episodios, no llenar con cifras de inactividad |
| B | Oportunidad social y apoyos | P0 | F/E: R23-03/05/07 | Transferencia al equipo y contextos; revisión situada |
| C | Procesos y alternativas explicativas | P0 | F/E: teoría candidata, R23-04/06 y auditoría | Mediación/causa dominante no medidas; protocolo posterior |
| D | Contenido y acción observable | P0 | E/C: C1/C2, R23-01/02 | Adecuación y efecto; revisar contenido antes de ampliar |
| E | Llegada y control de señal | P0 | F/C: T23, política puntual | Prueba en dispositivos reales |
| F | Recorridos/estados de ambos destinos | P1 | F/C: ficha + guía | Implementar y comprobar estados |
| G | Jerarquía, estilo y comunicación | P1 | F/E: VIS-01 y dirección previa | Usabilidad/carga reales; no optimización universal |
| H | Accesibilidad e inclusión | P0/P1 | F/C: norma + criterios por destino | Lectores/teclado/escala y capacidad física |
| I | Referentes y diferenciación | P1 | E: R23-08/09 y pruebas previas | Éxito comercial/beneficio incremental no medidos |
| J | Opciones, ligereza y datos | P0/P1 | F/C: T23 + R23-10 | Builds, entrega, consumo, privacidad aplicada |
| K | Evaluación y métricas | P0 | F/C: §7 y auditoría | Definir protocolo según pregunta; sin participantes aún |
| L | Control, daños y gobernanza | P0 | F/E: R23-03/06/07, TFA | Carga experimentada y condiciones institucionales |
| M | Escala y sostenibilidad | P2 | E: §8, sin mercado propio | Costes/adopción/continuidad; no prometer demanda |
| N | Propósito y argumento | P1 | F/C: [pitch](PITCH_Y_DEFENSA_2026-10-23.md) | Ajustar al software y programa realmente comprobados |

**Cierre de esta investigación integrada:** se revisaron los catorce ejes con profundidad diferenciada y se entregan decisiones/artefactos. No quedan áreas ocultas tras una declaración genérica de completitud. Persisten brechas señaladas; dispositivos, comportamiento y efecto no se resuelven con más certeza documental. La continuación prioritaria es la prueba técnica y el recorrido, después del hito permitido.

## Anexo A. Registro de búsqueda de esta ejecución

Fecha 23-10-2026. Plataforma: buscador web integrado y apertura directa. Sin filtros automáticos de año/idioma; búsqueda dirigida por decisiones. No se contó un universo de resultados. Se siguieron DOI, editoriales, fuentes de autor y documentación oficial. No se afirma búsqueda de todas las bases listadas por el prompt.

Cadenas efectivamente usadas por el principal:

- `Albulescu 2022 micro breaks meta analysis wellbeing performance PLOS ONE 0272460`.
- `WHO physical activity sedentary behaviour guidelines adults replace sitting light intensity 2020`.
- `Opal app focus breaks official help notifications breaks sessions`.
- `site.bcn.cl ley 21719 entra en vigencia 1 diciembre 2026 datos personales`.
- `site.hack.makana.cl bases 2026 señales 24 octubre pitch entrega`.

R01 social — cadenas reales:

- `qualitative office workers breaking sitting social norms workplace permission managers sitting standing interviews maintenance SWAL`.
- `Chile pausas activas barreras trabajadores estudio cualitativo estudiantes universidad`.
- `Hiemstra 2024 choice no choice strategies sitting breaks 148 qualitative autonomy workplace`.
- `Stand Up Victoria qualitative maintenance sitting intervention interviews workplace 12 months champions`.
- `"pausas activas" "cualitativo" Chile trabajadores`.
- `"sedentarismo" "barreras" "cualitativo" Chile universitarios`.
- `"pausas activas" "barreras" Colombia trabajadores cualitativo`.
- `"sedentary" "university students" "qualitative" breaks barriers lectures`.
- `"10.52611/confluencia.2024.948" muestra entrevistas`.
- `"Motivaciones y barreras" "Valdebenito" estudiantes entrevista 2023`.
- `"Feasibility and acceptability of reducing workplace sitting time" 2016 20 DOI`.
- `"Pachu" "Strachan" "1146" "sedentary" focus groups PDF`.
- `"University students’ knowledge, self-efficacy" pdf`.

R02 técnico: cadenas, accesos y extractos están en §8 del [documento técnico](PREPARACION_TECNICA_DESTINOS_2026-10-23.md), sin duplicar su registro. Las fuentes normativas y Perrig se abrieron directamente para contraste selectivo.

Incidencias: descarga OMS fallida; ficha OMS sí accesible. Hiemstra solo resumen. Pachu desde autor. BCN produjo interfaz incompleta, por eso se limita a metadatos indexados y nota ministerial. Páginas de bases/programa Makana inaccesibles con esta herramienta: horarios de preparación proceden del contexto previamente verificado y deben confirmarse al llegar. No se interpretó ningún fallo de acceso como falta de evidencia o modificación de reglas.
