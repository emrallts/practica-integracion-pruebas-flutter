import 'package:flutter/material.dart';
import '../../repositories/task_repository.dart';
import '../../services/auth_service.dart';
import '../home/home_page.dart';
import 'login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.auth, required this.tasks});
  final AuthService auth;
  final TaskRepository tasks;
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late Stream<String?> _authStream;
  @override
  void initState() {
    super.initState();
    _authStream = widget.auth.authState();
  }

  @override
  void didUpdateWidget(covariant AuthGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.auth != widget.auth) _authStream = widget.auth.authState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<String?>(
        stream: _authStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text('Error de autenticación')));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          final uid = snapshot.data;
          if (uid == null) return LoginPage(auth: widget.auth);
          return HomePage(uid: uid, auth: widget.auth, repository: widget.tasks);
        },
      );
}
