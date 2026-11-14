import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

String messageForError(Object error) {
  if (error is AuthFailure) return error.message;
  if (error is FirebaseException) {
    switch (error.code) {
      case 'permission-denied':
        return 'No tienes permiso para realizar esta acción';
      case 'not-found':
        return 'La tarea ya no existe';
      case 'unavailable':
        return 'No se puede conectar. Revisa tu conexión';
      case 'failed-precondition':
        return 'La consulta requiere configuración de Firestore';
    }
  }
  return 'Ocurrió un error. Intenta de nuevo';
}
