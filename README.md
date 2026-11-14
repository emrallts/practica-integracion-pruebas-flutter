# TaskFlow — Práctica E4_A1, semana 16

**Técnicas de Calidad de Software (02-2026)** · Flutter + Firebase Auth + Cloud Firestore.

Aplicación de ejemplo de tareas personales: registro, inicio de sesión, lista reactiva,
creación, edición, cambio de estado, eliminación y cierre de sesión.

## Estado real del paquete

✅ Código fuente Dart, pruebas unitarias y de widgets, reglas de Firestore, 5 flujos
críticos, matriz de casos, 3 hallazgos documentados, archivos de evidencias vacíos y
commits de corrección versionados.

⚠️ **No se ejecutaron `flutter test`, `flutter analyze` ni `flutter run`: el entorno donde
se generó el ZIP no dispone de Flutter/Dart ni acceso a Firebase.** No se adjuntan
capturas inventadas ni se marcan pruebas manuales como aprobadas. La práctica **no está
lista para entregar como evidencia verificada** hasta ejecutar y adjuntar las pruebas reales.

## Requisitos

Flutter y Dart instalados, VS Code/Android Studio, dispositivo/emulador Android,
Firebase CLI y FlutterFire CLI, proyecto Firebase de pruebas.

## Configuración (una vez en la computadora del estudiante)

El ZIP incluye los archivos Dart y de documentación, pero no incluye carpetas Android/iOS
generadas por Flutter ni archivos privados de Firebase. Dentro de la raíz:

```bash
flutter create . --project-name practica_integracion_pruebas_flutter --platforms android
flutter pub get
flutterfire configure
flutter analyze
flutter test
flutter run
```

Seleccionar Android al configurar FlutterFire. `flutter create .` genera los
archivos nativos que requieren Firebase; revisar cualquier cambio que introduzca
sobre el código existente. En `lib/main.dart` se usa `Firebase.initializeApp()`;
la inicialización Android requiere la configuración nativa correcta de FlutterFire.

Antes de arrancar, habilitar Email/Password en Authentication, crear Firestore en modo
seguro y publicar `firebase/firestore.rules` (ver `firebase/README.md`).

## Ejecutar pruebas

```bash
flutter test test/unit/validators_test.dart
flutter test test/widget/
flutter test
flutter analyze
```

Después de cada comando, capturar la salida visible en
`docs/evidencias/pruebas-y-analisis/`; si hay fallas, corregir antes de presentar.

## Organización

- `lib/`: modelos, validadores, repositorios y pantallas Flutter.
- `test/unit/`: prueba de lógica pura.
- `test/widget/`: pruebas con repositorios y autenticación fake.
- `integration_test/`: justificación de E2E opcional no automatizada.
- `firebase/`: reglas restrictivas y guía de configuración.
- `docs/`: declaración de alcance, 5 flujos, plan de 16 casos, incidencias,
  reflexión, registro de ejecución y carpetas de evidencias.
- `.git/`: rama local `semana16-integracion` con commits de revisión y corrección.

## Plan de revisión de la entrega

1. Realizar la configuración local y comprobar arranque con Firebase real.
2. Ejecutar ≥10 casos de `docs/03-plantilla-pruebas.md`, incluyendo negativo,
   y anotar **resultados realmente observados** y capturas.
3. Ejecutar y capturar `flutter test` y `flutter analyze`; resolver errores.
4. Publicar reglas y verificar prueba de aislamiento entre usuarios (CP-11).
5. Documentar ≥3 incidencias **reales**, sus pasos, causa, cambios, regresión y
   commit; pueden vincularse a los hallazgos sugeridos si se reproducen.
6. Reescribir la reflexión de 5–8 líneas con las observaciones reales.
7. Crear o abrir el repositorio público `practica-integracion-pruebas-flutter`,
   conservar la rama `semana16-integracion`, subir cambios y compartir URL.

## Git

```bash
git branch --show-current
git log --oneline --all --decorate
git status
```

Si el repositorio en GitHub está vacío, conectar el remoto antes del primer push:

```bash
git remote add origin https://github.com/USUARIO/practica-integracion-pruebas-flutter.git
git push -u origin semana16-integracion
```

Sustituir `USUARIO` por la cuenta propia. **No** versionar contraseñas,
tokens privados ni datos personales.

## Alcance

Firebase Auth + Firestore sí aplican; Storage, FCM, API REST externa y otros servicios
no aplican, con justificación en `docs/01-declaracion-alcance.md`.
