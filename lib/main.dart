import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'repositories/firestore_task_repository.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase debe configurarse antes con `flutterfire configure`.
  await Firebase.initializeApp();
  runApp(TaskFlowApp(
    auth: FirebaseAuthService(FirebaseAuth.instance),
    tasks: FirestoreTaskRepository(FirebaseFirestore.instance),
  ));
}
