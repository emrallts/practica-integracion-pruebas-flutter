import '../models/task.dart';

abstract class TaskRepository {
  Stream<List<Task>> watchTasks(String uid);
  Future<Task?> getTask(String uid, String id);
  Future<void> createTask(String uid, String title);
  Future<void> updateTask(String uid, String id, {String? title, bool? done});
  Future<void> deleteTask(String uid, String id);
}
