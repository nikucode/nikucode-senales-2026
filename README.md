# nikucode · Hackatón Señales 2026

## Qué problema decidimos atacar

La dificultad de iniciar pausas breves durante estudio o trabajo prolongado con dispositivos, incluso cuando ya se percibe necesidad de moverse. Atacamos el paso entre seguir con la tarea e iniciar una pausa viable, con la aspiración de no depender de señales tardías como agotamiento o una necesidad externa.

## Por qué ese y no otro

El relato del equipo indica que recordar o registrar una intención puede convertirse en otra obligación. Nuestra hipótesis es que importan también la preparación de la acción, el control del momento y la oportunidad real de parar. Por eso exploramos un recorrido breve en **computador y celular**: propuesta modificable, guía que permite apartar la mirada y opciones para posponer, rechazar o detener.

La investigación informa esta hipótesis; todavía no demuestra que la app cambie conducta. [Fundamento y decisiones](docs/INVESTIGACION_INTEGRAL_Y_DECISIONES_2026-10-23.md).

## Qué dejamos fuera

En el núcleo inicial propuesto: cuentas, sincronización, rachas, bloqueo de otras apps, cámara, sensores e IA. No afirmamos detectar postura, crear hábito, prevenir dolor ni verificar movimiento por terminar una guía. Los avisos dependen de las capacidades comprobadas de cada destino.

## Estado y ejecución

Primera app Flutter en `app/`: recorrido adaptable, propuestas modificables, guía detenible y avisos puntuales por canal. Compilaron Linux debug y web; la comprobación headless pasó con canal simulado. Avisos reales y teléfono físico siguen pendientes.

```sh
cd app
flutter pub get
flutter run -d linux
```

[Otros destinos y límites](app/README.md) · [Capturas y evidencia](docs/PRIMER_RECORRIDO_Y_CHECKPOINT_2026-10-23.md).

- [Estado compartido y siguiente tarea](docs/ESTADO_COMPARTIDO.md).
- [Arranque para Javi](docs/ARRANQUE_JAVI.md) e [índice de toda la documentación](docs/INDICE_DOCUMENTACION.md).
- [Especificación y aceptación](docs/GUIA_IMPLEMENTACION_Y_ACEPTACION_2026-10-23.md).
- [Programa vigente](docs/PROGRAMA_VIGENTE_2026-10-23.md): checkpoints 12:00/17:15; entrega sábado13:00; pitch5+3.

Cada integrante trabaja con su propia cuenta. La investigación escrita se preparó con autorización previa; [procedencia y límites](docs/PROCEDENCIA.md). Se usarán exclusivamente casos sintéticos.
