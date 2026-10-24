# Guía escrita para implementar y demostrar el MVP

Preparada el 23-10-2026 antes de la bienvenida. Especificación candidata del asistente: no código, implementación ni aprobación de todas sus decisiones. Computador/celular sí son alcance confirmado. Si las pruebas reales cambian la viabilidad, actualizar el contrato y el pitch juntos.

Entrada rápida: [estado compartido](ESTADO_COMPARTIDO.md). Fundamento y decisiones: [informe integral](INVESTIGACION_INTEGRAL_Y_DECISIONES_2026-10-23.md). Contratos anteriores compatibles: [ficha V0](FICHA_MVP_PROPUESTA_2026-10-23.md). Canal por sistema: [preparación técnica](PREPARACION_TECNICA_DESTINOS_2026-10-23.md).

## 1. Qué construir primero

Una herramienta que invita a interrumpir brevemente una tarea, propone una acción comprensible y permite actuar, cambiar, posponer o salir. Debe poder usarse de principio a fin en computador y celular. El canal real de avisos se verifica al inicio, porque condiciona la promesa de intervenir durante trabajo/estudio.

**Recorte candidato:** sin cuenta, backend, nube, historial de salud, marcador obligatorio, rachas, puntuación, IA, cámara, bloqueo de otras apps ni sincronización. Es una decisión pragmática de alcance, no un hallazgo de que esas funciones sean inútiles. Las preferencias de presentación se guardan localmente; el temporizador no. Android conserva solo el ID opaco de la invitación cuya publicación solicitó, para validar el intent de apertura. No elegir base de datos antes de conocer esa necesidad.

Orden de trabajo: un recorrido vertical completo → canal viable y contratos → adaptación de ambos destinos → comprobación de accesibilidad → acabado → presentación. Crear el repo público y comenzar desarrollo solo tras terminar la bienvenida. No copiar código de los laboratorios ni asumir que las instrucciones de agentes se heredan en la nueva raíz.

## 2. Contenido de pausa candidato

No hay base revisada para una dosis universal. Los siguientes contenidos son propuestas de demostración, pendientes de revisión por el equipo y de adecuación al uso real. No son ejercicios terapéuticos ni recomendaciones personalizadas. La app no prescribe amplitud, repeticiones, intensidad o estiramientos articulares.

| Campo | C1 · Caminar un momento | C2 · Tu movimiento habitual |
|---|---|---|
| Contexto | Tarea individual, espacio despejado y caminar adecuado para esa persona | Persona que prefiere otra acción o posición |
| Propuesta | «Si puedes caminar y te resulta adecuado ahora, deja la tarea y empieza a caminar a tu propio ritmo. Puedes apartar la mirada.» | «Elige un movimiento que ya conozcas y consideres adecuado ahora. Puedes apartar la mirada.» |
| Inicio corporal para una evaluación | Primer paso tras interrumpir la tarea, observado o declarado según protocolo | Comienzo del movimiento previamente descrito por la persona en la evaluación; no inferirlo de un clic |
| Final corporal | Dejar de caminar; puede no coincidir con el botón de cierre | Final de la acción acordada; no inferirlo de fin de guía |
| Duración | La persona termina cuando quiera; el recorrido básico no exige cronómetro | Igual; sin meta ni castigo |
| Qué permite estudiar | Inicio de caminar y, con medida apropiada, interrupción de estar sentado | Inicio de una acción elegida; no acredita automáticamente ruptura sedentaria |
| Límite | No adecuada para todo contexto/capacidad; no demostrar efecto fisiológico con la demo | Contenido menos específico; no prometer que reduce preparación tanto como C1 |

C2 es un recurso inclusivo provisional, no una rutina validada ni equivalente fisiológico de C1. Si no es posible acordar una acción observable, el ensayo de C2 evalúa interfaz/comprensión, no conducta. No obligar a introducir información clínica ni registrar el movimiento personal en la app.

**Una alternativa adicional de salida:** «Ahora prefiero descansar sin movimiento». Puede cerrar o guiar una pausa de pantalla si se decide incluirla, pero no se suma a pausas físicas ni cuenta como ruptura sedentaria. No hace falta construir un tercer modo para la primera demo.

Contenido visible breve: propuesta, posibilidad de cambiar/detener y salida. La guía presenta tres pasos visuales y breves: C1 repite la condición y conecta apartar la atención de la tarea con empezar a caminar; C2 invita a elegir un movimiento conocido, sin que la app lo nombre ni lo prescriba; ambas terminan recordando que se puede dejar la pantalla y volver o salir cuando se quiera. No usan duración, repeticiones, metas ni temporizador. Las limitaciones de investigación se explican en el material del proyecto; no convertir la pantalla en un consentimiento clínico extenso. El equipo debe revisar las propuestas antes de publicarlas ampliamente; contenido terapéutico requeriría otro alcance y revisión competente.

