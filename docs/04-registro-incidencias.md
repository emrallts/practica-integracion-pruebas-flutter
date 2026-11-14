# 04 — Registro y seguimiento de incidencias

Se incluyen tres **hallazgos de revisión preventiva del código del paquete**, con su corrección
versionada en Git. **No se afirma que fueran fallas observadas ejecutando la app.**
Para la entrega definitiva, el estudiante debe reproducir/verificar al menos tres incidencias
reales en su entorno, documentar pasos, capturas y resultado de regresión.

| ID | Origen / método | Severidad | Prioridad | Causa detectada en revisión | Corrección aplicada | Estado verificado |
|---|---|---|---|---|---|---|
| INC-001 | Validación (revisión de código) | Media | Alta | Títulos de 1 o 2 caracteres no debían guardarse | Validador longitud mínima de 3 y caso unitario | Código corregido; ejecución de regresión pendiente |
| INC-002 | Estado y suscripción (revisión de código) | Media | Alta | Posibilidad de recrear stream de tareas durante build | Suscripción creada en initState y al cambiar dependencias | Código corregido; ejecución de regresión pendiente |
| INC-003 | Seguridad (revisión de reglas) | Alta | Alta | Escritura por usuarios ajenos si las reglas son abiertas | Reglas de Firestore restringen por uid | Reglas redactadas; publicación y prueba negativa pendientes |

## Método de depuración de 5 pasos (aplicable a cada incidencia)

1. **Reproducir:** registrar pasos y datos necesarios (pendiente en entorno Firebase real).
2. **Leer:** analizar consola, stack trace, reglas o código pertinente.
3. **Hipótesis:** identificar el motivo probable indicado en la tabla.
4. **Comprobar:** verificar el comportamiento antes y después del cambio.
5. **Corregir y proteger:** commit de corrección + prueba de regresión + evidencia.

### Trazabilidad para completar

- INC-001: `git log --oneline --all --grep=INC-001`; prueba `test/unit/validators_test.dart`.
- INC-002: `git log --oneline --all --grep=INC-002`; prueba de widget de lista.
- INC-003: `git log --oneline --all --grep=INC-003`; CP-11 requiere una cuenta de prueba diferente.

**Prueba de regresión real:** pendiente de ejecutar `flutter test` y CP-11. Al ejecutar,
registrar fecha, comando, salida, dispositivos, estados y capturas sin datos personales.
