# Ficha de MVP para revisar antes de implementar

Fecha: 23-10-2026. Estado: propuesta del asistente pendiente de revisión y decisión del equipo. No hay código competitivo ni validación conductual propia. Computador y celular sí son alcance confirmado por Alex; el stack no está elegido.

**Integración para próxima sesión:** ver [investigación integral](INVESTIGACION_INTEGRAL_Y_DECISIONES_2026-10-23.md) y [guía de implementación](GUIA_IMPLEMENTACION_Y_ACEPTACION_2026-10-23.md). Se concretan como candidatas programación puntual sin recurrencia inicial, contenido C1/C2 y guía sin cronómetro obligatorio. No son eficacia ni decisiones ya aceptadas por el equipo. Auditoría de integración: abrir propuesta consume/cancela su invitación; validez por identificador/generación, no por el mero paso de la hora; no garantizar supresión de un banner ya entregado por el SO. Estas precisiones reemplazan ambigüedades del V0 que sigue abajo.

## Actualización tras auditoría científica

La [auditoría del 23-10](AUDITORIA_CIENTIFICA_MVP_2026-10-23.md) corrige el alcance de fuentes y requisitos heredados. La transición a la pausa es el **objetivo**; los **procesos hipotéticos** son volver perceptible una oportunidad, reducir preparación y reducir el coste percibido de interrumpir conservando control. Esos procesos no están probados en este paquete. No prometer mejor retorno por posponer, recuperación inmediata, menos sedentarismo por cualquier movimiento ni ausencia de culpa por disponer de botones amables.

**Antes de cerrar el MVP:** seleccionar contenido físico y sus criterios de inicio/final, concretar canal y dispositivos, y decidir qué resultado temporal se podría evaluar posteriormente. No hace falta reducir el relato a una única causa. Rachas y DB no son requisitos del núcleo; el almacenamiento se justifica solo por contratos de avisos/preferencias.

## Persona, contexto y conducta

Persona que estudia o trabaja individualmente con computador y permanece largos periodos con poco movimiento. El relato de postulación indica que a veces advierte la necesidad de moverse y aun así continúa; los intentos previos pueden sentirse como otra obligación. No sabemos qué barrera predomina ni con qué frecuencia.

Primer contexto de prueba propuesto: tarea individual que admite una interrupción breve, sin reunión ni obligación inmediata que la impida. Es una delimitación para evaluar la propuesta, no una conclusión de entrevistas.

Escenario móvil sintético para revisar el segundo destino: consultar material de estudio en el teléfono durante un periodo prolongado en un mismo lugar. El recorrido debe poder abrirse, adaptarse y cerrarse allí sin computador. Esto no acredita observar ese patrón en usuarios ni permite prometer avisos sobre otras apps sin comprobar el canal.

Conducta candidata: suspender brevemente la interacción con la tarea e iniciar un movimiento viable elegido por la persona, con posibilidad de volver. Tiempo de pantalla, estar sentado e inactividad física no son equivalentes; no prometer prevención del dolor ni reducción del sedentarismo por cualquier movimiento.

## Problema y mecanismo elegidos provisionalmente

**Ajuste tras recibir nuevamente la postulación específica:** el núcleo es facilitar la transición de continuar la tarea a iniciar una pausa, incluso cuando la necesidad ya se advierte, sin convertirla en una obligación adicional. No se requiere que Alex elija una sola barrera de un menú; el relato ya describe concentración, agotamiento e intentos previos que añaden carga. Se desconoce su peso relativo y la respuesta al producto.

**Pregunta principal:** ¿la intervención permite salir brevemente de la tarea e iniciar una pausa viable antes de depender de dolor, sueño o una necesidad externa, con poca preparación y control de la persona?

**Hipótesis de producto:** una oportunidad perceptible, un modo sencillo de actuar o elegir un momento concreto y una acción viable podrían facilitar esa transición. La intervención falla si se ignora, añade trabajo, se pospone indefinidamente o prolonga la interacción con otra pantalla. Es una hipótesis de paquete, no eficacia demostrada ni efecto aislado de cada pieza. Ofrecer una acción concreta es una posible forma de reducir preparación; no implica que la barrera observada sea «no saber qué hacer».

**Comparación de componente conservada como secundaria:** misma señal, opciones, duración orientativa, contexto y estética; A invita genéricamente y B propone una acción concreta. Solo si resulta pertinente estudiar la especificidad de la acción. No adoptarla automáticamente como prueba principal del caso; no aísla el paquete completo ni responde por sí sola si la persona cambiaría.

