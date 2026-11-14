import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.done,
    required this.createdAt,
  });

  final String id;
  final String title;
  final bool done;
  final DateTime createdAt;

  Task copyWith({String? title, bool? done}) => Task(
        id: id,
        title: title ?? this.title,
        done: done ?? this.done,
        createdAt: createdAt,
      );

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final value = doc.data() ?? <String, dynamic>{};
    return Task(
      id: doc.id,
      title: value['title'] as String? ?? '',
      done: value['done'] as bool? ?? false,
      createdAt: (value['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
