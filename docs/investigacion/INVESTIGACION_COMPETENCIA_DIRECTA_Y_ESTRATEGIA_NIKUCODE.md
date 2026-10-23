# INVESTIGACIÓN DE COMPETENCIA DIRECTA Y ESTRATEGIA — NIKUCODE

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


**Proyecto:** Hackatón Señales de Makana · equipo nikucode
**Fecha de consulta:** 18 de octubre de 2026
**Decisión que informa:** qué territorio de problema merece explorar y qué hipótesis de diseño conviene probar durante la hackatón, sin construir prematuramente una solución competitiva.

> **Conclusión ejecutiva:** ya existen productos que cubren casi todos los componentes por separado: interrupciones antes de abrir redes sociales (one sec, ScreenZen, Clearspace), bloqueo y compromiso (Opal, Freedom, Brick), pausas físicas breves y jugables (Wakeout), recordatorios de pausas en escritorio (Workrave, Stretchly), foco gamificado (Forest, Focus Friend) y hábitos/autocuidado gamificado (Habitica, Finch, Fabulous). Por tanto, no es defendible afirmar que “nadie ha hecho algo parecido”. La oportunidad, si existe, debe formularse como una combinación de barreras y contexto: facilitar la transición desde una actividad absorbente o un periodo de scroll hacia una pausa física breve, con muy poca carga adicional, sin culpa y sin exigir que la persona entre voluntariamente en otra app.

Esta es una hipótesis estratégica, todavía no una diferenciación validada.

---

## 1. Marco metodológico y reglas de lectura

Esta investigación aplica los dos manuales metodológicos aportados por el equipo:

- **Manual reutilizable de proyectos:** inventariar, verificar, separar la escalera de evidencia, documentar fuentes y límites, definir hipótesis refutables, preferir pretotipos baratos y fijar criterios antes de probar.
- **Manual general de innovación y emprendimiento:** comprender a la persona y sus alternativas actuales, formular una propuesta de valor desde el beneficio, mapear sustitutos, idear antes de evaluar, validar con tareas observables y no confundir una opinión o una demo con evidencia de adopción o impacto.

### Estados utilizados

- **FUNCIÓN PÚBLICA VERIFICADA:** aparece descrita en una página oficial, tienda o documentación del producto; esto no demuestra eficacia.
- **DATO DE TIENDA:** umbral de instalaciones, valoraciones o reseñas visible en una tienda en la fecha aproximada de consulta. Puede variar por región y tiempo.
- **DECLARACIÓN COMERCIAL:** cifra reportada por la propia empresa o materiales promocionales, no auditada independientemente en la fuente consultada.
- **EVIDENCIA ACADÉMICA:** resultado de un estudio publicado; se especifica el diseño, muestra y limitación.
- **INFERENCIA DE DISEÑO:** interpretación razonada para nikucode, aún por comprobar.
- **NO PÚBLICO / NO VERIFICADO:** no se encontró dato público comparable para esta revisión.

La consulta es una **revisión dirigida de escritorio**, no una revisión sistemática registrada ni una auditoría de analíticas internas de los competidores. Las reseñas públicas se utilizan solo como señales cualitativas: no sirven para estimar qué porcentaje de usuarios tiene un problema o abandona la app.

## 2. Qué estamos intentando resolver

La postulación de nikucode describe que los integrantes estudian y desarrollan proyectos durante muchas horas frente al computador; suelen detenerse cuando aparece dolor, sueño o una necesidad externa; después, el descanso puede continuar frente a otra pantalla. Han intentado rutinas, anotaciones y recordatorios que terminan convirtiéndose en obligaciones incumplidas. El resultado deseado es facilitar pausas breves antes del dolor o agotamiento.

La conversación añadió matices útiles, pero aún no medidos:

1. A veces no se dan cuenta del paso del tiempo.
2. A veces sí lo notan, pero deben terminar algo, no quieren perder el hilo o no sienten margen para interrumpirse.
3. A veces están cansados y recurren a redes sociales, vídeos cortos o juegos para desconectarse; el descanso digital puede prolongarse más de lo previsto.
4. Acumular apps, listas, rutinas y tareas en una pantalla de inicio puede añadir fricción y carga cognitiva.

No está demostrado qué barrera predomina en qué contexto. Tampoco hay que asumir que todo uso prolongado del teléfono es problemático ni que el sedentarismo se explica solo por el diseño de redes sociales.

### Formulación neutral para investigación

> ¿Cómo podríamos facilitar que una persona en medio de una tarea absorbente o de un periodo prolongado de uso de pantalla inicie una pausa física breve y elegible, sin añadir otra tarea, perder innecesariamente el hilo ni depender de que abra una app separada?

Esta pregunta incluye el territorio actual, pero no presupone que deba existir una app, una mascota o un overlay.

---

## 3. Mapa de competencia: categorías y cercanía

### Grupo A — Interrupción justo antes de abrir una app o continuar usándola

**one sec, ScreenZen, Clearspace.** Son comparadores muy cercanos a la idea de “encontrar a la persona cuando está a punto de entrar en el ciclo de scroll”. Usan una pausa, reflexión, demora, límite de aperturas, límite por sesión o bloqueo. Normalmente intervienen al abrir la app o al alcanzar un umbral de uso; no son, por defecto, una mascota flotante que entiende el contenido del Reel en tiempo real.

### Grupo B — Bloqueo y compromiso ambiental

**Opal, Freedom, Brick.** Reducen el acceso a determinadas apps durante horarios o sesiones. Pueden ayudar cuando la persona define previamente el contexto en el que quiere evitar distracciones. Su enfoque es limitar la disponibilidad, no enseñar por sí mismo a hacer una pausa física breve. Brick añade hardware: obliga a acercar físicamente el teléfono a un dispositivo para activar o desactivar modos seleccionados.

### Grupo C — Pausas físicas y ergonomía digital

**Wakeout, Workrave, Stretchly.** Son los antecedentes más próximos a la conducta física de interés. Wakeout facilita movimientos breves y usa juegos corporales; Workrave y Stretchly muestran recordatorios en el computador mientras la persona trabaja. Workrave es especialmente relevante porque cuenta pausas hechas, saltadas y pospuestas, en lugar de asumir que mostrar un aviso significa que hubo una pausa.

### Grupo D — Foco gamificado y compañeros virtuales

**Forest, Focus Friend.** Transforman un periodo de foco en progreso de juego o evolución de un personaje/árbol. Constituyen precedentes para usar un compañero visual, pero se centran principalmente en proteger el foco; no resuelven necesariamente el momento de iniciar una pausa saludable. Sus consecuencias emocionales deben evaluarse con cuidado.

### Grupo E — Autocuidado, hábitos y tareas gamificadas

**Habitica, Finch, Fabulous.** Usan tareas, recompensas, mascotas, secuencias de hábitos, rutinas o coaching. Son relevantes para los conceptos de autocuidado positivo, pero tienen un riesgo de diseño especialmente relacionado con la postulación: transformar el bienestar en más listas, registro, mantenimiento o tareas pendientes.