## 3. Vistas y textos listos para revisar

Nombre de trabajo: «nikucode · pausa». No se eligió marca final. Evitar una nueva ronda de naming antes del primer recorrido funcional.

| Vista | Texto de trabajo | Acciones |
|---|---|---|
| Inicio | «Un momento para moverte, cuando puedas». Estado real: «Avisos apagados», «Avisos activos en este dispositivo» o «La señal funciona mientras esta app esté abierta», según capacidad comprobada | «Ver una pausa»; «Preparar un aviso» si existe canal; «Preferencias»; cancelar pendiente visible |
| Bienvenida local | «Hola, [apodo]» cuando el apodo local no esté vacío; saludo neutral en caso contrario | Se actualiza al guardar o borrar. No añade cuenta ni sincronización |
| Propuesta | Título de C1/C2 y su texto; sin explicaciones científicas largas | Principal «Empezar»; «Cambiar propuesta», «Configurar aviso» y «Ahora no». Configurar solo abre ajustes; no programa por sí mismo |
| Guía | Tres pasos visibles de caminar condicional o movimiento habitual elegido; la persona puede dejar la pantalla y regresar o salir cuando quiera | «Cerrar guía» y «Detener y volver». Ambos disponibles siempre; sin reloj |
| Mi panorama | Conteos de categorías de interacción de la sesión, en barras rotuladas con valor textual | Estado vacío; sin historial ni agrupación temporal. No describe movimiento, salud o progreso |
| Cierre por final | «Guía terminada» | «Volver» o salir; sin felicitación que afirme ejercicio realizado |
| Cierre por detención | «Guía detenida» | «Volver» o salir sin castigo |
| Confirmación de aviso | «Aviso solicitado para…» y estado de programación real | «Cancelar aviso». No confirmar entrega futura garantizada |
| Canal ausente/denegado | «En este dispositivo no se programará un aviso con esta configuración.» Adaptar la causa específica conocida | «Volver»; «Configurar avisos» solo si realmente se implementa |
| Preferencias | Estado del canal y controles mínimos | Activar explícitamente, desactivar/cancelar, modalidad cuando exista |

Un botón de guía no es un control de verificación corporal. La app debe etiquetar los eventos según lo que realmente sabe. Evitar «Has cumplido», «Pausa saludable completada», «Recuperaste tu energía» y contadores de dolor evitado.

## 4. Política de avisos candidata que reduce trabajo

**Primera versión:** una invitación puntual preparada explícitamente por la persona mediante un temporizador de sesión. La recurrencia automática queda fuera de esta primera implementación. Este temporizador requiere que la app siga abierta y no confirma que el sistema operativo entregue la invitación; es una decisión de implementación, no una recomendación sanitaria.

Un horario explícito —por ejemplo, una selección manejable de minutos— organiza una oportunidad. No equivale a medir tiempo sentado. Configurar aviso solo abre los ajustes: programar requiere habilitar avisos explícitamente y elegir un intervalo. El intervalo es una decisión técnica de la persona, no una recomendación sanitaria. Un intervalo breve de demo se identifica como prueba técnica. No se presenta como frecuencia de salud óptima ni como detección del final de una tarea.

Reglas:

