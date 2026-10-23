# Compartir investigación durante el evento

Situación comunicada el 23-10-2026: Alex y Javi ya están en la hackatón; checkpoint 1 a las 12:00. Recomendación adaptada a esa etapa: **un único repositorio del equipo y documentación revisada dentro de `docs/`**. El repo competitivo debe cumplir la creación pública/nueva y el inicio de desarrollo tras bienvenida. El programa aportado confirma la fase «A construir» desde 09:45: bienvenida terminada. Cuenta/URL del repo aún no constan en esta sesión.

## Decisión práctica

El repo compartido es el espacio común de archivos; las sesiones siguen teniendo su propio historial. Cada agente necesita sincronización y lectura explícita de cambios para conocer el trabajo del otro. No hace falta montar un servidor MCP, memoria vectorial o puente de conversaciones para este evento.

**Es el mismo repo público que se entrega al jurado.** Código, README breve y `docs/` conviven allí. Cada integrante accede con su propia cuenta y aporta cambios con autoría real; pegar su URL en la plataforma es parte de la entrega. Programa y reglas actualizados en [programa vigente](PROGRAMA_VIGENTE_2026-10-23.md).

La recomendación previa de un repo privado solo de investigación era una opción de preparación. Ahora un solo repo competitivo simplifica integración y evita mantener dos fuentes paralelas. La investigación que se incorpore al público debe estar seleccionada y revisada; conversaciones, credenciales, identificadores y notas personales permanecen fuera. El paquete para Javi es un snapshot inicial útil, no la fuente viva una vez adoptado el repo.

## Archivos mínimos del espacio común

| Archivo propuesto | Función | Quién escribe |
|---|---|---|
| `AGENTS.md` en la raíz | Ordena leer estado antes de trabajar; fija límites y coordinación | Integrador |
| `docs/ESTADO_COMPARTIDO.md` | Estado real, tarea activa por persona, decisiones vigentes y siguiente paso | Integrador acordado |
| `docs/MATRIZ_EVIDENCIA_Y_VALIDACION.md` | Afirmación, fuente, alcance y decisión; reutilizar la matriz preparada | Integrador tras revisar aportes |
| `docs/APORTES_ALEX.md` | Hallazgos nuevos de Alex, con fuentes/límites y propuestas | Alex y su agente |
| `docs/APORTES_JAVI.md` | Hallazgos nuevos de Javi | Javi y su agente |
| Guía y documentos pertinentes | Investigación y especificación ya preparadas, referidas desde estado | Responsable asignado por bloque |

No crear otra matriz o segundo tablero de decisiones por cada sesión. La estructura se adapta al repo real sin reemplazar instrucciones o documentación que ya tenga. Los archivos mínimos de arranque ya están preparados en el paquete portátil; al incorporarlos revisar nombres, enlaces y el estado real del evento.

El `AGENTS.md` del repo competitivo debe permitir implementación del evento y referir a sus comprobaciones. No copiar sin adaptar las restricciones de «solo investigación» del paquete antiguo ni publicar el AGENTS personal/global del usuario. El paquete es un insumo seleccionado, no un repo con historia para presentar.

## Ciclo de un bloque de trabajo

1. Sincronizar el repo conservando cambios locales; leer estado y aportes recientes. Si hay conflictos, resolverlos con el integrador, sin reset/clean/force push para borrarlos.
2. Acordar una tarea concreta y su dueño/archivos. Cada persona usa su rama si trabaja en paralelo. No asignar el mismo archivo a dos agentes simultáneos.
3. Investigar o implementar la tarea. Para nueva evidencia registrar: pregunta, fuente/fecha, resultado, límite, implicación propuesta y siguiente paso. Distinguir lo probado de lo inferido.
4. Terminar un cambio pequeño revisable, comprobarlo según su alcance y publicarlo en la rama acordada. No subir conversaciones completas ni usar `git add .` sin revisar el contenido.
5. El integrador revisa/integra y actualiza estado/matriz. Ambos sincronizan y piden releer cambios antes del siguiente bloque dependiente.

Los archivos en otra rama no aparecen en la copia actual hasta integrar/sincronizar. Publicar un cambio tampoco refresca por sí solo la memoria del agente que ya estaba trabajando. Si ambos están en el mismo computador, trabajar en la misma carpeta comparte archivos inmediatamente, pero sigue requiriendo coordinación de escritores y nueva lectura.

## Instrucción corta para ambas herramientas

> Antes de empezar, lee AGENTS.md, el estado compartido y los aportes recientes del otro integrante. Comprueba rama, cambios locales y sincronización. Trabaja solo en tu tarea y archivos asignados; no reviertas cambios ajenos. Aprovecha investigación y pruebas existentes. Al cerrar registra fuentes/resultados, límites, decisión propuesta y siguiente paso en tu archivo de aportes. El integrador actualiza los documentos comunes. No supongas conocer conversaciones externas ni que una hipótesis sea una decisión aceptada.

## Referencias y límites

Las instrucciones de proyecto están documentadas por [Codex](https://learn.chatgpt.com/docs/agent-configuration/agents-md) y [OpenCode](https://opencode.ai/docs/rules/). El flujo Git y reparto aquí propuestos son una decisión de organización para dos personas, no una optimización medida ni sincronización ya configurada. Esta sesión no ha creado repo remoto, invitado colaboradores, instalado integraciones ni compartido memorias entre cuentas.