### Mapa breve

| Producto | Momento en que interviene | Conducta primaria | Mecanismo visible | Cercanía con el problema de nikucode |
|---|---|---|---|---|
| one sec | Al intentar abrir una app objetivo | Reducir aperturas impulsivas | Interrupción, demora y opción explícita de cancelar | Alta para el ciclo de scroll; no inicia necesariamente una pausa física |
| ScreenZen | Al abrir o durante uso sujeto a límites | Reducir scroll y uso no intencional | Pausa personalizable, límites, aperturas limitadas y horarios | Alta para fricción; no es una solución centrada en movimiento |
| Clearspace | Antes de abrir apps elegidas y al alcanzar límites | Reducir aperturas y sesiones prolongadas | Respiración, desafío, límite de sesión, bloqueo y feedback | Alta para el acceso impulsivo; no se ha verificado un efecto específico sobre pausas físicas |
| Opal | Antes/durante sesiones y límites programados | Proteger foco y reducir distracciones | Bloqueo, horarios, límites, informes y puntuaciones | Alta para entorno de trabajo; puede ser demasiado restrictiva para una pausa flexible |
| Freedom | Durante sesiones de bloqueo | Evitar apps/sitios distractores | Bloqueo multisistema y sesiones | Media-alta para foco, baja para enseñar una transición de pausa |
| Brick | Antes/durante periodo de desconexión | Separar físicamente el teléfono del uso impulsivo | Hardware NFC que activa modos | Media; reduce acceso, pero cuesta dinero y no propone una pausa guiada |
| Wakeout | Cuando la persona inicia una actividad de movimiento | Hacer fácil moverse brevemente | Un botón, ejercicios cortos y juegos con el cuerpo | Muy alta para la acción física; aún requiere entrar o responder a la herramienta |
| Workrave | Mientras el computador está en uso | Hacer pausas y descansar de la pantalla | Temporizadores, aviso, aplazar/saltar y estadísticas | Muy alta para trabajo sedentario en escritorio |
| Stretchly | Mientras el computador está en uso | Interrumpir tiempo continuo frente a pantalla | Avisos configurables de pausa | Alta para pausas en escritorio; poca personalización conductual visible |
| Forest | Antes de una sesión de foco | Evitar tocar apps distractoras durante el foco | Árbol que crece, sesión y consecuencia de salida | Media; gamifica el foco, no la pausa antes del agotamiento |
| Focus Friend | Durante una sesión de foco y descansos planificados | Sostener el foco y atravesar bloques de trabajo | Compañero tipo frijol, recompensas y bloqueo opcional | Media; ofrece compañero, pero puede asociar interrupción a decepcionar al personaje |
| Habitica | Al gestionar y completar tareas | Aumentar motivación por completar tareas | RPG, puntos, niveles, premios, comunidad y consecuencias | Media-baja; gestión de listas puede ser lo opuesto a la carga mínima buscada |
| Finch | Al elegir y completar autocuidado | Hacer amable el autocuidado cotidiano | Mascota virtual, metas pequeñas y recompensas narrativas | Media; ofrece tono afectuoso, pero incorpora otra app y rutina de cuidado |
| Fabulous | Al iniciar o seguir rutinas guiadas | Formar hábitos mediante secuencias | Coaching, retos, contenido y habit stacking | Media; útil para contenido y señales, pero puede añadir obligaciones |

---

## 4. Datos públicos comparables: adopción no equivale a éxito

Las cifras siguientes se recuperaron de páginas públicas de Google Play, App Store y webs oficiales alrededor del 18 de octubre de 2026. Las tiendas se actualizan continuamente; por eso conviene conservar fecha y plataforma en vez de presentarlas como cifras permanentes.