No estamos probando todavía cambio de hábito. Si la barrera relevante resulta ser otra —falta de oportunidad o dificultad de retomar—, revisar la comparación en lugar de forzar esta hipótesis.

### Trazabilidad entre relato y decisiones del MVP

| Lo descrito en la postulación | Implicación de diseño propuesta | Límite |
|---|---|---|
| Notar que hace falta moverse y aun así seguir | Facilitar el paso a la acción y el control del momento, además de señalizar | No se ha medido coste de transición ni probado una política de momento |
| Concentración intensa y agotamiento | Pocas decisiones, sin navegación extensa ni registro obligatorio | No asumir temor a perder el hilo ni detectar cansancio automáticamente |
| Rutinas, anotaciones y recordatorios se vuelven obligaciones | Evaluar carga de todo el recorrido; poder modificar/rechazar sin sanción | Una salida visible o un tono amable no demuestran ausencia de culpa |
| Descanso con otra pantalla | Guía que no exige mirar/sostener el dispositivo ni explorar un feed | No patologizar ocio ni prometer que dejar pantalla equivale a moverse |
| Pausas antes de dolor/agotamiento | Proponer oportunidades que no dependan de esperar síntomas; evaluar el momento en seguimiento | No detectar ni prevenir síntomas por calendario; la demo no prueba este resultado |

No exigir marcador de retorno, bloqueo de apps, rachas ni una rutina compleja para resolver estas observaciones. Su incorporación necesitaría una contribución concreta y evaluable.

## Recorrido mínimo en ambos destinos

1. **Inicio:** entender qué ofrece la herramienta y abrir una propuesta voluntariamente. Estado de avisos visible si se implementan. Al llegar desde una señal propia, entrar directamente a la propuesta relacionada, sin exigir volver a Inicio y pulsar «Ver una pausa»; verificar esa ruta en cada destino.
2. **Propuesta:** acción y duración orientativa comprensibles; empezar, cambiar, posponer y rechazar accesibles. El contenido físico exacto no está seleccionado ni evaluado.
3. **Guía:** instrucciones breves, alternativa textual a imagen y control para detener. No exigir mirar continuamente o sostener el teléfono.
4. **Cierre:** volver con claridad; final de guía identificado como tal, sin registrar movimiento automáticamente. Autorreporte opcional solo si aporta a la pregunta y queda distinguido.
5. **Preferencias:** controles mínimos para modalidad, accesibilidad y avisos cuando existan; sin configuración extensa obligatoria.

Cada destino permite completar el recorrido por sí mismo. No se exige transferir una pausa entre dispositivos. Ambos comparten lenguaje/estados conceptuales; no se asume una base de código, cuenta, sincronización ni backend.

## Señal y viabilidad técnica

La entrada manual demuestra acceso y guía, pero **no resuelve por sí sola olvido o iniciación espontánea**. Si el MVP afirma intervenir durante el estudio/trabajo, necesita demostrar un canal de señal que llegue en ese contexto.

Un aviso técnicamente entregable no acredita que la persona pueda o quiera interrumpir: distinguir disponibilidad del sistema, percepción de la señal, oportunidad real y receptividad. No deducir postura de falta de teclado/ratón, ni disponibilidad cognitiva de un horario. El control explícito no sustituye medir esas condiciones.

Candidato: aviso explícitamente habilitado en el dispositivo donde se realiza la tarea. No afirmar que la app detecta postura, concentración, final de un paso o presencia del otro dispositivo. La entrega fuera de primer plano debe comprobarse en los destinos reales antes de prometerla. Posponer programa solo lo que efectivamente se implemente.

Sin coordinación entre dispositivos no prometer que los avisos se deduplican automáticamente: dejar habilitación y alcance por dispositivo claros y demostrar la configuración elegida. Si la señal no es viable dentro del evento, declarar el alcance manual y revisar la pretensión conductual del pitch; no esconder el faltante.

## Funciones que quedan fuera de la primera comparación

Marcador de reanudación, juego, mascota interactiva, puntuaciones, rachas, captura/análisis automatizado de pantalla, cámara e IA. Pueden revisarse si hay una barrera y una prueba que justifiquen su incorporación. No son funciones prohibidas ni demostradas inútiles. Los lectores de pantalla como tecnología asistiva sí forman parte de los criterios de accesibilidad.

La estética cálida y sobria es una candidata de presentación. No variarla entre A/B mientras se prueba concretar la acción.

## Especificación de interacción candidata V0

