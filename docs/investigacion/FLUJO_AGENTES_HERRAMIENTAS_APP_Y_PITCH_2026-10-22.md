# Agentes, herramientas y coordinación para app y pitch

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


Fecha: 22-10-2026. Preparación de flujo de trabajo; no código competitivo ni promesa de clasificación en el concurso.

## 1. Recomendación

Trabajar con **un agente principal que integre decisiones y hasta dos subagentes simultáneos con encargos acotados**. Los roles rotan según el bloque: no mantener todos activos ni pedir a varios que construyan toda la app por separado. Es una recomendación operativa para este equipo, no un óptimo demostrado.

Alex y Javi conservan la decisión sobre problema, alcance, experiencia y presentación. El principal mantiene coherencia entre investigación, computador/celular, implementación y afirmaciones del pitch. Los subagentes entregan hallazgos o cambios verificables, con responsables y límites de archivos.

El objetivo competitivo es mejorar lo controlable: ajuste al problema, funcionamiento, claridad de la explicación y credibilidad de la evidencia. Más agentes, más código o más citas no garantizan el primer lugar.

## 2. Diferencias útiles

- **Agente principal:** lleva el estado del encargo e integra lo producido.
- **Subagente:** recibe una tarea delimitada y devuelve un resultado; no es automáticamente un experto validado ni un segundo usuario independiente.
- **Skill:** instrucciones reutilizables para un procedimiento. Prepararla no equivale a entrenar los pesos de un modelo.
- **MCP/herramienta:** acceso a acciones o información, como inspeccionar errores de una app. Tener su nombre disponible no acredita conexión ni ejecución correcta.
- **Worktree:** otro directorio de trabajo de Git; sirve si hay edición paralela realmente separable. No sustituye integrar ni probar.

