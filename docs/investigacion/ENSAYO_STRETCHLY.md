# Omisión: reintento observado

> Material de respaldo importado: su fecha, decisiones y condiciones son históricas. El estado actual y el programa vigente prevalecen; no ejecutar automáticamente sus siguientes pasos ni repetir pruebas. Consultar desde el índice solo cuando una pregunta lo requiera.


Fecha: 22-10-2026. Misma instancia propia PID 39745 y mismo perfil que el intento
no observado. Se rearmó con CLI reset después de la confirmación «listo».
Registros del reintento: `runtime/ensayos/omitir-reintento-01/`.
`sesion.json` conserva el offset del log de aplicación antes del rearmado para
separar este intervalo del intento previo. No se modificó el paquete oficial.

## Omisión respaldada
- Inicio de pausa: 15:42:11.996, hora local.
- Clic de cierre con manualAwaiting=false: 15:42:23.839.
- Fin registrado: 15:42:23.842; unos 11,846 s después del inicio.
- Duración configurada: 20 s. El cierre es anterior a la expiración.
- El operador informa que lo demás salió correctamente.

La combinación respalda omisión manual de esa pausa, no simplemente desaparición
por temporizador. El texto genérico del log «finish button» no debe confundirse
con completar una fase de finalización manual: manualAwaiting=false.

## Obstrucción visual y foco
El operador informa que no pudo escribir porque la ventana tapaba las anteriores.
Esto respalda obstrucción visual y dificultad práctica de seguir trabajando.
En una aclaración posterior, el operador confirma que sí escribió y que no apareció
texto en el editor. **Resultado funcional reportado: la escritura no llegó al
editor durante la pausa en este ensayo.** No se capturaron eventos de teclado ni
el foco del compositor, por lo que no se determina si la causa fue un cambio de
foco, captura de entrada u otra condición del entorno. No atribuir el mecanismo
ni generalizar este resultado a todas las plataformas o configuraciones.

Las opciones no enfocables y showInactive encontradas en el código expresan una
intención de implementación, no garantizan conservación de la escritura en este
entorno. El resultado humano no debe descartarse por esas opciones estáticas.

## Estado posterior
El supervisor solicitó pause a las 15:42:46.536; la app recibió la solicitud.
El proceso seguía activo al revisar. Es una pausa, no salida limpia comprobada.
Cerrar desde la bandeja → Salir antes de abrir otra instancia de prueba.

## Alcance
Se comprobó un único escenario con ajustes de ensayo sobre Hyprland/Wayland.
No demuestra eficacia para pausas físicas, movimiento real, ni comportamiento
uniforme en todas las plataformas. El intento anterior se conserva NO_OBSERVADO.