Preparación de diseño, sin código. El siguiente recorrido concreta controles y estados comunes, sin decidir todavía qué barrera domina ni cerrar la comparación científica. El calendario configurado no acredita tiempo sentado, y un control de inicio no verifica movimiento.

### Pantallas y textos de trabajo

| Vista | Información necesaria | Controles candidatos | Qué debe evitar |
|---|---|---|---|
| Inicio | Estado de avisos en este dispositivo y acceso a una pausa; si existe posposición, «Aviso pendiente para…» | «Ver una pausa», «Preferencias» y «Cancelar aviso pendiente» cuando corresponda | Dashboard obligatorio, metas incumplidas o puntuación de salud |
| Propuesta | Acción concreta cuando corresponda a la variante; duración orientativa y alternativa disponible | «Empezar», «Cambiar propuesta», «Más tarde», «Ahora no» | Atribuir intención, cansancio o postura a la persona; ocultar rechazo en texto ilegible |
| Guía | Una instrucción o secuencia breve, legible sin animación; tiempo solo si aporta | «Detener», «Terminar guía» | Exigir terminar el temporizador o mirar continuamente el teléfono |
| Cierre | «Guía terminada» o «Guía detenida», según evento real | «Volver al inicio»; permitir salir | «¡Pausa completada!» solo porque acabó el tiempo; celebración larga obligatoria |
| Preferencias | Avisos del dispositivo, modo visual/sonido cuando existan, modalidad de propuestas | Cambiar y desactivar con estado claro | Registro de salud innecesario; consentimiento global que prometa capacidades ausentes |

Son textos propuestos para revisar en español, no copy validado. No añadir autorreporte obligatorio: si se decide recogerlo, separarlo del final de guía y explicar qué se registra. El contenido físico sigue por seleccionar.

### Estados y transiciones comprobables

| Estado previo y acción | Estado siguiente | Consecuencia observable |
|---|---|---|
| Inicio o aviso válido → abrir propuesta | Propuesta visible | Consumir/invalidar la invitación vigente y cancelar programación pendiente propia; presentar opción sin registrar movimiento. Salir no restaura el aviso |
| Propuesta → cambiar | Nueva propuesta visible | La opción cambia sin empezar guía ni acumular «completaciones» |
| Propuesta → empezar | Guía activa | Se cancela una posposición pendiente propia de este dispositivo y se inicia la guía; no se asegura inicio corporal |
| Propuesta → más tarde, canal propio habilitado y permiso disponible | Posposición explícita | Se muestra qué se programó y cómo cancelarlo; no confirmar éxito sin respaldo del canal |
| Propuesta → más tarde, avisos apagados o permiso denegado | Sin nuevo pendiente | Explicar que no se enviará aviso; habilitarlo exige una acción explícita, nunca reactivación implícita |
| Propuesta → ahora no | Inicio/salida sin posposición de esa interacción | Cancelar también su pendiente local anterior; sin castigo ni justificación obligatoria. No reprogramar por rechazar |
| Guía → detener | Cierre por detención | Se detiene cualquier temporizador; no queda una guía activa oculta |
| Guía → terminar o tiempo agotado | Cierre por final de guía | El motivo queda distinguido; no es confirmación física |
| Cualquier vista → cerrar app | Aplicación cerrada | La guía no «se completa» por cerrar. La política de avisos sigue solo si estaba habilitada y realmente funciona |
| Preferencias → desactivar avisos | Avisos desactivados | Cancelar avisos pendientes propios; ninguna guía se inicia por esta acción |
| Inicio → cancelar aviso pendiente | Inicio sin posposición pendiente | Retirar ese aviso y su indicador, sin desactivar necesariamente el resto de la configuración |
| Propuesta o guía activa → llega otra señal | Misma interacción activa | No duplicar interfaz ni crear cola; cancelación previa al abrir reduce carreras, sin garantizar impedir un banner ya entregado por el SO |

**Posponer:** antes de implementarlo, definir intervalo y alcance. Se propone una posposición temporal simple con confirmación visible y cancelación disponible; el valor se elige por manejabilidad de la demo, no como frecuencia saludable óptima. No ofrecer «al terminar este paso» si no existe una forma explícita de marcarlo o detectarlo.

**Pendientes e interacciones simultáneas:** cada dispositivo mantiene como máximo una interacción activa y un pendiente propio. Nueva posposición reemplaza; abrir propuesta consume/invalida la invitación y cancela su programación, sin restaurarla al salir. Separar hora programada, entrega conocida/desconocida y acción válida por identificador/generación: pasar la hora no invalida un aviso entregado. Cancelar/reemplazar/consumir/desactivar sí lo invalida; sin caducidad temporal adicional inicial. Al reabrir no presentar como pendiente futuro una hora pasada ni reprogramarla en ráfaga; declarar entrega desconocida si corresponde. Recurrencia queda fuera de la primera versión candidata, sin promesa de coordinación entre dispositivos.

