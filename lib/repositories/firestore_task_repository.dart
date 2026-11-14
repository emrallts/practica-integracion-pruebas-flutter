import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import 'task_repository.dart';

class FirestoreTaskRepository implements TaskRepository {
  FirestoreTaskRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _tasks(String uid) =>
      _db.collection('users').doc(uid).collection('tasks');

  @override
  Stream<List<Task>> watchTasks(String uid) => _tasks(uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(Task.fromDocument).toList());

  @override
  Future<Task?> getTask(String uid, String id) async {
    final doc = await _tasks(uid).doc(id).get();
    return doc.exists ? Task.fromDocument(doc) : null;
  }

  @override
  Future<void> createTask(String uid, String title) => _tasks(uid).add({
        'title': title.trim(),
        'done': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }).then((_) {});

  @override
  Future<void> updateTask(String uid, String id, {String? title, bool? done}) async {
    final changes = <String, dynamic>{};
    if (title != null) changes['title'] = title.trim();
    if (done != null) changes['done'] = done;
    if (changes.isEmpty) return;
    changes['updatedAt'] = FieldValue.serverTimestamp();
    await _tasks(uid).doc(id).update(changes);
  }

  @override
  Future<void> deleteTask(String uid, String id) => _tasks(uid).doc(id).delete();
}