| Producto | Indicador público observado | Fuente y estado | Lo que no demuestra |
|---|---|---|---|
| **one sec** | Google Play: 1M+ descargas, ~4,7 estrellas y ~45,8 mil reseñas | [Google Play](https://play.google.com/store/apps/details?id=wtf.riedel.onesec) · DATO DE TIENDA | Retención, uso activo mensual o eficacia para pausas físicas |
| **ScreenZen** | Google Play: 1M+ descargas, ~4,7 estrellas y ~32,1 mil reseñas. Web: 500.000+ usuarios mensuales y 3 horas diarias recuperadas en promedio “según usuarios” | [Google Play](https://play.google.com/store/apps/details?id=com.screenzen); [web oficial](https://screenzen.co/) · datos de tienda y declaración comercial | La afirmación de 3 h/día es autorreportada y no debe tratarse como efecto independiente medido |
| **Clearspace** | Google Play: 100K+ descargas, ~4,5 estrellas y ~940 reseñas. App Store EE. UU.: ~8,9K ratings, 4,7/5 | [Google Play](https://play.google.com/store/apps/details?id=com.clearspace.app); [App Store](https://apps.apple.com/us/app/clearspace-reduce-screen-time/id1572515807) · DATO DE TIENDA | Retención, churn, conducta fuera de la aplicación o un efecto causal |
| **Opal** | Google Play: 500K+ descargas, ~4,5 estrellas y ~8,7K reseñas. Página de producto muestra 150K+ ratings en su presentación global; App Store EE. UU. ~89K ratings en una consulta | [Google Play](https://play.google.com/store/apps/details?id=com.withopal.opal); [web oficial](https://opalapp.com/) · DATOS DE TIENDA/PRODUCTO con bases distintas | No es válido mezclar el contador global de marketing con reseñas regionales; no informa retención |
| **Forest** | Google Play: 10M+ descargas, ~4,3 estrellas y más de 800K reseñas; la ficha del desarrollador declara 60M+ usuarios mundiales | [Google Play](https://play.google.com/store/apps/details?id=cc.forestapp) · tienda + declaración del proveedor | Usuarios declarados no equivalen a usuarios activos o hábito sostenido |
| **Focus Friend** | App Store EE. UU.: ~7,2K ratings y 4,8/5 | [App Store](https://apps.apple.com/us/app/focus-friend-by-hank-green/id6742278016) · DATO DE TIENDA | Retención, eficacia del compañero virtual o menor abandono |
| **Habitica** | Google Play: 5M+ descargas, ~4,7 estrellas y ~75K reseñas; la web dice “más de 4 millones de Habiticans” | [Google Play](https://play.google.com/store/apps/details?id=com.habitrpg.android.habitica); [web oficial](https://habitica.com/) · tienda + declaración de empresa | La población activa o cuánto dura el hábito tras dejar de jugar |
| **Finch** | Google Play: 10M+ descargas, ~4,9 estrellas y ~621K reseñas | [Google Play](https://play.google.com/store/apps/details?id=com.finch.finch) · DATO DE TIENDA | Cambio en salud mental, hábito mantenido o retención por cohorte |
| **Fabulous** | Google Play: 10M+ descargas, ~3,9 estrellas y ~589K reseñas; App Store EE. UU. ~4,4/5 y ~89K ratings | [Google Play](https://play.google.com/store/apps/details?id=co.thefabulous.app); [App Store](https://apps.apple.com/us/app/thefabulous-daily-routine-planner/id1203637303) · DATO DE TIENDA | Por qué difieren las notas entre tiendas ni cuántos usuarios mantienen rutinas |
| **Wakeout** | Web oficial: 10M+ movimientos (“wiggles”) registrados, 10 juegos de movimiento; una sección muestra 4,8 y 50K+ reviews. Una ficha regional de App Store puede mostrar cifras menores | [web oficial](https://wakeout.app/); [features](https://wakeout.app/features) · declaración de empresa y cifras de tienda con alcance distinto | Diez millones de movimientos no significa diez millones de personas ni continuidad conductual |
| **Brick** | La web promociona 55K+ reseñas de cinco estrellas; un artículo de WSJ del 13 de octubre de 2026 reportó cientos de miles de usuarios diarios. Hardware anunciado a US$59 | [web oficial](https://getbrick.com/pages/brick-take-back-your-time); [WSJ](https://www.wsj.com/cmo-today/selling-a-digital-detox-brick-recruits-marketers-to-battle-the-endless-scroll-a0a0f92c) · declaración promocional y prensa | No son datos auditados de retención ni prueban que el dispositivo sea eficaz para toda persona |
| **Workrave** | Proyecto gratuito/open source; no encontré una métrica comparable de usuarios activos o retención en la página consultada | [web oficial](https://workrave.org/); [estadísticas](https://workrave.org/docs/windows/statistics/) | Ausencia de métrica pública no significa ausencia de usuarios ni falta de utilidad |
| **Stretchly** | Proyecto open source para macOS, Windows y Linux; GitHub ofrece código y releases, pero no una tasa pública comparable de retención | [repositorio oficial](https://github.com/hovancik/stretchly) · documentación del proyecto | Stars, descargas de releases o contributors no equivalen a usuarios activos ni impacto |

### Lectura correcta de cifras

1. Instalaciones/descargas son un indicador de distribución acumulada (y pueden incluir reinstalaciones o dispositivos; la tienda usa sus propias definiciones).
2. Las reseñas son una muestra auto-seleccionada de quienes decidieron valorar el producto; no son una tasa de satisfacción de todos los usuarios.
3. Sesiones, pausas o movimientos acumulados son eventos; no usuarios únicos.
4. “Personas ayudadas”, “horas recuperadas” o “usuarios diarios” deben atribuirse a quien los declara y registrar si se explica el método.
5. Retención D1/D7/D30, churn, DAU/MAU, recurrencia a largo plazo, tasa de pausa efectiva y efecto sobre salud son métricas distintas.

**NO PÚBLICO / NO VERIFICADO:** no encontramos cifras públicas independientes comparables de retención D1/D7/D30 o churn específicas para estos productos. Para nikucode no corresponde inventar una cifra ni utilizar benchmarks generales como si predijeran el resultado del prototipo.

---

## 5. Evidencia académica sobre mecanismos y productos cercanos

### 5.1 one sec: el antecedente con evidencia conductual más directa para la apertura impulsiva

**Estudio:** Grüning, Riedel y Lorenz-Spreen (2023), “Directing smartphone use through the self-nudge app one sec”, *Proceedings of the National Academy of Sciences (PNAS)*. DOI: [10.1073/pnas.2213114120](https://doi.org/10.1073/pnas.2213114120); ficha PubMed: [PMID 36795756](https://pubmed.ncbi.nlm.nih.gov/36795756/).

- **Experimento de campo:** registró conducta de 280 participantes durante seis semanas y aplicó encuestas antes/después. La app presentaba una interrupción al intentar abrir apps objetivo: mensaje de deliberación, una breve demora y la opción de cancelar.
- **Resultados informados:** en 36 % de los intentos la persona cerró la app tras la interrupción; las tentativas de abrirla se redujeron 37 % entre la primera y sexta semana; la reducción conjunta de aperturas efectivas fue 57 % al cabo de seis semanas.
- **Prueba preregistrada de mecanismo:** experimento en línea con N=500 y vídeos sociales reales/virales; la opción explícita de cancelar mostró el efecto más fuerte, la fricción de demora también redujo consumo, y el mensaje deliberativo por sí solo no resultó eficaz.
- **Límite importante:** el análisis principal de campo incluyó a quienes usaron one sec durante las seis semanas (N=280) y trató a quienes abandonaron antes como dropouts excluidos del análisis principal. Por ello, el 57 % es un resultado de reducción de aperturas en la muestra analizada, no una tasa de retención; debe leerse junto con el riesgo de sesgo de selección y los análisis suplementarios.
- **Límite contextual:** el resultado es sobre apertura/consumo de apps objetivo, no sobre realizar pausas físicas, prevenir dolor ni retener a usuarios a largo plazo.

**Implicación para nikucode:** una intervención en el punto de decisión puede ser útil y no necesita ser una mascota que interrumpe cada Reel. La posibilidad de “seguir de todos modos” o “no abrir ahora” parece parte esencial de la intervención. Una explicación larga no tiene por qué añadir valor. Si usamos una mascota, debería apoyar la elección, no ser el mecanismo central por defecto.

### 5.2 Gamificación y salud: los efectos promedio tienden a ser modestos

**Estudio:** revisión sistemática y metaanálisis de 36 ensayos/49 comparaciones, N=10.079, publicada en *eClinicalMedicine* (2025), [DOI 10.1016/j.eclinm.2024.102798](https://doi.org/10.1016/j.eclinm.2024.102798), PubMed: [39764571](https://pubmed.ncbi.nlm.nih.gov/39764571/).

Comparadas con apps no gamificadas, las intervenciones gamificadas mostraron aumentos pequeños en pasos (489 pasos/día; IC 95 %: 64–914), reducciones modestas de IMC (-0,28 kg/m²) y peso (-0,70 kg), y pequeños cambios en grasa corporal/cintura. La mayoría de los ensayos abordó actividad física o pérdida de peso; no prueban qué gamificación funciona en una app de pausas breves para estudiantes/programadores.

**Implicación:** la gamificación puede ayudar, pero su presencia no garantiza eficacia. No necesitamos construir una economía de monedas, una mascota compleja ni diez misiones. Debemos probar un mecanismo simple contra una alternativa sin gamificación.

### 5.3 Habitica: cuidado con la gamificación que añade otra carga

**Estudio:** “Counterproductive effects of gamification: An analysis on the example of the gamified task manager Habitica”, *International Journal of Human–Computer Studies*. [Artículo en ScienceDirect](https://www.sciencedirect.com/science/article/pii/S1071581918305135).

- Estudio 1: entrevista fenomenológica a una persona usuaria, que generó temas de efectos contraproducentes.
- Estudio 2: estudio de campo con 45 usuarios durante dos semanas.
- Los participantes experimentaron en algún grado efectos contraproducentes; entre los ejemplos se encontraron sentirse penalizado por el sistema de recompensas/castigos y modificar tareas para evitar sanciones.
- **Límite:** N=45 y dos semanas; no es una estimación de la proporción de todos los usuarios de Habitica ni demuestra que la gamificación sea perjudicial en general.

**Implicación:** para un equipo que declara que rutinas y recordatorios se transforman en obligaciones incumplidas, rachas, castigos y pérdidas de progreso son hipótesis de alto riesgo. Si se usan recompensas, deberían ser optativas, benignas y fáciles de abandonar sin culpa.

### 5.4 Abandono de aplicaciones de salud: el problema de continuidad es real, pero heterogéneo

**Estudio:** Kidman, Curtis, Watson y Maher (2024), “When and Why Adults Abandon Lifestyle Behavior and Mental Health Mobile Apps: Scoping Review”, *Journal of Medical Internet Research*, 26:e56897. [DOI 10.2196/56897](https://doi.org/10.2196/56897); [artículo completo](https://www.jmir.org/2024/1/e56897/).

- Incluyó 18 estudios y 525.824 participantes, con uso en condiciones reales de apps relacionadas con actividad física, dieta, alcohol, tabaco y salud mental.
- La mediana agrupada fue que el 70 % dejó de usar la app dentro de los primeros 100 días.
- Las cifras variaron por dominio: actividad física 54–75 % (3 estudios); salud mental 89–92 % (2); alcohol 95–97 % (2); dieta 86 % (1); tabaquismo 40 % (1).
- Los motivos se agruparon en seis categorías: problemas técnicos/funcionales, privacidad, mala experiencia de usuario, contenido/funciones, costes de tiempo/dinero, y cambio de necesidades/metas.
- **Límite:** definiciones y dominios heterogéneos; varias categorías se basan en muy pocos estudios; no se pueden aplicar el 70 % o los rangos a los competidores individuales aquí examinados.

**Implicación:** minimizar fricción, evitar que se requiera registro constante, entregar valor rápido y facilitar el retorno después de una interrupción son puntos razonables a diseñar y medir. No son garantías de retención.

### 5.5 Herramientas de pausas de escritorio: importante precedente para el problema físico

Workrave declara que ofrece microbreaks, rest breaks y límites de uso del computador. Sus valores de referencia predeterminados suelen ser 30 segundos cada 3 minutos para microbreaks y alrededor de 10 minutos cada 45 minutos para descansos más largos; son configurables, no una recomendación médica universal. Permite ver pausas solicitadas, pausas realizadas ante aviso, pausas naturales, pausas saltadas, pospuestas, tiempo vencido y uso de computador. [Workrave](https://workrave.org/) · [estadísticas](https://workrave.org/docs/windows/statistics/) · [detalles de pausas](https://workrave.org/docs/breaks/).

Stretchly es una app open source de recordatorios de pausas para macOS, Windows y Linux. [Repositorio oficial](https://github.com/hovancik/stretchly).

**Implicación:** “recordar hacer una pausa mientras se trabaja frente al computador” no es un espacio vacío. La investigación debe definir si el punto de dolor está en la hora del aviso, en la transición cognitiva, en la facilidad de comenzar un movimiento, en el descanso que se reemplaza por otra pantalla o en el peso de abrir y configurar otra herramienta. Workrave enseña además una buena práctica de medición: registrar pausas ignoradas o pospuestas, no solo avisos enviados.

---

## 6. Características, mecanismos y riesgos por competidor

### 6.1 one sec

**Funciones visibles:** interrupción antes de abrir apps elegidas; respiración, espejo o reflexión breve; opción de cancelar; demora; bloqueo; límites; seguimiento de intenciones y emociones; alternativas saludables y extensión de navegador. [Sitio oficial](https://one-sec.app/) · [investigación publicada](https://one-sec.app/research/) · [estudio PNAS](https://pubmed.ncbi.nlm.nih.gov/36795756/).

**Mecanismo plausible:** romper automatismo justo antes de la acción, introducir fricción y devolver una decisión explícita.

**Ventaja como antecedente:** prueba que una intervención muy breve fuera del contenido de la red social puede operar sin aparecer encima de cada publicación.

**Riesgo/límite:** puede ser una fricción extra al abrir la app, no una intervención sobre contenido Reel por Reel. Los datos del estudio no demuestran beneficio físico ni previenen el dolor.

**Qué aprender:** probar una sola decisión sencilla (seguir, cerrar, hacer pausa) puede aportar más que un mensaje educativo largo. No copiar la afirmación de “57 %” como previsión para nikucode.

### 6.2 ScreenZen

**Funciones visibles:** elegir apps; pausa antes de abrir; limitar tiempo por sesión; reducir aperturas; horarios de bloqueo; registro de progreso y dispositivo acompañante “halo”. [Web oficial](https://screenzen.co/) · [Google Play](https://play.google.com/store/apps/details?id=com.screenzen).

La web declara más de 500.000 usuarios al mes y 3 horas diarias recuperadas en promedio “según usuarios”. Debe citarse como declaración/autorregistro de la empresa, no como evaluación independiente.

**Mecanismo plausible:** permitir que la persona establezca reglas previas, de modo que no tenga que renegociar cada decisión al entrar en un feed.

**Aprendizaje:** los usuarios pueden querer flexibilidad configurable, no solo bloqueo extremo. Las reseñas públicas sugieren que esperas, desbloqueos limitados y preguntas de intención pueden ayudar a algunas personas; también mencionan errores y frustración de configuración. Son ejemplos cualitativos, no prevalencia.

### 6.3 Clearspace

**Funciones visibles:** pausas antes de abrir, respiración, límites de sesión y por app, retos, rachas y presupuestos, informes y rendición de cuentas con personas de confianza. [App Store EE. UU.](https://apps.apple.com/us/app/clearspace-reduce-screen-time/id1572515807) · [Google Play](https://play.google.com/store/apps/details?id=com.clearspace.app).

**Mecanismo plausible:** combinar pausa/reflexión con límites más exigentes y retos.

**Aprendizaje:** la intervención en el momento de entrada ya es competencia directa. El relato diferencial de nikucode no puede ser solo “aparecemos para hacerte pensar”. Tendría que mostrar por qué un gesto de pausa física específico ayuda más que la pausa genérica o el bloqueo existente.

**Riesgo:** las rachas o retos que provocan miedo a perder progreso podrían reproducir presión. Las fichas de las tiendas también muestran divulgaciones de privacidad relevantes; deben revisarse las políticas vigentes si se propone cualquier acceso al uso de apps.

### 6.4 Opal y Freedom

**Funciones visibles:** bloqueo de apps/sitios, horarios, sesiones de foco, límites de tiempo, listas permitidas/bloqueadas e informes; Freedom opera en más de una plataforma. [Opal](https://opalapp.com/) · [FAQ de Opal](https://opalapp.com/help/what-is-opal) · [Freedom iOS](https://support.freedom.to/en/articles/14596751-how-freedom-blocks-apps-and-websites-on-ios).

**Mecanismo plausible:** cambiar el entorno y crear dispositivos de compromiso antes de que ocurra una conducta no deseada.

**Aprendizaje:** una app no necesita estar en primer plano todo el tiempo para ayudar. Reglas automáticas y temporizadores evitan tener que recordar abrir una herramienta.

**Riesgo:** los bloqueos pueden ser demasiado rígidos cuando una persona necesita usar el teléfono, desea elegir una pausa o está en una circunstancia que no encaja con el horario establecido.

### 6.5 Brick

**Funciones visibles:** dispositivo físico NFC que activa o desactiva modos de bloqueo para apps elegidas; [web oficial](https://getbrick.com/pages/brick-take-back-your-time). Un artículo del WSJ publicado el 13 de octubre de 2026 reportó cientos de miles de usuarios diarios, sin ser una auditoría de retención [WSJ](https://www.wsj.com/cmo-today/selling-a-digital-detox-brick-recruits-marketers-to-battle-the-endless-scroll-a0a0f92c).

**Mecanismo plausible:** desplazar la decisión desde el teléfono a una acción física en el entorno.

**Aprendizaje:** eliminar acceso automático a una app puede requerir soporte fuera de la pantalla. Sin embargo, el hardware y coste no son adecuados como supuesto de base para una hackatón de dos días.

### 6.6 Wakeout

**Funciones visibles:** botón “Move Now”, movimientos de un minuto, retos diarios, rutinas de uno a cinco minutos, ejercicios contextualizados (escritorio, espera, habitación), instrucciones por vídeo y juegos controlados con movimientos corporales. [Web](https://wakeout.app/) · [características](https://wakeout.app/features).

**Declaración comercial:** 10M+ movimientos registrados, 10 juegos y varios contextos de ejercicio; no es una cantidad de usuarios únicos ni una evaluación clínica.

**Mecanismo plausible:** reducir el umbral de entrada, hacer la acción inmediata y convertir movimiento en juego.

**Aprendizaje:** esta es una de las competencias más directas porque ya conecta pantalla con acción física breve. Una solución nueva debe diferenciar el disparador o la transición, no solo añadir movimientos o una mascota.

**Riesgo:** un juego en el teléfono puede alargar el tiempo de pantalla; el indicador de éxito debe ser una acción física ejecutada, no vistas del vídeo ni interacciones con el juego.

### 6.7 Workrave y Stretchly

**Funciones visibles:** temporizadores de microdescansos y descansos largos, recordatorios que se pueden configurar, posibilidad de aplazar o saltar; estadísticas sobre avisos ignorados/pospuestos y pausas realizadas en Workrave. [Workrave](https://workrave.org/) · [estadísticas](https://workrave.org/docs/windows/statistics/) · [Stretchly](https://github.com/hovancik/stretchly).

**Mecanismo plausible:** aprovechar que el sistema ya está en uso para realizar una transición sin que la persona tenga que abrir una app móvil aparte.

**Aprendizaje:** correr discretamente en el entorno donde ocurre el sedentarismo puede ser valioso, pero la notificación clásica ya existe como patrón y puede volverse ruido. Hay que probar el momento, el coste de interrumpir y qué pasa si la persona ignora el aviso.

**Riesgo:** seguimiento de tiempo de teclado/ratón puede generar preocupación por privacidad; para el MVP, una regla local sencilla evita monitorización innecesaria.

### 6.8 Forest y Focus Friend

**Forest:** sesión de foco representada por crecimiento de árbol; el abandonar la sesión puede perjudicar el crecimiento virtual; la app incorpora estadísticas y opciones sociales. Google Play informa 10M+ descargas y la empresa declara 60M+ usuarios; [Google Play](https://play.google.com/store/apps/details?id=cc.forestapp).

**Focus Friend:** sesión de foco en que el compañero tipo frijol realiza una tarea de tejido; finalizar la sesión da recompensas decorativas, y cortar la sesión hace que el compañero “se ponga muy triste”; incluye modo de foco, opciones de bloqueo y temporizadores de pausa. App Store EE. UU.: alrededor de 7,2K valoraciones, 4,8/5. [Sitio](https://focusfriend.me/) · [App Store](https://apps.apple.com/us/app/focus-friend-by-hank-green/id6742278016).

**Mecanismo plausible:** el compañero/progreso hace visible el tiempo y ofrece una recompensa estética inmediata.

**Aprendizaje:** una mascota puede ser un símbolo amable, pero no es automáticamente adecuada. El personaje podría volverse una carga emocional si “sufre” cuando el usuario necesita parar. Para nikucode, sería más coherente reconocer una pausa realizada y permitir regresar o rechazar la invitación sin penalización.

### 6.9 Habitica

**Funciones visibles:** hábitos, tareas diarias y pendientes; avatar, puntos, monedas, experiencia, objetos, mascotas, misiones y cooperación social. [Sitio oficial](https://habitica.com/) · [Google Play](https://play.google.com/store/apps/details?id=com.habitrpg.android.habitica).

**Mecanismo plausible:** externalizar objetivos y asociar recompensas a acciones fuera de la app.

**Aprendizaje:** el juego puede hacer motivante el registro de tareas para algunos usuarios, pero nuestra postulación describe cansancio con listas/rutinas y obligaciones incumplidas. Si hay un tablero, su tamaño debe ser mínimo; no empezar por una lista general de hábitos.

**Riesgo:** el estudio específico de efectos contraproducentes de gamificación en Habitica (45 usuarios durante dos semanas) encontró que cada participante experimentó algún efecto negativo en cierto grado en esa muestra. No se generaliza la frecuencia a toda la base de usuarios, pero es suficiente para incluir como riesgo el castigo, la pérdida de rachas y la inflación de tareas.

### 6.10 Finch y Fabulous

**Finch:** mascota virtual que progresa mediante pequeñas metas de autocuidado, además de ejercicios guiados, reflexiones, respiración y herramientas de bienestar. Google Play: 10M+ descargas y aproximadamente 4,9/5 en la consulta. [Google Play](https://play.google.com/store/apps/details?id=com.finch.finch) · [App Store](https://apps.apple.com/us/app/finch-self-care-pet/id1528595748).

**Fabulous:** rutinas y programas guiados, habit stacking, contenido educativo, coaching y retos. Google Play: 10M+ descargas; calificación próxima a 3,9/5 en la consulta. [Google Play](https://play.google.com/store/apps/details?id=co.thefabulous.app).

**Aprendizaje conjunto:** tono agradable, metas pequeñas y contenido breve pueden facilitar el autocuidado. Pero ambos enfoques pueden exigir entrar a la app, mantener una rutina y hacer seguimiento. La pregunta de nikucode es si la acción puede ocurrir con menos intermediación digital, no si podemos producir más contenido.

---

## 7. ¿Puede aparecer una mascota por encima de Instagram/Reels?

### 7.1 iOS: la idea de overlay flotante no es una base fiable para el MVP

Apple ofrece APIs oficiales de Screen Time: **FamilyControls**, **ManagedSettings** y **DeviceActivity**. Con autorización explícita, una app puede seleccionar apps/sitios y aplicar restricciones; **ManagedSettingsUI** permite personalizar la pantalla de protección (*shield*) que el sistema presenta cuando una app o web está restringida o se alcanza un límite. La app debe solicitar el entitlement de Family Controls para distribuir ese tipo de capacidades. [Apple Screen Time frameworks](https://developer.apple.com/documentation/screentimeapidocumentation/) · [Managed Settings UI](https://developer.apple.com/documentation/ManagedSettingsUI) · [Family Controls](https://developer.apple.com/documentation/familycontrols).

No encontramos una API pública de iOS que permita a una aplicación ordinaria insertar libremente una mascota flotante interactiva **dentro de la interfaz activa de Instagram y encima de cada Reel**. Las vías soportadas más próximas son intervenir al abrir la app, enviar una notificación/automatización o presentar un shield del sistema cuando se active una restricción. Esta conclusión se basa en el modelo de APIs documentado, no en una afirmación de que Apple haya publicado una frase literal “los overlays están prohibidos”.

**Consecuencia:** en iOS, un prototipo que prometa “la mascota aparecerá sobre los Reels en tiempo real” sería técnicamente engañoso sin una integración no disponible o sin cambiar la plataforma. No planificarlo como función base.

### 7.2 Android: es técnicamente más posible, pero con permisos y riesgos

Android permite ventanas `TYPE_APPLICATION_OVERLAY` por encima de otras ventanas de aplicaciones con el permiso especial `SYSTEM_ALERT_WINDOW`, que el usuario debe conceder desde ajustes. Android advierte que ese permiso debería usarse por pocas apps y que estas ventanas pueden reubicarse u ocultarse por el sistema. [Documentación oficial](https://developer.android.com/reference/android/Manifest.permission#SYSTEM_ALERT_WINDOW) · [TYPE_APPLICATION_OVERLAY](https://developer.android.com/reference/kotlin/android/view/WindowManager.LayoutParams).

Para identificar cambios de ventana o entender qué ocurre en otra app podría requerirse `AccessibilityService` u otros permisos de uso. Google Play exige divulgación destacada y consentimiento afirmativo cuando corresponde, requiere una declaración de uso, y prohíbe que la API permita acciones autónomas no autorizadas; solo funciones estrechas y comprensibles pueden encajar en automatización general. No se puede declarar como “herramienta de accesibilidad” a una app general que no tiene a las personas con discapacidad como propósito principal. [Política oficial de Google Play](https://support.google.com/googleplay/android-developer/answer/10964491).

**Consecuencia:** Android permite una prueba técnica de overlay, pero eso no lo hace la mejor decisión. Detectar “Instagram está en primer plano durante X minutos” es muy distinto de reconocer con fiabilidad cuándo la persona está viendo Reels o cuánto contenido ha desplazado. Mirar el contenido de pantalla sería más invasivo, más complejo y probablemente innecesario.

### 7.3 Alternativas de menor coste que preservan la hipótesis

| Alternativa | Qué representa | Dependencias | Qué se puede probar ahora | Límite |
|---|---|---|---|---|
| Pausa antes de abrir Instagram (patrón one sec/ScreenZen) | Interrumpir un acceso impulsivo | APIs/automatizaciones del sistema; permisos y setup | Comprensión, utilidad percibida, si el usuario elige cancelar o continuar en una simulación | No aparece durante el scroll ya iniciado |
| Shield/bloqueo de app al llegar a un límite | Intervenir cuando se cumple una regla temporal | Screen Time APIs y entitlement en iOS; permisos equivalentes en Android | Flujo de decisión y tolerancia a la interrupción | Puede bloquear en vez de sugerir una pausa; no es una mascota flotante |
| Aviso discreto tras tiempo de app en primer plano (Android) | Activar por tiempo transcurrido, sin analizar cada Reel | Permiso overlay/uso y pruebas en varios dispositivos | Una prueba técnica acotada, si se justifica más adelante | Privacidad, permisos, fiabilidad y variación entre sistemas |
| Recordatorio en computador | Interrumpir sesiones de teclado/ratón | App de escritorio o configuración local; menos dependencia móvil | Reacción a señal, aplazar/saltar, pausa real en escenario controlado | No cubre el tiempo que después se pasa en el celular |
| Pretotipo/storyboard de mascota | Representar una pequeña intervención en contexto de Reels | Ninguna API real; escenario claramente simulado | Si se entiende, se percibe como apoyo y ayuda a elegir una acción física | No prueba integración, uso real ni eficacia |
| Actividad física inmediata en un toque | Convertir la intención en movimiento | Módulo muy simple y contenido breve | Facilidad de iniciar, pasos, tiempo y comprensión | Si requiere navegación puede añadir carga; Wakeout ya aborda movimiento breve |

### 7.4 Conclusión técnica

No implementar un overlay real como primer prototipo. Primero probar si **una transición muy breve desde la pantalla hacia una acción física** es comprensible y aceptable. Si el mecanismo merece avanzar, decidir después en qué plataforma y con qué permisos se podría ejecutar una prueba técnica pequeña. El sistema operativo es una dependencia de la solución, no el punto de partida del problema.

---

## 8. ¿Dónde podría estar una oportunidad real para nikucode?

El paisaje competitivo sugiere tres intersecciones que vale la pena explorar, no afirmar como novedosas:

### Oportunidad A — De la interrupción a la pausa física (no solo “no abras”)

one sec, ScreenZen y Clearspace trabajan sobre abrir/seguir usando apps; Wakeout trabaja en el movimiento; Workrave/Stretchly dan pausas de escritorio. Una hipótesis sería unir el punto de interrupción con **una acción física inmediatamente ejecutable**, sin crear una secuencia de contenido que alargue el tiempo de pantalla.

**Pregunta:** ¿una invitación con un botón de “pausa física breve” es más accionable que un recordatorio general o una reflexión sobre el uso de redes?

### Oportunidad B — Ayuda contextual sin lista ni onboarding pesado

Los sistemas de foco suelen necesitar reglas y configuración; las apps de hábito suelen pedir metas, rutinas o registros. Nuestra postulación sugiere que la propia gestión de hábitos puede sentirse como otra obligación.

**Pregunta:** ¿podemos entregar valor sin que la persona tenga que construir una rutina, marcar hábitos, ver dashboards o configurar muchas opciones?

### Oportunidad C — Gamificación amable que disminuya, en vez de aumentar, la dependencia

Forest, Focus Friend, Habitica y Finch muestran varios tipos de compañero y progreso. La gamificación puede ser útil, pero el estudio de Habitica evidencia riesgos contraproducentes, y la investigación general muestra beneficios físicos medios modestos.

**Pregunta:** ¿un reconocimiento breve posterior a moverse ayuda sin crear culpa, rachas, ansiedad por el personaje o necesidad de volver a la app?

No hay todavía evidencia suficiente para escoger A, B o C. Antes de decidir, necesitamos un pretotipo de dos o tres flujos y definir de antemano qué resultado haría mantener, cambiar o descartar cada mecanismo.

---

## 9. Protocolo de pretotipo recomendado para la hackatón

Este protocolo es un **plan por ejecutar**, no un experimento realizado. Debe llevarse a cabo solo dentro de los límites de la hackatón y con materiales creados durante el evento cuando así lo exijan las reglas.

### Pregunta prioritaria

¿Una intervención que presenta una opción inmediata de pausa física después de un contexto simulado de scroll ayuda a iniciar la pausa con menos fricción que una interrupción genérica?

### Variantes posibles

- **A — Aviso genérico:** “Llevas un rato aquí. ¿Quieres hacer una pausa?”
- **B — Elección accionable:** “¿Un minuto fuera de pantalla? Levántate, estira suavemente o elige ‘ahora no’”.
- **C — Variante con microcontenido opcional:** el mismo mensaje que B, con una sola frase educativa corta. Mantenerla como tercera variante solo si el tiempo alcanza; no evaluar siete funciones al mismo tiempo.

La mascota virtual no debería añadirse a la comparación inicial a menos que exista un supuesto concreto que probar. Si se incluye, comparar la misma interacción con y sin personaje, sin castigar al usuario por elegir no pausar.

### Diseño de prueba

- Usar un escenario completamente ficticio; no registrar datos reales de uso, salud o comportamiento de Alex/Javier.
- Mostrar cada flujo como storyboard o prototipo clicable construido durante la hackatón.
- Pedir al evaluador que explique qué haría y completar una tarea definida, no solo preguntar “¿te gusta?”.
- Registrar: si entiende la propuesta; qué botón elegiría; pasos requeridos; si percibe presión; si identifica qué acción física haría; dudas y errores observados.
- No afirmar que el test predice el cambio de hábito ni el efecto sobre dolor, agotamiento o salud mental.

### Criterios de decisión — fijar antes de la prueba

| Resultado observado | Decisión provisional |
|---|---|
| Las personas entienden el flujo sin explicación y la opción física les queda clara, con poca fricción | Continuar a un prototipo funcional del flujo principal |
| La mayoría se queda en “¿qué significa esto?” o el texto educativo distrae | Reducir copy y probar la acción directa |
| El personaje genera culpa, obligación o distrae de levantarse | Eliminar personaje en esa versión |
| La intervención parece útil pero la integración real excede el tiempo o exige permisos sensibles | Mantener el flujo simulado y delimitar explícitamente la función no implementada |
| Las observaciones son contradictorias o dependen de explicaciones del equipo | Resultado inconcluso; corregir la interacción y repetir, no declarar validación |

No usar porcentajes de éxito arbitrarios después de observar los resultados. Si se desea un umbral numérico, acordarlo antes de la prueba y justificar por qué ese nivel es razonable para el tamaño y propósito del ensayo.

---

## 10. Métricas para diseñar un producto útil, no adictivo

La métrica principal del caso sigue siendo la de la postulación: **facilitar pausas breves antes de llegar al dolor o agotamiento**. En un prototipo de hackatón, solo podremos evaluar indicadores intermedios.

### Métricas de prototipo

- **Comprensión:** puede explicar qué propone la intervención y qué puede hacer a continuación.
- **Tasa de inicio en tarea simulada:** personas que empiezan el flujo de pausa entre quienes reciben una oportunidad definida. Es un indicador de usabilidad en la prueba, no de conducta cotidiana.
- **Carga/fricción:** número de pasos/decisiones requeridos, puntos de confusión y tiempo hasta comprender la acción.
- **Autonomía:** comprende cómo posponer o rechazar sin castigo.
- **Interrupciones no deseadas:** si el aviso llega o se interpreta como inoportuno en el escenario.
- **Acción fuera de pantalla:** en una prueba presencial solo registrar si la acción física indicada puede ejecutarse; no convertir una simulación en evidencia de cambio de hábito.

### Métricas longitudinales (si algún día hay piloto real y consentimiento)

- **Retención D1/D7/D30:** porcentaje de una cohorte que regresa en una ventana definida. No confundir con eficacia.
- **Adopción de la intervención:** proporción de oportunidades válidas que terminan en una pausa breve, con definición y fuente claras.
- **Latencia:** tiempo desde invitación hasta inicio de pausa.
- **Recuperación tras lapsos:** volver a realizar una pausa después de varias oportunidades ignoradas, sin “reinicio” ni castigo.
- **Carga percibida/aceptabilidad:** cuánto molesta, distrae o exige el mecanismo.
- **Impacto real:** requeriría un estudio apropiado, duración suficiente, línea base/comparador y medidas éticamente justificadas. No puede inferirse de una demo.

### Métrica que no conviene optimizar por sí sola

**Tiempo en la propia app, aperturas, sesiones, rachas o “engagement” no son sustitutos válidos del bienestar.** Una intervención exitosa podría reducir el tiempo que el usuario pasa dentro del producto si consigue que se levante y continúe con su vida. Por eso, diseñar para retención comercial y diseñar para resultado saludable pueden entrar en tensión.

---

## 11. Decisiones y no-decisiones

### Decisiones metodológicas vigentes

1. No afirmar que el producto será “único” sin comparar más alternativas y contrastar la formulación con usuarios.
2. No definir éxito como abrir la app, interactuar con la mascota, mantener rachas o consumir contenido educativo.
3. Mantener la privacidad por defecto; no leer el contenido de pantalla, capturar Reels, registrar pulsaciones ni analizar salud del equipo para el prototipo.
4. En una primera versión, priorizar el menor coste de cambiar de tarea y una acción física inmediata.
5. Probar una o dos hipótesis de manera explícita; no mezclar interrupción, mascota, IA, gamificación, contenido educativo y detección de uso en un MVP enorme.
6. La integración de overlay sobre Instagram es una posibilidad de investigación técnica —con limitaciones claras— y no una decisión de producto.
7. El trabajo competitivo se crea durante la hackatón según las bases de Makana; este documento prepara método e investigación, no código ni pantallas competitivas prefabricadas.

### Hipótesis abiertas

- H1: intervenir en el punto de apertura o de scroll puede interrumpir un automatismo sin añadir una app que la persona recuerde abrir.
- H2: vincular esa interrupción con una acción física de un toque puede cerrar mejor el puente entre reconocer la necesidad y moverse.
- H3: una invitación con elección explícita puede ser más útil que una frase exhortativa o educativa larga.
- H4: el contenido educativo breve podría cambiar la comprensión, pero podría también aumentar la pantalla; debe probarse frente a una variante sin contenido.
- H5: una mascota puede aportar calidez, pero podría producir culpa, ruido visual o una interacción adicional. No se incorpora sin un supuesto específico.
- H6: el momento de la pausa probablemente depende de la tarea/contexto; un temporizador universal puede ser ignorado o interrumpir mal.
- H7: una solución que se integra en el entorno tiene menos fricción, pero la integración puede requerir permisos y reducir confianza.

### Decisiones de arquitectura técnica aún abiertas

- iOS: evaluar FamilyControls/ManagedSettings como una opción para restricciones o shields; no prometer overlay arbitrario dentro de Instagram.
- Android: un overlay es técnicamente posible con `SYSTEM_ALERT_WINDOW`, pero requiere permiso especial; usar AccessibilityService puede exigir divulgación, consentimiento y revisión de política. No añadirlo sin una necesidad clara.
- Escritorio: Workrave/Stretchly muestran que los avisos pueden operar en el contexto de trabajo, pero crear software de escritorio competitivo no se justifica hasta elegir la hipótesis.
- MVP web: puede representar con claridad una transición o un companion, pero no demuestra integración con un teléfono ni una intervención dentro de Reels.

---

## 12. Fuentes principales y estado

### Fuentes primarias/documentación de producto

1. one sec — [Sitio oficial](https://one-sec.app/); [investigación](https://one-sec.app/research/); [Google Play](https://play.google.com/store/apps/details?id=wtf.riedel.onesec).
2. ScreenZen — [Sitio oficial](https://screenzen.co/); [Google Play](https://play.google.com/store/apps/details?id=com.screenzen).
3. Clearspace — [App Store estadounidense](https://apps.apple.com/us/app/clearspace-reduce-screen-time/id1572515807); [Google Play](https://play.google.com/store/apps/details?id=com.clearspace.app).
4. Opal — [Sitio oficial](https://opalapp.com/); [FAQ sobre funcionamiento y privacidad](https://opalapp.com/help/what-is-opal); [Google Play](https://play.google.com/store/apps/details?id=com.withopal.opal).
5. Freedom — [Documentación iOS sobre bloqueo](https://support.freedom.to/en/articles/14596751-how-freedom-blocks-apps-and-websites-on-ios).
6. Brick — [Sitio oficial](https://getbrick.com/pages/brick-take-back-your-time); [reporte WSJ](https://www.wsj.com/cmo-today/selling-a-digital-detox-brick-recruits-marketers-to-battle-the-endless-scroll-a0a0f92c).
7. Wakeout — [Sitio oficial](https://wakeout.app/); [características](https://wakeout.app/features).
8. Workrave — [Sitio oficial](https://workrave.org/); [estadísticas](https://workrave.org/docs/windows/statistics/); [descripción de pausas](https://workrave.org/docs/breaks/).
9. Stretchly — [Repositorio oficial](https://github.com/hovancik/stretchly).
10. Forest — [Google Play](https://play.google.com/store/apps/details?id=cc.forestapp).
11. Focus Friend — [Sitio oficial](https://focusfriend.me/); [App Store](https://apps.apple.com/us/app/focus-friend-by-hank-green/id6742278016).
12. Habitica — [Sitio oficial](https://habitica.com/); [Google Play](https://play.google.com/store/apps/details?id=com.habitrpg.android.habitica).
13. Finch — [Google Play](https://play.google.com/store/apps/details?id=com.finch.finch); [App Store](https://apps.apple.com/us/app/finch-self-care-pet/id1528595748).
14. Fabulous — [Google Play](https://play.google.com/store/apps/details?id=co.thefabulous.app).

### Evidencia académica

15. Grüning, D. J., Riedel, F., & Lorenz-Spreen, P. (2023). “Directing smartphone use through the self-nudge app one sec.” *PNAS*, 120(8), e2213114120. [DOI](https://doi.org/10.1073/pnas.2213114120) · [PubMed](https://pubmed.ncbi.nlm.nih.gov/36795756/).
16. “Counterproductive effects of gamification: An analysis on the example of the gamified task manager Habitica.” *International Journal of Human–Computer Studies*. [Artículo](https://www.sciencedirect.com/science/article/pii/S1071581918305135).
17. “Effect of digital health applications with or without gamification on physical activity and cardiometabolic risk factors: a systematic review and meta-analysis of randomized controlled trials.” PubMed 39764571. [PubMed](https://pubmed.ncbi.nlm.nih.gov/39764571/) · [DOI](https://doi.org/10.1016/j.eclinm.2024.102798).
18. Kidman, P. G., Curtis, R. G., Watson, A., & Maher, C. A. (2024). “When and Why Adults Abandon Lifestyle Behavior and Mental Health Mobile Apps: Scoping Review.” *JMIR*, 26, e56897. [DOI](https://doi.org/10.2196/56897) · [texto completo](https://www.jmir.org/2024/1/e56897/).

### Documentación de sistema operativo y políticas

19. Apple — [Screen Time Technology Frameworks](https://developer.apple.com/documentation/screentimeapidocumentation/).
20. Apple — [Managed Settings UI / shields](https://developer.apple.com/documentation/ManagedSettingsUI).
21. Apple — [Family Controls authorization](https://developer.apple.com/documentation/familycontrols).
22. Android — [SYSTEM_ALERT_WINDOW](https://developer.android.com/reference/android/Manifest.permission#SYSTEM_ALERT_WINDOW) y [TYPE_APPLICATION_OVERLAY](https://developer.android.com/reference/kotlin/android/view/WindowManager.LayoutParams).
23. Google Play — [Política de uso de AccessibilityService](https://support.google.com/googleplay/android-developer/answer/10964491).

---

## 13. Recomendación provisional para el proyecto

No competir intentando construir otra app de listas, otro bloqueo de redes sociales o un clon de Wakeout/Finch. La exploración que parece más alineada con la postulación es **un puente de baja fricción entre una interrupción de pantalla y una pausa física elegible**, posiblemente con una señal de diseño amable, pero sin exigir un registro, una rutina, una mascota persistente o contenido adicional.

El orden debe seguir siendo:

1. Confirmar en el brief de la hackatón la definición de entrega y restricciones aplicables.
2. Formular la barrera prioritaria después de leer el caso real (en el caso propio, usar el texto de postulación como fuente, pero no tratarlo como estudio representativo).
3. Elegir una hipótesis principal y un supuesto más riesgoso.
4. Crear durante el evento un pretotipo con una comparación simple entre aviso genérico y elección accionable.
5. Fijar un criterio previo y registrar resultados/limitaciones.
6. Construir solo si el pretotipo informa una interacción clara que se pueda demostrar antes del cierre.

**Criterio de cierre de esta investigación:** el equipo puede explicar qué soluciones existentes cubren los mecanismos cercanos, qué estadísticas son comerciales o académicas, qué información sigue siendo no pública y qué hipótesis concreta vale la pena probar. Este informe no valida la solución ni afirma que el territorio propuesto sea único.
