import 'dart:async';
import 'package:practica_integracion_pruebas_flutter/models/task.dart';
import 'package:practica_integracion_pruebas_flutter/repositories/task_repository.dart';
import 'package:practica_integracion_pruebas_flutter/services/auth_service.dart';

class FakeAuthService implements AuthService {
  FakeAuthService({String? initialUid}) : _uid = initialUid {
    _controller.add(_uid);
  }
  String? _uid;
  final _controller = StreamController<String?>.broadcast();
  @override
  String? get currentUid => _uid;
  @override
  Stream<String?> authState() async* {
    yield _uid;
    yield* _controller.stream;
  }
  @override
  Future<void> signIn(String email, String password) async {
    if (password == 'incorrecta') throw const AuthFailure('Correo o contraseña incorrectos');
    _uid = 'test-user';
    _controller.add(_uid);
  }
  @override
  Future<void> register(String email, String password) => signIn(email, password);
  @override
  Future<void> signOut() async { _uid = null; _controller.add(null); }
  Future<void> dispose() => _controller.close();
}

class FakeTaskRepository implements TaskRepository {
  FakeTaskRepository({List<Task> initial = const []}) : _items = List.of(initial);
  List<Task> _items;
  final _controller = StreamController<List<Task>>.broadcast();
  int createCalls = 0;
  @override
  Stream<List<Task>> watchTasks(String uid) async* {
    yield List.unmodifiable(_items);
    yield* _controller.stream;
  }
  void _emit() => _controller.add(List.unmodifiable(_items));
  @override
  Future<Task?> getTask(String uid, String id) async {
    for (final task in _items) { if (task.id == id) return task; }
    return null;
  }
  @override
  Future<void> createTask(String uid, String title) async {
    createCalls++;
    _items = [..._items, Task(id: 't$createCalls', title: title,
      done: false, createdAt: DateTime(2026))];
    _emit();
  }
  @override
  Future<void> updateTask(String uid, String id, {String? title, bool? done}) async {
    _items = _items.map((task) => task.id == id
      ? task.copyWith(title: title, done: done) : task).toList();
    _emit();
  }
  @override
  Future<void> deleteTask(String uid, String id) async {
    _items = _items.where((task) => task.id != id).toList();
    _emit();
  }
  Future<void> dispose() => _controller.close();
}
