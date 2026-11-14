import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_integracion_pruebas_flutter/app.dart';
import 'package:practica_integracion_pruebas_flutter/models/task.dart';
import '../fakes.dart';

void main() {
  testWidgets('lista vacía muestra estado explicativo', (tester) async {
    final auth = FakeAuthService(initialUid: 'test-user');
    final repo = FakeTaskRepository();
    addTearDown(auth.dispose);
    addTearDown(repo.dispose);
    await tester.pumpWidget(TaskFlowApp(auth: auth, tasks: repo));
    await tester.pumpAndSettle();
    expect(find.text('Aún no hay tareas'), findsOneWidget);
  });

  testWidgets('tareas del fake aparecen en la lista', (tester) async {
    final auth = FakeAuthService(initialUid: 'test-user');
    final repo = FakeTaskRepository(initial: [
      Task(id: 'a', title: 'Preparar examen', done: false,
        createdAt: DateTime(2026)),
    ]);
    addTearDown(auth.dispose);
    addTearDown(repo.dispose);
    await tester.pumpWidget(TaskFlowApp(auth: auth, tasks: repo));
    await tester.pumpAndSettle();
    expect(find.text('Preparar examen'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
  });

  testWidgets('formulario vacío no crea tareas', (tester) async {
    final auth = FakeAuthService(initialUid: 'test-user');
    final repo = FakeTaskRepository();
    addTearDown(auth.dispose);
    addTearDown(repo.dispose);
    await tester.pumpWidget(TaskFlowApp(auth: auth, tasks: repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('add_task_fab')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('save_task_button')));
    await tester.pumpAndSettle();
    expect(find.text('El título es obligatorio'), findsOneWidget);
    expect(repo.createCalls, 0);
  });

  testWidgets('crea tarea y actualiza lista con fake', (tester) async {
    final auth = FakeAuthService(initialUid: 'test-user');
    final repo = FakeTaskRepository();
    addTearDown(auth.dispose);
    addTearDown(repo.dispose);
    await tester.pumpWidget(TaskFlowApp(auth: auth, tasks: repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('add_task_fab')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('task_title_field')), 'Nueva tarea');
    await tester.tap(find.byKey(const Key('save_task_button')));
    await tester.pumpAndSettle();
    expect(find.text('Nueva tarea'), findsOneWidget);
    expect(repo.createCalls, 1);
  });
}
