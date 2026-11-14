import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_integracion_pruebas_flutter/features/auth/login_page.dart';
import '../fakes.dart';

void main() {
  testWidgets('login vacío muestra validación', (tester) async {
    final auth = FakeAuthService();
    addTearDown(auth.dispose);
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pump();
    expect(find.text('El correo es obligatorio'), findsOneWidget);
    expect(find.text('La contraseña es obligatoria'), findsOneWidget);
  });

  testWidgets('login inválido muestra error comprensible', (tester) async {
    final auth = FakeAuthService();
    addTearDown(auth.dispose);
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));
    await tester.enterText(find.byKey(const Key('email_field')), 'demo@example.com');
    await tester.enterText(find.byKey(const Key('password_field')), 'incorrecta');
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('login_error')), findsOneWidget);
  });
}
