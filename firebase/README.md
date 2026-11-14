# Configuración de Firebase para entorno de pruebas

1. Crear un proyecto de Firebase para **pruebas**.
2. Registrar la aplicación Android con el applicationId generado por `flutter create`.
3. Habilitar **Authentication → Sign-in method → Email/Password**.
4. Habilitar **Cloud Firestore**.
5. Publicar el contenido de `firebase/firestore.rules` en la consola, reemplazando
   las reglas de desarrollo si son más abiertas.
6. En el proyecto Flutter local, ejecutar `flutterfire configure` seleccionando Android.
   Esto genera archivos de configuración locales que **no deben subirse**.
7. Crear un usuario de prueba desde la app y verificar `users/{uid}/tasks`.

⚠️ Firebase Console y el SDK de FlutterFire pueden cambiar los pasos exactos.
No usar credenciales o datos de personas reales en los casos de prueba.
