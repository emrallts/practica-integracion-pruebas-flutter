import 'package:flutter/material.dart';
import '../../core/error_messages.dart';
import '../../models/task.dart';
import '../../repositories/task_repository.dart';
import '../../services/auth_service.dart';
import '../task/task_editor_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.uid, required this.auth,
    required this.repository});
  final String uid;
  final AuthService auth;
  final TaskRepository repository;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<List<Task>> _tasks;
  @override
  void initState() {
    super.initState();
    _tasks = widget.repository.watchTasks(widget.uid);
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid || oldWidget.repository != widget.repository) {
      _tasks = widget.repository.watchTasks(widget.uid);
    }
  }

  void _openEditor([Task? task]) async {
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => TaskEditorPage(
        uid: widget.uid, repository: widget.repository, task: task,
      ),
    ));
    if (!mounted) return;
    if (saved == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(task == null ? 'Tarea creada' : 'Tarea actualizada')),
      );
    }
  }

  Future<void> _toggle(Task task) async {
    try {
      await widget.repository.updateTask(widget.uid, task.id, done: !task.done);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(messageForError(error))),
      );
    }
  }

  Future<void> _logout() async {
    try {
      await widget.auth.signOut();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(messageForError(error))),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Mis tareas'), actions: [
          IconButton(key: const Key('logout_button'),
            tooltip: 'Cerrar sesión', onPressed: _logout,
            icon: const Icon(Icons.logout)),
        ]),
        body: StreamBuilder<List<Task>>(
          stream: _tasks,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(messageForError(snapshot.error!)),
                const SizedBox(height: 12),
                FilledButton(onPressed: () => setState(() {
                  _tasks = widget.repository.watchTasks(widget.uid);
                }), child: const Text('Reintentar')),
              ]));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return const Center(child: Text('Aún no hay tareas'));
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  key: ValueKey(task.id),
                  leading: Checkbox(key: Key('done_${task.id}'),
                    value: task.done, onChanged: (_) => _toggle(task)),
                  title: Text(task.title),
                  subtitle: Text(task.done ? 'Completada' : 'Pendiente'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openEditor(task),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('add_task_fab'),
          onPressed: () => _openEditor(),
          tooltip: 'Nueva tarea',
          child: const Icon(Icons.add),
        ),
      );
}
