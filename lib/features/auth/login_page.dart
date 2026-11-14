import 'package:flutter/material.dart';
import '../../core/error_messages.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.auth});
  final AuthService auth;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _registering = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _loading) return;
    setState(() { _loading = true; _error = null; });
    try {
      if (_registering) {
        await widget.auth.register(_email.text.trim(), _password.text);
      } else {
        await widget.auth.signIn(_email.text.trim(), _password.text);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = messageForError(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_registering ? 'Crear cuenta' : 'Iniciar sesión')),
        body: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: ListView(shrinkWrap: true, children: [
                const Icon(Icons.task_alt, size: 64),
                const SizedBox(height: 12),
                Text('TaskFlow', textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 24),
                TextFormField(
                  key: const Key('email_field'),
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('password_field'),
                  controller: _password,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: validatePassword,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, key: const Key('login_error'),
                      style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  key: const Key('login_button'),
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(height: 18, width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(_registering ? 'Registrarse' : 'Entrar'),
                ),
                TextButton(
                  onPressed: _loading ? null : () => setState(() {
                    _registering = !_registering;
                    _error = null;
                  }),
                  child: Text(_registering ? 'Ya tengo cuenta' : 'Crear una cuenta'),
                ),
              ]),
            ),
          ),
        )),
      );
}
