import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  String? get currentUid;
  Stream<String?> authState();
  Future<void> signIn(String email, String password);
  Future<void> register(String email, String password);
  Future<void> signOut();
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);
  final String message;
  @override
  String toString() => message;
}

class FirebaseAuthService implements AuthService {
  FirebaseAuthService(this._auth);
  final FirebaseAuth _auth;
  @override
  String? get currentUid => _auth.currentUser?.uid;
  @override
  Stream<String?> authState() => _auth.authStateChanges().map((u) => u?.uid);
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_message(error));
    }
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_message(error));
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  String _message(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
      case 'invalid-email':
        return 'Correo o contraseña incorrectos';
      case 'email-already-in-use':
        return 'Este correo ya está registrado';
      case 'weak-password':
        return 'La contraseña es demasiado débil';
      case 'network-request-failed':
        return 'Sin conexión. Intenta de nuevo';
      default:
        return 'No fue posible completar la operación (${error.code})';
    }
  }
}