**Desactivar, denegar y rechazar:** no programar «Más tarde» si el canal está apagado, denegado o no implementado. El control debe comunicar esa limitación de forma accesible y dejar salir; no usar mensajes persuasivos para forzar permisos. La cancelación alcanza pendientes propios de esa interacción, y notificaciones propias ya entregadas cuando la plataforma lo permita; comprobar el resultado real. No borrar avisos de otras apps. Si se añade recurrencia, definir aparte qué implica el rechazo para futuras oportunidades, sin presentar aún una política como resuelta.

**Cerrar y reabrir:** decidir antes de implementar si la guía activa se descarta o se ofrece retomar; nunca contabilizarla automáticamente. Para la primera versión se propone volver al inicio y no restaurar una guía como completada. Preferencias pueden persistir localmente sin historial personal; esta necesidad se revisa al elegir el destino real.

### Disposición por destino

- **Computador:** ventana de tamaño contenido, navegable por teclado y sin imponer pantalla completa. Una señal no debe tomar el foco ni bloquear escritura si se promete ser no bloqueante; comprobarlo en el sistema elegido. No afirmar que esa propiedad está resuelta por una opción de configuración.
- **Celular:** una columna legible, controles amplios y salida accesible; permitir apoyar o dejar el dispositivo durante la guía. Probar reflujo con texto ampliado. No asumir que avisará sobre otras apps o estando cerrada sin verificar permisos y ciclo de vida.
- **Ambos:** recorrido autónomo, etiquetas y estados coherentes. Preferencias por dispositivo; sin transferencia ni deduplicación automática prometidas. El diseño responsive puede ser una alternativa, pero no prueba igualdad de capacidades con una app nativa.

### Dos escenas de demo sintéticas

1. **Aceptación:** abrir propuesta, cambiar una opción inviable, empezar guía y terminarla. El relato describe lo que hace la interfaz; no representa una persona observada que cambió su hábito.
2. **Control del momento:** recibir la señal solo si su canal está comprobado, posponer con alcance visible, cancelar ese pendiente y rechazar otra propuesta. Mostrar que el trabajo puede continuar y que no se crea una «pausa realizada».

Mostrar ambas escenas en los destinos prometidos, o identificar explícitamente qué parte es diseño y cuál funciona. Una secuencia de pantallas dibujadas no es una ejecución. El pitch debe coincidir con esa diferencia.

### Orden de implementación propuesto para después de la bienvenida

1. Estados y recorrido manual completos, con propuestas sintéticas y sin historial de movimiento.
2. Disposición y operación del mismo recorrido en los dos destinos confirmados; comprobaciones de accesibilidad pertinentes.
3. Canal mínimo de aviso y posponer en los sistemas reales. Si es la función central para la barrera elegida, comprobar su viabilidad técnica al principio del desarrollo, no dejar su primer ensayo para el final.
4. Persistencia mínima, cancelación de pendientes y cierre/reapertura según contrato.
5. Demo reproducible, revisión del pitch frente a capacidades observadas y ensayo humano.

Este orden no declara Flutter ni otro framework seleccionado. Si una comprobación crítica del canal falla, revisar temprano la forma de entrega; no ocultarlo tras más pantallas o adornos.

## Criterios de comprobación

- **Funcionalidad:** se puede empezar, cambiar, posponer/rechazar y detener sin bloqueo; los estados no registran finalización corporal a partir de temporizadores. Los avisos y el retorno hacen lo que el pitch dice, en el entorno que se demuestre.
- **Accesibilidad:** controles etiquetados y amplios, contraste, texto ampliado sin cortes, orden de lectura/foco y reducción de movimiento. Evaluación real requiere implementación y herramientas del destino.
- **Comprensión:** con escenario ficticio se entiende qué se propone y cómo salir/adaptar sin explicación del equipo. No convertir ese resultado en eficacia conductual.
- **Conducta futura:** iniciar movimiento definido dentro de una ventana fijada por oportunidades elegibles, distinguiendo autorreporte/observación, pausas naturales, desconocidos y carga. Esa evaluación no se sustituye por clics o una demo guionizada.
- **Momento de la pausa:** inicio dentro de una ventana tras aviso y pausa anterior a señales tardías son indicadores diferentes. El segundo requiere un método adicional; no inferirlo de tiempos de la app ni pedir síntomas como requisito de demo. «Antes del dolor/agotamiento» se conserva como objetivo del caso, no resultado demostrado o predicción del sistema.
- **Aceptabilidad:** distinguir agrado, comprensión, esfuerzo, coste de abandonar/retomar la tarea y presión percibida. Opinión anticipada del concepto y experiencia de uso no son lo mismo. Preguntas breves inspiradas en TFA no equivalen a instrumento validado ni deben convertirse en registro obligatorio durante cada pausa.
- **Decisión:** revisar barreras que impidan comprender, adaptar, rechazar o detener. Si no se observa un aporte claro, simplificar puede ser una decisión de coste; no concluir equivalencia o ausencia de efecto a partir de una prueba pequeña/imprecisa. Si los resultados son mixtos, conservar incertidumbre.

