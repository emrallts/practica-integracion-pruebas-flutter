# 01 — Declaración de alcance

**Proyecto:** TaskFlow — gestor de tareas personales. **Práctica:** E4_A1, semana 16.

| Módulo / servicio | ¿Aplica? | Observación |
|---|---|---|
| Autenticación | Sí | Firebase Authentication por correo/contraseña; login, registro y salida |
| Base de datos | Sí | Cloud Firestore; tareas por usuario y sincronización de lista |
| Almacenamiento | No | La aplicación no maneja archivos |
| Notificaciones push | No | FCM queda fuera de alcance, no hay requerimiento de avisos |
| API REST externa | No | Toda la persistencia está en Firestore |
| Otros servicios Firebase | No | Sin Analytics, Crashlytics ni Remote Config |

**Pantallas:** acceso/registro, lista de tareas, editor de tarea (3 pantallas).

**Precondiciones:** Firebase vinculado al applicationId local, Authentication (correo/contraseña)
habilitado y reglas de `firebase/firestore.rules` publicadas en una base de prueba.

**Limitación del paquete:** se entrega el código y las pruebas, pero la configuración nativa
FlutterFire y las capturas reales requieren ejecutar el proyecto en la máquina del estudiante.
