# Prueba de extremo a extremo (opcional)

La práctica exige al menos una prueba unitaria y una de widget; ambas están en `test/`.
El recorrido real Firebase Auth → Firestore requiere configurar un proyecto de prueba,
crear un usuario y ejecutar los casos manuales CP-01 a CP-12. No se incluyó una
prueba E2E con credenciales embebidas para evitar publicar secretos.

Una prueba de integración automatizada con Firebase Emulator Suite puede añadirse
como ampliación, usando secretos locales no versionados.
