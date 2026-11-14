# 03 — Casos y resultados de pruebas

**Instrucción importante:** no se han ejecutado casos de app/emulador en el entorno de generación.
El estado **Pendiente de ejecutar** es deliberado y debe reemplazarse por resultados observados,
fechas, dispositivo, capturas y enlaces. No constituye evidencia aprobada.

| ID | Módulo | Acción | Datos | Esperado | Flujo | Estado | Resultado obtenido / evidencia |
|---|---|---|---|---|---|---|---|
| CP-01 | Arranque | Abrir aplicación | Firebase configurado | Inicia sin excepción | FC-01 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-02 | Autenticación | Login válido | demo@example.com / clave de prueba | Abre lista personal | FC-01 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-03 | Autenticación | Login inválido | demo@example.com / incorrecta | Mensaje y permanece en login | FC-01 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-04 | Validación | Crear con título vacío | "" | Mensaje de campo obligatorio, sin escritura | FC-02 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-05 | Navegación | Abrir editor | Tocar una tarea | Abre edición con título precargado | FC-03 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-06 | Navegación | Volver del editor | Botón Atrás | Regresa a la lista | FC-03 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-07 | Datos | Crear tarea | "Preparar examen" | Nueva tarea visible en lista y Firestore | FC-02 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-08 | Datos | Leer lista | 2 tareas en Firestore | Ambas aparecen, orden descendente por creación | FC-02 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-09 | Datos | Actualizar título | "Preparar parcial" | Nueva descripción visible y persistida | FC-03 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-10 | Datos | Eliminar tarea | Tarea de prueba | Desaparece de lista y Firestore | FC-04 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-11 | Seguridad | Acceso a tareas de otro usuario | UID ajeno | Regla bloquea lectura y escritura | FC-05 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-12 | Estados | Lista vacía | Usuario sin tareas | Muestra "Aún no hay tareas" | FC-02 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-13 | Datos | Marcar completada | Casilla de tarea pendiente | Estado completada en UI y Firestore | FC-04 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-18 | Sesión | Cerrar sesión | Botón salir | Vuelve a login | FC-05 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-19 | Persistencia | Reabrir app | Cerrar y abrir | Mantiene sesión/datos según Auth | FC-01 | Pendiente de ejecutar | Pendiente de observar y capturar |
| CP-20 | Flujo completo | Login → crear → editar → salir | Usuario demo | Flujo completo sin errores | FC-01 a FC-05 | Pendiente de ejecutar | Pendiente de observar y capturar |

## No aplican

| ID | Razón |
|---|---|
| CP-14 a CP-17 | FCM no declarado en el alcance |
| CP-13 del enunciado original (Storage) | Storage no declarado; nuestro CP-13 es completar tarea |

**Nota de correspondencia:** se conserva la numeración original en la mayoría de casos;
el CP-13 local verifica completar tareas, no Storage. CP-14–17 corresponden a FCM.

## Criterio de aprobación

Resultado observado igual al esperado, sin excepciones no controladas, evidencia vinculada,
y repetición exitosa tras reiniciar. Registrar cada falla en `04-registro-incidencias.md`.

**Mínimo exigido:** ejecutar al menos 10 casos, con negativos y un caso por flujo crítico;
lograr ≥80 % de aprobación final en flujos críticos.