1. Habilitar una señal requiere acción explícita y permiso disponible. Programar no demuestra entrega ni recepción.
2. Apertura desde aviso válido → propuesta relacionada directamente. No pasar por Inicio obligatoriamente. Abrir propuesta manualmente o desde aviso consume/invalida la invitación vigente y cancela su programación pendiente propia; salir después no la restaura. «Más tarde» crea una nueva invitación explícita.
3. Una nueva programación/posposición reemplaza la pendiente local anterior; no se acumulan. Mostrar destino temporal y cancelación.
4. Empezar guía o rechazar esa interacción cancela su pendiente. Desactivar cancela todos los pendientes propios en ese dispositivo. Nunca manipular avisos de otras apps.
5. Si ya hay propuesta/guía activa, no abrir otra ni robar foco. Cancelar al abrir propuesta reduce la carrera con el SO; no garantiza impedir un banner que el sistema ya hubiera entregado. Una entrega suprimida no crea cola. Registrar esa limitación y comprobar retirada de entregas propias donde se soporte.
6. Distinguir hora programada de validez de la acción: un aviso entregado puede tocarse después de su hora y seguir siendo válido. Usar identificador/generación vigente, invalidado por cancelar, reemplazar, consumir o desactivar. No hay caducidad temporal adicional en la primera demo. Un enlace invalidado no restaura guía ni fabrica pendiente; ofrece acceso manual. Al reabrir no reprogramar entregas atrasadas ni lanzar ráfagas. Si no se conoce entrega, describirla como desconocida, no como pendiente futuro o recepción confirmada.
7. El temporizador no sobrevive al cierre del proceso: no se guarda ni se reprograma al iniciar de nuevo. En Android se conserva únicamente el ID opaco de la invitación asociada a la publicación solicitada, para validar un toque que llegue mediante intent inicial; se consume una sola vez y se invalida al cancelar, reemplazar o desactivar. No persiste el consentimiento para futuros avisos. La entrega y permanencia de la notificación siguen bajo control del sistema operativo. Si el proceso termina antes de que el temporizador la solicite, la señal puede perderse.
8. Si dos dispositivos no se coordinan, cada uno tiene sus avisos. No prometer deduplicación global; evitar activar ambos por defecto.

**Contrato inicial de cierre de guía:** cerrar la app descarta la guía; no registrar éxito ni retomarla como terminada. Si una versión posterior ofrece retomar, debe distinguirse. Un reinicio no recupera una cola de señales antiguas.

## 5. Datos y estructura lógica, sin implementación anticipada

| Responsabilidad | Información mínima | Motivo |
|---|---|---|
| Presentación | Vista actual, propuesta mostrada, accesibilidad y estado del canal | Mostrar controles/estado comprensibles |
| Interacción | Sin guía/guía activa; cierre por final/detención | Evitar guías duplicadas y falsos cierres |
| Canal | Capacidad real, permiso y resultado de solicitar/cancelar señal | No inventar programación ni entrega |
| Temporizador | ID vigente y tiempo de disparo en memoria | Preparar una única señal durante la sesión; no recuperar ni reprogramar tras cerrar |
| Invitación Android | Un ID opaco local de la invitación cuya publicación se solicitó; se consume al validar el intent y se borra al cancelar/reemplazar/desactivar | Validar el toque inicial sin restaurar el temporizador, una cola ni el consentimiento para avisos futuros |
| Preferencias | Apodo, avatar y opciones locales de acceso; habilitación de avisos solo durante la sesión | Personalizar presentación y conservar la elección explícita de acceso; no persistir salud ni historial |
| Contenido | Identificador y texto de C1/C2, adaptación y límites | Cambiar propuesta sin un catálogo extenso |

Separar reglas de interacción del adaptador de notificaciones permite compartir comportamiento conceptual aunque los destinos difieran. No significa que toda implementación pueda compartirse. El ID Android persistido es un dato técnico de un solo pendiente, no un historial: no incluye título de tarea, identidad, salud ni conducta. Los conteos de actividad permanecen solo en memoria durante la sesión. No guardar historiales clínicos, títulos de tareas, capturas o datos de otras apps. Si se instrumentan eventos, son datos del software, no movimiento; durante la demo usar casos sintéticos y registro técnico mínimo. Almacenar localmente no elimina por sí solo obligaciones de privacidad.

## 6. Disposición y acabado con criterios concretos

Computador: una ventana discreta, contenido principal legible, sin overlay de pantalla completa ni secuestro de teclado. Celular: flujo de una columna, controles accesibles sin desplazamiento innecesario y crecimiento con texto ampliado. Misma semántica y salida; no copiar tamaños sin respetar unidades de plataforma.

Dirección candidata de diseño: fondo `#FAF8F5`, texto `#202124`, botón principal `#62567A` con texto blanco y superficie lavanda `#EAE2F4`; tipografía del sistema, dos pesos y espacio entre grupos. Estos pares ya tienen contraste calculado en la [investigación de interfaz](INVESTIGACION_ESTETICA_ESTRUCTURA_ACCESIBILIDAD_2026-10-22.md). Reutilizar la dirección propuesta reduce decisiones; no certifica estados, foco ni app accesible.

Una ilustración pequeña opcional después de que funcione el núcleo. Sin feed, vídeo obligatorio, animación continua, sonido imprescindible ni temporizador anunciado cada segundo. Si se añade cuenta regresiva, debe poder ignorarse y no bloquear la salida. Preferir etiquetas explícitas a iconos solos; instrucciones útiles aunque no se vea la imagen.