La documentación oficial recomienda empezar por trabajo paralelo de lectura y tener más cuidado con escrituras concurrentes; también advierte que los subagentes consumen tokens adicionales. Las definiciones personalizadas y el límite de concurrencia se pueden configurar. [OpenAI Docs: subagentes](https://learn.chatgpt.com/docs/agent-configuration/subagents).

## 3. Estado local verificado

Comprobaciones realizadas sin autenticación nueva, llamadas de prueba al modelo, instalación ni cambios de configuración:

| Elemento | Observado | Qué falta comprobar |
|---|---|---|
| Codex CLI | Ejecutable en PATH; versión 0.163.0 | Compatibilidad de cada flujo en una sesión real del evento |
| Perfil separado | `~/.codex-evento/`, guía y lanzador existentes | Cuenta y cuota reales; no se inspeccionaron credenciales |
| Configuración del perfil | `agents.enabled=true`; límite de dos subagentes; razonamiento medium sin modelo fijado; sandbox predeterminado read-only | Invocación efectiva de agentes; modelo disponible con esa cuenta |
| Lanzador | `revisar` solicita read-only; `iniciar` solicita workspace-write; usa el perfil separado | Políticas efectivas del entorno al abrir el proyecto; opciones locales no eliminan restricciones superiores |
| Prueba de configuración | `codex-evento comprobar` terminó con código 0 al listar features | No prueba login, cuota, llamadas al modelo, compilación ni GUI |
| Roles | Cinco TOML existentes: repo_mapper, quality_reviewer, evidence_auditor, test_writer, docs_updater | Su utilidad y comportamiento en tareas reales |
| Herramientas instaladas | Flutter, Dart, Git, adb, Chromium y LibreOffice encontrados en PATH | Versiones/compatibilidad, dispositivo conectado y funcionamiento; no se recompiló nada |
| Plugins/MCP | El perfil de evento desactiva plugins/apps y no declara MCP. Esta sesión sí expone herramientas Dart MCP | Conexión con una app en ejecución; equivalencia entre sesiones/perfiles no comprobada |

La documentación define el límite de concurrencia de subagentes excluyendo al principal. Esta sesión permite hasta cuatro agentes en total; la recomendación propia sigue siendo usar como máximo dos subagentes a la vez. [Configuración de subagentes](https://learn.chatgpt.com/docs/agent-configuration/subagents).

**Consecuencia:** no abrir otro perfil suponiendo que llevará todos los plugins y herramientas de esta sesión. Mantener el entorno que funcione y comprobar únicamente capacidades necesarias. No instalar un orquestador adicional ni cambiar de cuenta/modelo por defecto.

## 4. Asignación por etapa

| Bloque | Principal | Subagente A | Subagente B | Resultado que permite avanzar |
|---|---|---|---|---|
| Acotar propuesta | Integra persona, barrera, conducta y alcance | evidence_auditor: contrasta pocas afirmaciones decisivas | Revisor de propuesta: busca explicaciones rivales y carga añadida | MVP con mecanismo y límites explícitos |
| Primer recorrido, tras bienvenida | Posee integración, contratos y configuración compartida | worker: una parte con archivos asignados, si es separable | quality_reviewer: revisión de un cambio ya disponible | Un recorrido ejecutable y revisado |
| Construcción incremental | Mantiene estado común y compatibilidad de destinos | worker: siguiente cambio acotado | test_writer: pruebas del comportamiento acordado, en archivos distintos | Cambio comprobado e integrado |
| Depurar un fallo | Formula reproducción y conserva el estado funcional | repo_mapper: rastrea el camino responsable | quality_reviewer: contrasta fallo y regresiones, sin editar | Diagnóstico con evidencia antes de arreglar |
| Pitch | Integra narración, demo y lo efectivamente implementado | evidence_auditor: revisa afirmaciones y límites | Revisor en papel de jurado: objeciones concretas | Guion consistente con producto y fuentes |
| Cierre | Congela alcance y verifica entrega | quality_reviewer: último cambio/riesgos pendientes | docs_updater: README y guía de demo según estado final | Entrega, demo y pitch cuentan lo mismo |

«Revisor de propuesta» y «papel de jurado» son encargos que pueden recibir agentes existentes; no requieren crear nuevos perfiles. No se les atribuye representar opiniones reales del jurado. El mismo modelo en dos roles puede repetir supuestos: pedir contraejemplos y pruebas, no votos ni elogios.

No delegar pruebas de código inexistente ni revisar un diff que aún no llegó. Empezar en secuencia cuando las dependencias lo exijan; paralelizar una vez que los contratos y archivos sean independientes.

## 5. Cómo evitar que el paralelismo rompa el proyecto

Cada encargo declara objetivo, información de entrada, archivos que puede editar, archivos excluidos, criterio de cierre y comprobación autorizada. El worker sabe que comparte el proyecto, no revierte cambios ajenos y comunica conflictos. Un solo responsable por archivo durante cada bloque.

Si se elige Flutter, el principal o integrador posee `pubspec.yaml`, lockfile, entrada de app, navegación y estado compartido. No repartir automáticamente «uno hace celular y otro computador» si ambos van a editar los mismos widgets y modelo. Una división más segura podría ser lógica de estados frente a presentación adaptable, después de acordar sus interfaces. Es condicional al stack aún por decidir.

Usar worktrees separados cuando dos tareas de implementación realmente independientes justifiquen la integración adicional. Un revisor solo lectura puede inspeccionar el mismo checkout estable. Los worktrees requieren Git y tienen ramas/directorios propios; se crearían en el repositorio del evento cuando corresponda. [OpenAI Docs: worktrees](https://learn.chatgpt.com/docs/environments/git-worktrees).

Antes de integrar un cambio: inspeccionar diff, ejecutar las comprobaciones pertinentes y verificar el recorrido afectado. No confundir una respuesta «listo» del agente con build o comportamiento observados.

## 6. Herramientas que aportan y cuándo

- **Git:** cambios pequeños y una versión funcional identificable. Las ramas/worktrees sirven a tareas concretas; no son un entregable por sí mismos.
- **Terminal y herramientas del stack:** análisis, pruebas y builds. Si se elige Flutter, utilizar las skills Dart/Flutter ya disponibles cuando correspondan, sin convertirlas en requisito previo a definir el producto.
- **Dart MCP:** si se elige Flutter y la conexión funciona, inspección de errores y app en ejecución. Probar un recorrido real antes de depender de esa integración para la demo; si no está conectada, usar herramientas estándar que sí funcionen.
- **Navegador/Chromium:** comprobar el destino web si se elige. Una app responsive en navegador no acredita por sí sola notificaciones nativas o funcionamiento de escritorio/móvil en segundo plano.
- **Dispositivo real y herramientas de accesibilidad:** comprobar texto ampliado, lectura asistida, controles y avisos en los destinos elegidos. La presencia de adb no prueba que haya teléfono conectado.
- **Fuentes primarias y auditor:** resolver preguntas puntuales que cambien decisiones. Evitar reabrir toda la biblioteca.
- **LibreOffice u otra herramienta de presentación disponible:** producir una presentación editable y una copia estable de respaldo; verificar manualmente legibilidad, medios y transiciones en el computador de presentación. LibreOffice está en PATH; no se generó ni comprobó una presentación aquí.

No añadir backend, sincronización, agentes dentro de la app o una API de IA solo porque estamos usando agentes para desarrollarla. Son decisiones diferentes. Los agentes de trabajo no son una función obligatoria del producto.

## 7. Contexto pequeño y durable

Usar `00_HANDOFF.md` como entrada y remitir a informes concretos según el encargo. No entregar a todos los subagentes la exportación completa de varios MB. Cada uno necesita la pregunta, los archivos pertinentes y las restricciones actuales, no toda la historia.

En el proyecto, un `AGENTS.md` breve puede fijar destino computador/celular, comandos realmente comprobados, responsabilidad de archivos, datos sintéticos y criterios de aceptación. La documentación oficial confirma que Codex carga estas instrucciones al trabajar. [OpenAI Docs: AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

Mantener un resumen de estado con decisión actual, cambio funcional más reciente, comprobaciones ejecutadas, fallos pendientes y siguiente tarea. Guardar la evidencia extensa en sus archivos. No crear otra matriz si un documento existente ya cumple esa función.

## 8. Encargos listos para adaptar

### Auditar el mecanismo antes de construir

> Usa dos subagentes en paralelo. evidence_auditor revisará las afirmaciones decisivas del MVP usando el informe conductual y las fuentes asignadas. El segundo buscará por qué la propuesta podría no ayudar a la persona descrita: falta de oportunidad, carga, redundancia y retorno. Ambos solo lectura; sin instalar, editar, probar software ni investigar todo de nuevo. Espera a ambos y entrega discrepancias, evidencia y una recomendación provisional. No decidan por popularidad de competidores ni usen los agregados en cuarentena.

### Implementar una parte durante el evento

> Implementa [conducta acordada]. El principal posee integración y configuración compartida. Delega a worker solo [archivos], con responsabilidad exclusiva; comparte el proyecto con otros y no debe revertir sus cambios. El revisor inspeccionará el diff terminado sin editar. Cierre: [recorrido observable] funciona en [destinos] y se registran comandos/resultados reales. No amplíes funciones ni dependencias sin necesidad del encargo. Integra y revisa antes de seguir.

### Revisar pitch y demo

> Usa dos subagentes solo lectura. Uno audita cada afirmación científica o de eficacia del guion contra las fuentes y el producto real. Otro actúa como revisor crítico ante «¿con cuál de estas soluciones sí cambiaría esta persona?»: identifica el eslabón más débil y formula cinco preguntas difíciles. No inventen feedback de usuarios, criterios oficiales ni resultados. Espera a ambos y devuelve una narración revisada, objeciones pendientes y qué debe mostrar la demo.

Los prompts son plantillas de trabajo, no tareas ejecutadas en esta revisión. No se lanzaron subagentes para responder esta consulta ni se validó su invocación real.

## 9. Reparto humano y presentación

Propuesta para acordar entre Alex y Javi: una persona integra y comprueba el recorrido; la otra contrasta la experiencia, prepara narrativa y ensaya. Rotar según fortalezas y bloque. Ambos deben poder explicar problema, mecanismo, limitaciones y operación de la app, aunque el código o las diapositivas hayan sido asistidos.

Construir el pitch en paralelo una vez que exista una propuesta acotada, y actualizarlo conforme cambie la implementación. Ensayar con tiempo medido. Una revisión de IA no sustituye que ustedes expliquen en voz alta por qué esta persona podría cambiar y qué evidencia falta.

Prioridad al cerrar: recorrido estable en computador/celular dentro del alcance declarado, demo reproducible, afirmaciones respaldadas y explicación comprensible. Recortar extras antes de sacrificar pruebas o ensayo. Una captura o vídeo de respaldo se identifica como tal y no reemplaza silenciosamente la demostración en vivo requerida.

## 10. Siguiente acción concreta

Cerrar una ficha breve del MVP: persona/contexto, conducta, barrera, mecanismo, recorrido en cada destino y criterio de comprobación. Con esa ficha, aplicar el primer encargo de revisión; tras terminar la bienvenida, crear el repositorio público vacío según el flujo acordado y construir el primer recorrido completo.

Las configuraciones y roles existentes se mantienen: esta revisión no instala agentes adicionales ni cambia autenticación, modelo o permisos. Marea sigue clasificado como práctica de Flutter de esta investigación; no se reintroduce la clasificación incorrecta de proyecto personal.
