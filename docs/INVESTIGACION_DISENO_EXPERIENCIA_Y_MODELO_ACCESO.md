# Diseño de experiencia, diferenciación y modelo de acceso

**Fecha de actualización:** 23 de octubre de 2026
**Estado:** síntesis de diseño e hipótesis comerciales para orientar la siguiente iteración. No constituye una evaluación de usuarios ni una validación del modelo de negocio.

## Resumen ejecutivo

La evidencia disponible no identifica una paleta, composición o mecanismo de persuasión óptimo para todas las aplicaciones de bienestar. Sí favorece probar interfaces claras, coherentes, accesibles y con pocas tareas obligatorias. Para nikucode, la dirección recomendada es una experiencia breve y orgánica que se sienta como una pausa dentro de la jornada: una composición con personalidad visual propia, sin adoptar el dashboard, las tarjetas de progreso ni la estética de una aplicación clínica genérica. La prioridad funcional continúa siendo el paso entre seguir trabajando y empezar una pausa opcional.

La visita del equipo a Makana aporta una observación cualitativa propia: en la cuenta y versión probadas, el producto se percibió amplio y algunas funciones requirieron acceso de pago. Esto orienta una pregunta de diferenciación, pero no permite afirmar que toda la plataforma sea exclusivamente de pago ni que su amplitud o monetización reduzcan su eficacia. La información pública describe Makana como una plataforma de bienestar multidimensional y comercialización modular B2B, además de acceso individual B2C. La oportunidad para nikucode es explicar un problema más acotado y demostrar una respuesta concreta, sin desacreditar a Makana ni presentarse como sustituto de sus servicios.

Para el acceso, se propone preservar gratuitamente y sin fecha de vencimiento el recorrido esencial. Las opciones pagadas, una eventual cuenta y los incentivos son decisiones de producto futuras que requieren validar necesidades, comprador y efectos sobre autonomía y equidad. Una jornada gratuita aleatoria no tiene respaldo específico para este caso; si se experimenta con pases, conviene que sean comprensibles, voluntarios y con condiciones explícitas.

## Preguntas y método

Esta revisión dirigida integra: (a) la síntesis de evidencia de interfaz ya incluida en [la investigación de estética y accesibilidad](INVESTIGACION_ESTETICA_ESTRUCTURA_ACCESIBILIDAD_2026-10-22.md); (b) una consulta de fuentes primarias y revisiones sobre diseño de aplicaciones de salud, accesibilidad, recompensas y disposición a pagar; (c) información pública actual de Makana; y (d) la observación de uso que Alex comunicó desde la aplicación instalada. La conversación de GitHub Copilot se recibió como texto pegado por el equipo; sus referencias y conclusiones no se atribuyen como verificación propia salvo cuando se consultaron de nuevo las fuentes indicadas a continuación.

No es una revisión sistemática ni una prueba de mercado. La observación de Makana no es un estudio comparativo: no registra cuenta, duración, módulos, versión, plan o condiciones de acceso con suficiente detalle para generalizar. Las páginas del producto describen posicionamiento y contratos, no resultados independientes de eficacia. Las preferencias de diseño requieren pruebas con usuarios y dispositivos reales.

## Evidencia de interfaz y experiencia