## Qué necesita responder el equipo para implementar

Sistemas operativos/dispositivos reales; acción física y guía a evaluar; canal de señal mínimo; semántica de posponer; persistencia necesaria; alcance exacto de la demo. El principal preguntó por sistemas/dispositivos sin detener la revisión independiente de la propuesta.

**Ficha necesaria por propuesta física:** acción y contexto previstos, alternativas/modificación, qué permite identificar inicio y final, instrucciones sin pantalla continua y qué resultado se puede sostener. Ninguna rutina está seleccionada en esta ficha. La interfaz accesible no valida por sí sola la adecuación física del contenido; mantener esa selección como trabajo pendiente, sin sustituirla por ilustraciones genéricas.

### Discriminar la barrera antes de fijar la comparación

El relato del equipo no demuestra que predomine «no saber qué movimiento hacer». La propuesta concreta merece compararse si preparar/elegir una acción es una fricción relevante; si no, no debe ocupar automáticamente el centro del pitch. La postulación aportada nuevamente permite avanzar con el problema de transición sin pedir seleccionar una única barrera; las distinciones siguientes orientan qué componente estudiar después.

| Situación a distinguir | Qué cambiaría en la propuesta | Qué no permite concluir un escenario ficticio |
|---|---|---|
| La persona ya sabe qué haría, pero sigue trabajando | Explorar momento/transición; una guía adicional podría ser redundante | Que ese motivo predomina realmente o que posponer aumenta movimiento |
| Puede interrumpir, pero preparar/elegir la pausa añade esfuerzo | Mantener la comparación genérica frente a acción concreta | Que gustar del concepto implica iniciar más pausas |
| No tiene oportunidad de interrumpir | Reconocer límite de la app y revisar entorno/alcance | Que insistir o adaptar texto crea oportunidad |

Usar estas distinciones para contrastar el relato ya aportado y discutir el alcance sin exigir historias privadas adicionales. Antes de la comparación A/B, fijar contenido, duración orientativa, alternativas y medida; si las variantes cambian más que la especificidad de la propuesta, describirlas como comparación de paquetes.

Precisar cuándo A y B revelan la acción: si ambas la muestran antes de medir el resultado, ya no estamos probando simplemente presencia/ausencia de una propuesta concreta. Separar clic en «Empezar» de inicio corporal; fijar asignación y ventana antes de probar. No adoptar todavía esta comparación como experimento cerrado.

## Explicación provisional para el pitch

«Nuestro caso describe a dos personas que pueden notar que necesitan moverse y aun así seguir trabajando hasta que el dolor, el sueño o una necesidad externa las hace parar. Los intentos anteriores se han convertido en otra obligación y el descanso puede continuar en otra pantalla. Exploramos una app para facilitar esa transición: una oportunidad perceptible, una acción viable y control para actuar o elegir otro momento, con poca preparación y sin sanción por rechazar. Computador y celular permiten usar el recorrido en el dispositivo disponible. La demo mostrará funcionamiento y control; todavía debemos comprobar si facilita pausas más tempranas y repetidas sin añadir carga».

Usar futuro para funciones aún no implementadas. La pregunta del jurado orienta la explicación; no permite afirmar que ya sabemos que esta persona cambiará.

Referencia de decisiones y límites: [investigación de mecanismo/MVP](INVESTIGACION_MECANISMO_CONDUCTUAL_MVP_Y_PITCH_2026-10-22.md), [interfaz y accesibilidad](INVESTIGACION_ESTETICA_ESTRUCTURA_ACCESIBILIDAD_2026-10-22.md) y [transcripción de Makana](investigacion/ACLARACION_MAKANA_TRANSCRIPCION_2026-10-22.md).
