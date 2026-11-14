String? validateTaskTitle(String? value) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) return 'El título es obligatorio';
  if (text.length < 3) return 'Escribe al menos 3 caracteres';
  if (text.length > 80) return 'Máximo 80 caracteres';
  return null;
}

String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'El correo es obligatorio';
  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
    return 'Correo no válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
  if (value.length < 6) return 'Mínimo 6 caracteres';
  return null;
}
