import 'package:flutter/material.dart';
import '../../core/error_messages.dart';
import '../../core/validators.dart';
import '../../models/task.dart';
import '../../repositories/task_repository.dart';

class TaskEditorPage extends StatefulWidget {
  const TaskEditorPage({super.key, required this.uid, required this.repository,
    this.task});
  final String uid;
  final TaskRepository repository;
  final Task? task;
  @override
  State<TaskEditorPage> createState() => _TaskEditorPageState();
}

class _TaskEditorPageState extends State<TaskEditorPage> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _title;
  bool _busy = false;
  String? _error;
  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.task?.title ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_key.currentState!.validate() || _busy) return;
    setState(() { _busy = true; _error = null; });
    try {
      if (widget.task == null) {
        await widget.repository.createTask(widget.uid, _title.text);
      } else if (_title.text.trim() != widget.task!.title) {
        await widget.repository.updateTask(widget.uid, widget.task!.id,
          title: _title.text);
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = messageForError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final task = widget.task;
    if (task == null || _busy) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar tarea'),
        content: const Text('¿Deseas eliminar esta tarea?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() { _busy = true; _error = null; });
    try {
      await widget.repository.deleteTask(widget.uid, task.id);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = messageForError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.task == null ? 'Nueva tarea' : 'Editar tarea')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(key: _key, child: ListView(children: [
            TextFormField(
              key: const Key('task_title_field'),
              controller: _title,
              autofocus: true,
              maxLength: 80,
              validator: validateTaskTitle,
              decoration: const InputDecoration(labelText: 'Título de la tarea'),
            ),
            if (_error != null)
              Text(_error!, key: const Key('save_error'),
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('save_task_button'),
              onPressed: _busy ? null : _save,
              child: _busy
                ? const SizedBox(height: 20, width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Guardar'),
            ),
            if (widget.task != null) ...[
              const SizedBox(height: 10),
              OutlinedButton.icon(
                key: const Key('delete_task_button'),
                onPressed: _busy ? null : _delete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Eliminar tarea'),
              ),
            ],
          ])),
        ),
      );
}
