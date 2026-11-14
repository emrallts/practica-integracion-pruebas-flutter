import 'package:flutter_test/flutter_test.dart';
import 'package:practica_integracion_pruebas_flutter/core/validators.dart';

void main() {
  group('Validación de tareas', () {
    test('rechaza título vacío y espacios', () {
      expect(validateTaskTitle(''), 'El título es obligatorio');
      expect(validateTaskTitle('  '), 'El título es obligatorio');
    });
    test('rechaza títulos cortos y mayores a 80 caracteres', () {
      expect(validateTaskTitle('ab'), 'Escribe al menos 3 caracteres');
      expect(validateTaskTitle('a' * 81), 'Máximo 80 caracteres');
    });
    test('acepta título válido', () {
      expect(validateTaskTitle('Estudiar Flutter'), isNull);
    });
  });
  test('valida email y contraseña', () {
    expect(validateEmail('prueba'), 'Correo no válido');
    expect(validateEmail('demo@example.com'), isNull);
    expect(validatePassword('123'), 'Mínimo 6 caracteres');
    expect(validatePassword('123456'), isNull);
  });
}