Una revisión temática de 35 estudios de diseño de intervenciones mHealth clasificó siete temas de participación. En siete estudios aparecieron comentarios de estética de interfaz: los participantes preferían una presentación simple y coherente y expresaron que el exceso de texto podía abrumar. En 17 estudios se mencionó la facilidad de navegación; la claridad sobre el siguiente paso y la reducción de tareas innecesarias fueron recurrentes. Es una síntesis de preferencias y experiencias recogidas en estudios heterogéneos, no una comparación causal que determine el diseño ganador de nuestra app. [Wei et al., *JMIR*, 2020](https://www.jmir.org/2020/12/e21687/).

La misma revisión identificó recordatorios, personalización y recompensas como estrategias utilizadas. Su presencia en aplicaciones no prueba que sean necesarias aquí ni que mejoren el resultado conductual. Una revisión sobre gamificación en salud y bienestar encontró evidencia heterogénea y escasa medición directa de motivación intrínseca; por ello, no se recomienda equiparar puntos o recompensas con adherencia o bienestar. [Johnson et al., revisión sistemática](https://pmc.ncbi.nlm.nih.gov/articles/PMC6096297/).

La estética debe acompañar al uso: no reemplaza comprensión, funcionamiento ni accesibilidad. WCAG 2.2 ofrece criterios verificables para contenido web, entre ellos contraste mínimo de texto, ampliación hasta 200% y blancos de interacción mínimos bajo condiciones definidas. Es una norma de referencia para la versión web; no equivale a una auditoría completa de accesibilidad nativa ni acredita facilidad para una población concreta. [W3C, WCAG 2.2](https://www.w3.org/TR/WCAG22/).

### Dirección visual propuesta

Se recomienda probar una identidad **orgánica, editorial y de baja presión**: una paleta cálida de base, formas dibujadas o curvas propias como acento, tipografía legible de sistema, y suficiente espacio para que el contenido respire. La composición puede sugerir que se abre un pequeño intervalo en la jornada, en vez de mostrar una cuadrícula de indicadores, un calendario de cumplimiento o un panel con objetivos. La ilustración puede dar carácter, pero no debe competir con la instrucción ni esconder controles.

Esta dirección se diferencia por el tratamiento narrativo y la composición, no por afirmar una categoría visual inédita. Opal puede estudiarse como referente de jerarquía y personalidad de marca; no se copiarán su paleta, iconografía, estructura de producto, lenguaje ni recursos distintivos. La referencia es un punto de comparación, no evidencia de superioridad. El ensayo de dos variantes ya propuesto en la investigación de interfaz debe conservar iguales contenidos, controles y disposición para comparar únicamente tratamiento visual.

**Aplicación al flujo actual:**

1. Inicio: un mensaje breve que ubique la pausa en relación con la jornada y una acción principal. Preferencias en segundo plano.
2. Propuesta: explicación concreta y controles visibles para iniciar, cambiar, posponer o rechazar.
3. Guía: instrucciones cortas, texto ampliable, posibilidad de apartar la mirada y detenerse en cualquier momento.
4. Cierre: distinguir guía terminada de guía detenida, sin afirmar que se verificó movimiento ni felicitar por una conducta que el sistema no observó.

No añadir navegación persistente, estadísticas, rachas o preguntas previas a menos que resuelvan una necesidad observada. «Orgánico» describe una dirección de arte para probar; no significa automáticamente accesible, calmante o terapéutico.

**Iteración aplicada al prototipo, 23-10-2026:** se reemplazó el símbolo de spa y la tarjeta blanca uniforme por un trazo dibujado que se interrumpe y continúa, una superficie cálida con esquinas asimétricas y una paleta verde musgo/terracota. Se conservaron los nombres y la jerarquía de las acciones existentes. Los contrastes calculados para pares de color usados en texto son: tinta/fondo 12,26:1; texto secundario/fondo 6,59:1; musgo/fondo 7,05:1; blanco/botón musgo 7,67:1; terracota/fondo 5,99:1. Se calcularon con la fórmula sRGB relativa de WCAG; no constituyen una auditoría de accesibilidad. El análisis estático de Flutter no encontró incidencias. Aún falta inspeccionar la nueva composición con ampliación, teclado y lector de pantalla, y obtener opinión de usuarios.

### Prueba de experiencia sugerida

En sesiones breves y voluntarias con escenarios sintéticos, observar si la persona identifica la acción principal, explica con sus palabras la propuesta, encuentra cómo cambiar/rechazar/detener, y logra cerrar el recorrido con teclado o pantalla táctil según destino. Preguntar si percibió presión, distracción o carga de lectura; no interpretar agrado estético como cambio de conducta. Registrar dispositivo, ampliación de texto y tecnología de asistencia utilizada cuando corresponda, sin recopilar datos de salud innecesarios.

## Makana: observación y fuentes públicas

El sitio oficial de Makana presenta dimensiones de salud mental, nutrición, bienestar físico y financiero, bienestar social, beneficios y espacios/atención en terreno. También explica que los módulos pueden contratarse por separado y que el precio se define según alcance y necesidades organizacionales. [Sitio oficial de Makana](https://www.makana.cl/).

Los términos públicos distinguen contratación empresarial B2B —que financia o habilita el acceso de usuarios— de la contratación individual B2C. El texto contempla suscripciones individuales y contratación por organizaciones; por tanto, la observación del equipo de que ciertas funciones aparecieron detrás de un pago no permite concluir que «todo Makana es de pago» para todos los usuarios. La disponibilidad depende de país, sistema, configuración y modalidad de acceso. [Términos de Makana, apartados 1.2, 1.5 y 22](https://www.makana.cl/terminos).

La ficha de Google Play describe una plataforma integral que conecta bienestar mental, físico, nutricional y financiero. Los datos de seguridad de la ficha son declaraciones del desarrollador sujetas a cambios, no una auditoría independiente. [Makana en Google Play](https://play.google.com/store/apps/details?id=cl.makana.mobile).

**Lectura estratégica:** una propuesta enfocada puede ser más fácil de explicar y evaluar que una plataforma que cubre varios ámbitos, siempre que el problema elegido sea importante para un segmento identificable y el flujo demuestre valor. Esta es una hipótesis comercial, no un hallazgo comparativo sobre las aplicaciones. Ante el jurado, describir nikucode como una respuesta focalizada al caso que el equipo vive; evitar llamar «genérica» a Makana o asumir por su catálogo que resuelve mal las necesidades de sus usuarios. Makana es el organizador y jurado de producto: la crítica debe ser respetuosa, específica y respaldada por lo observado.

## Acceso, sostenibilidad e incentivos

Un estudio transversal de disposición a pagar por aplicaciones de salud en Hong Kong informó que 41,1% de su muestra declaró no estar dispuesto a pagar; entre las razones se incluyeron preferencia por opciones gratuitas, desconfianza y percepción de poco beneficio. Los autores sugieren versiones gratuitas y opciones escalonadas como posibles vías de acceso. El muestreo, el país, el tipo de aplicaciones y las respuestas hipotéticas limitan su transferencia directa a Chile y a este producto; no demuestra que un modelo freemium sea rentable. [Liu et al., *Digital Health*, 2024](https://doi.org/10.1177/20552076241248925).

### Propuesta de producto por etapas

| Etapa | Propuesta | Condición para avanzar |
|---|---|---|
| Prototipo/hackatón | Recorrido esencial gratuito, sin cuenta, sin anuncios y sin bloquear funciones por tiempo. No incluir cobros en la demo. | Probar comprensión, control, recorrido y funcionamiento en los destinos disponibles. |
| Piloto | Mantener una modalidad gratuita suficiente para probar el propósito central. Explorar si las personas u organizaciones necesitan contenidos opcionales, administración o sincronización. | Entrevistas diferenciadas a personas usuarias y compradores; especificar quién paga, qué problema compra y qué datos necesita. |
| Producto escalable | Evaluar un plan individual opcional y/o contratación organizacional modular. La cuenta sería optativa y justificaría funciones como sincronización o respaldo; el flujo central debería seguir disponible sin identidad cuando sea viable. | Validar disposición a pagar, costos de soporte/infraestructura, privacidad, interoperabilidad y límites de acceso organizacional. No vender métricas individuales de pausas a empleadores por defecto. |

El inicio de sesión no es, por sí solo, un modelo de negocio ni una necesidad de analítica. En el MVP no se requiere: una cuenta se justificaría si usuarios necesitan continuidad entre dispositivos, respaldo o un beneficio empresarial que no pueda resolverse de modo menos intrusivo. La analítica de producto y el historial personal son funciones distintas. Cualquier medición futura debe distinguir eventos de software —aviso mostrado, guía iniciada— de actividad corporal y usar minimización, propósito explícito y controles de privacidad.

### Incentivos gratuitos

Un día de acceso gratuito podría servir como mecanismo promocional o de prueba, pero no se encontró evidencia específica que establezca que entregarlo aleatoriamente mejorará uso sostenido, equidad o ingresos en una app de pausas. Si se prueba, preferir condiciones transparentes: alcance exacto, duración visible, elegibilidad clara y ninguna renovación o pérdida de información no anunciada. Evitar asociar acceso a registros de movimiento, rachas, datos de salud, presión de pares o aprobación laboral.

Para este caso, la recomendación inicial es que la función central no expire. Un pase gratuito podría probarse como acceso a contenido ampliado o una función adicional, distribuido con reglas simples y también disponible por vías previsibles. Así se estudia conversión sin hacer que la capacidad básica de pausar dependa del azar. La hipótesis requiere investigación con personas usuarias y evaluación comercial antes de convertirse en decisión.

## Decisiones para el proyecto actual

1. **Conservar el recorte:** el MVP sigue siendo una invitación controlable, una propuesta modificable y una guía que se puede detener; no incorporar cuentas o pagos por la discusión comercial.
2. **Iterar la interfaz:** explorar la dirección orgánica/editorial en un prototipo visual y comparar con el aspecto actual usando tareas equivalentes.
3. **Describir la diferencia con precisión:** foco en iniciar una pausa viable durante estudio/trabajo, con control, sin indicadores de salud ni seguimiento obligatorio.
4. **Tratar expansión comercial como hipótesis:** free-first, cuenta opcional por necesidad demostrada y B2B modular sujeto a entrevistas; no afirmar rentabilidad.
5. **No usar incentivos aleatorios como mecanismo central:** si hay pase promocional, hacerlo transparente y mantener gratis el flujo esencial.

## Referencias consultadas

- Wei, Y. et al. (2020). “Design Features for Improving Mobile Health Intervention User Engagement: Systematic Review and Thematic Analysis.” *Journal of Medical Internet Research*, 22(12), e21687. [https://doi.org/10.2196/21687](https://doi.org/10.2196/21687).
- Johnson, D. et al. (2016). “Gamification for health and wellbeing: A systematic review of the literature.” *Internet Interventions*, 6, 89–106. [https://doi.org/10.1016/j.invent.2016.10.002](https://doi.org/10.1016/j.invent.2016.10.002).
- Liu, C. et al. (2024). “Willingness to pay for health apps, its sociodemographic correlates, and reasons for being unwilling to pay.” *Digital Health*. [https://doi.org/10.1177/20552076241248925](https://doi.org/10.1177/20552076241248925).
- World Wide Web Consortium. (2024). *Web Content Accessibility Guidelines (WCAG) 2.2*. [https://www.w3.org/TR/WCAG22/](https://www.w3.org/TR/WCAG22/).
- Makana. Sitio oficial, información de módulos y contratación. Consulta: 23-10-2026. [https://www.makana.cl/](https://www.makana.cl/).
- Makana. Términos y condiciones de uso y política de privacidad, versión publicada el 21-07-2026. [https://www.makana.cl/terminos](https://www.makana.cl/terminos).
- Makana. Ficha de Google Play, consulta: 23-10-2026. [https://play.google.com/store/apps/details?id=cl.makana.mobile](https://play.google.com/store/apps/details?id=cl.makana.mobile).