Objetivos de verificación: contraste final y estados según referencia aplicable; foco visible y ordenado; todas las acciones con teclado en computador; nombres/estados anunciados en lector de pantalla; texto ampliado sin cortes; controles táctiles generosos y sin solaparse; reducción de movimiento. La referencia web es [WCAG 2.2](https://www.w3.org/TR/WCAG22/); las pruebas nativas se adaptan al destino. No declarar conformidad completa a partir de esta lista.

## 7. Aceptación: casos que realmente protegen el producto

Registro mínimo: destino/versión, caso, resultado observado, evidencia si aporta y limitación. El estado inicial de todos los casos es **pendiente**, no «aprobado por especificación».

| ID | Caso | Criterio observable |
|---|---|---|
| AC01 | Recorrido manual, en ambos destinos | Abrir → propuesta → cambiar → guía → cierre/salida, sin depender del otro dispositivo |
| AC02 | Aviso habilitado con app fuera del primer plano | El canal comprobado entrega o se registra el fallo; abrir conduce a propuesta; describir si proceso/app debe seguir vivo |
| AC03 | Permiso denegado/avisos apagados | Posponer no informa programación exitosa ni reactiva el canal; salida disponible |
| AC04 | Programar dos veces | Un pendiente local reemplaza al otro, sin duplicación posterior |
| AC05 | Posponer y luego rechazar/iniciar | Se cancela su pendiente y no reaparece como nueva obligación |
| AC06 | Cancelar desde Inicio/desactivar | El estado visible y el canal propio coinciden; reabrir no restaura pendiente cancelado |
| AC07 | Pendiente → abrir propuesta manual → pasar a otra app antes de su hora | Apertura consume/cancela; no se duplica interfaz ni se crea cola. Comprobar el canal; registrar si un banner ya entregado no puede impedirse/retirarse |
| AC08 | Cerrar/reabrir; tocar aviso después de su hora y tocar aviso cancelado/reemplazado | Hora pasada por sí sola no invalida una invitación entregada; solo un ID vigente puede abrirla una vez. Android valida el intent inicial y `onNewIntent`; un ID consumido/cancelado/reemplazado no reabre la propuesta. No recuperar ni reprogramar el temporizador. El puente automatizado no sustituye la prueba en teléfono real |
| AC09 | Guía detenida/terminada | Se distinguen y ninguna registra ejercicio corporal comprobado |
| AC10 | Teclado/lector/texto ampliado | Se puede identificar, accionar y abandonar el flujo sin cortes ni controles inaccesibles detectados |
| AC11 | Sin conexión | Contenido/flujo local disponible en los destinos donde se prometió; notificaciones se prueban por separado |
| AC12 | Dos dispositivos y demo acelerada | No afirmar sincronización; programación de prueba identificada y cancelada al terminar |

Se añadieron pruebas de lógica/widget y del puente Flutter para estados, cancelación/reemplazo, cola del intent inicial y recepción de la llamada usada por `onNewIntent`; en este entorno no pudieron ejecutarse por el bloqueo del socket del runner. La persistencia/validación nativa y las comprobaciones del sistema operativo/lectores de pantalla exigen observación o prueba en Android; los mocks del puente no las sustituyen. No escribir pruebas de cada detalle decorativo.

## 8. Reparto y secuencia de trabajo al comenzar

T0 = comienzo efectivo del bloque de desarrollo. La fase de construcción ya está confirmada desde 09:45 por el programa aportado. Las duraciones siguientes son presupuestos propuestos; ajustar para checkpoints 12:00 (problema/por qué) y 17:15 (algo corriendo).

| Bloque desde T0 | Producto concreto | Reparto candidato |
|---|---|---|
| 0–15 min | Confirmar destinos, alcance del canal y repo nuevo público; leer instrucciones de la nueva raíz | Ambos; una persona integra |
| 15–60 min | Prueba vertical de canal y apertura en dispositivos reales; elección técnica condicionada | Persona A implementa; B prepara contenido/demostración y prueba como usuario |
| 60–150 min | Recorrido completo y adaptable en ambos destinos, sin funciones extra | A núcleo/canal; B interfaz/contenido o rama de presentación con archivos distintos |
| 150–240 min | Cancelación, pendientes, permisos, reabrir y casos de fallo | Integrador + revisión de cambios pequeños |
| 240–330 min | AC01–AC12 pertinentes; corregir problemas detectados | B registra observaciones; A corrige; roles intercambiables |
| 330 min en adelante | Acabado, evidencia real, README y ensayo del pitch | Solo después de que el flujo esté demostrable |

La asignación A/B es una propuesta funcional, sin inferir capacidades de los integrantes. Ambos deben poder explicar problema, mecanismo, límites y demo. No dejar a uno investigando indefinidamente mientras el otro integra todo.

Si el canal falla en el primer bloque, consultar [ruta técnica](PREPARACION_TECNICA_DESTINOS_2026-10-23.md) y elegir alternativa comprobable. No dedicar todo el día a una API. Mantener los dos recorridos y declarar dónde solo hay inicio manual o avisos con proceso vivo. Una guía manual es una demo funcional parcial; no debe presentarse como solución ya demostrada de iniciación durante otras tareas.

**Sábado, según horario previamente documentado:** 09:00 revisar fallos; 10:00 recorrer demo y cerrar contenido del pitch; 11:00 revisar entrega/README y respaldar material; 12:15 congelación propuesta de funciones; antes de 13:00 confirmar que el commit final está en la rama exigida. El programa pegado por Alex durante el evento confirma entrega 13:00 y pitch desde 14:00 con cinco minutos de demo/presentación y tres de preguntas. Nunca confiar en un push iniciado exactamente al cierre.

## 9. Encargos de agentes para copiar tras la bienvenida

**Integración:** «Lee el estado compartido y revisa el estado real del repositorio. La fase de construcción está autorizada. Confirma los destinos disponibles y coordina archivos de trabajo. Prioriza la tarea pendiente con mayor valor; verifica los resultados y no reconstruyas la investigación ni incorpores expansiones sin necesidad demostrada.»

**Implementador de núcleo:** «Responsable de reglas de interacción/canal en rutas que indique el principal. No estás solo: no reviertas cambios ajenos. Implementa el contrato acordado de un pendiente, reemplazo/cancelación, permiso real y señales durante guía. Sin backend/rachas/IA. Entrega cambios, pruebas observadas y límites por destino. No delegues.»

**Interfaz/contenido:** «Responsable de vistas/estilo/textos en rutas asignadas, coordinando el contrato con el principal. No estás solo: adapta cambios a otros archivos sin revertirlos. Implementa recorrido autónomo de ambos tamaños, cambio/salida visibles y accesibilidad. No afirmar movimiento por terminar guía. Entrega captura o comprobación real y limitaciones. No delegues.»

**Revisor/pruebas:** «Solo cambios concretos del bloque, no todo el repo. Comprueba AC pertinentes y regresiones de cancelación/accesibilidad. No repitas checks ya pasados sin cambios. Comunica hallazgos con evidencia; no reescribas arquitectura ni asumas pruebas del sistema desde un mock.»

Usar como máximo dos encargos independientes simultáneos; el principal conserva registro y presentación. Las rutas se asignan sobre el repo realmente creado; no son archivos de app preparados de antemano.

## 10. SDD ligero para cambios del prototipo

Se adopta un ciclo breve de especificación por cambio para que la intención, el código y la evidencia permanezcan conectados. No se instalará OpenSpec o Spec Kit durante la hackatón: sus flujos oficiales son referencias, no estándares obligatorios, y el proyecto ya tiene esta guía y AC01–AC12. La comparación y adaptación están documentadas en [la investigación de referentes visuales y SDD](INVESTIGACION_REFERENTES_VISUALES_Y_SDD_2026-10-23.md).

Para cada cambio que altere el flujo o la promesa:

1. **Explorar:** anotar problema del usuario, hipótesis y qué alternativa se deja fuera.
2. **Especificar:** escribir un resultado observable y enlazarlo a un AC existente; sumar un AC solo si de verdad hay un comportamiento nuevo.
3. **Revisar:** acordar alcance y responsable antes de editar; repartir archivos para no duplicar trabajo.
4. **Implementar:** completar un corte pequeño de extremo a extremo.
5. **Verificar:** registrar destino, sistema/versión, pasos, resultado y límites; usar «verificado» solo para ese alcance.
6. **Cerrar:** actualizar estado compartido y evidencia. La especificación actual se mantiene; las decisiones reemplazadas se anotan como tales, sin crear una segunda fuente de verdad.

Ficha mínima: `Problema | Hipótesis | Requisito observable | AC | Fuera de alcance | Responsable | Evidencia/entorno | Estado | Límite`.

Ejemplo: **propuesto**, «Con movimiento reducido activo, el cambio de propuesta a guía no ejecuta la transición decorativa y conserva el foco en la acción principal» → AC10 → comprobar en destino real y registrar sistema/versión. Un test puede verificar un estado técnico bajo una preferencia simulada, pero no acredita accesibilidad real con lector. «El tema oscuro calma» no es criterio de aceptación: es una hipótesis de percepción que requiere evaluación con personas.
