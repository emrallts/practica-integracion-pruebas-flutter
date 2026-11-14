import 'package:flutter/material.dart';
import 'features/auth/auth_gate.dart';
import 'repositories/task_repository.dart';
import 'services/auth_service.dart';

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key, required this.auth, required this.tasks});
  final AuthService auth;
  final TaskRepository tasks;
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TaskFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: AuthGate(auth: auth, tasks: tasks),
      );
}
