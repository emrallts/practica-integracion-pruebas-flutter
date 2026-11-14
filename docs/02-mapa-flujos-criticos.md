# 02 — Mapa de flujos críticos

1. **FC-01:** El usuario puede crear su cuenta e iniciar sesión, y llegar a su lista personal.
2. **FC-02:** El usuario puede crear una tarea válida y verla inmediatamente en la lista y Firestore.
3. **FC-03:** El usuario puede abrir una tarea, editar su título y ver el cambio sincronizado.
4. **FC-04:** El usuario puede completar y eliminar tareas y observar la lista actualizada.
5. **FC-05:** El usuario puede cerrar sesión y evitar que la pantalla privada permanezca visible.

**Escenario negativo obligatorio:** título vacío; la pantalla impide guardar y muestra validación.
**Seguridad:** las reglas limitan `users/{uid}/tasks` al usuario autenticado dueño de la ruta.
