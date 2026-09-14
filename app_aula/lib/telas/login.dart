import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  Login login = Login();

  void _autenticar() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro nos dados de usuário ou senha')),
      );
      return;
    }
    if (login.user == 'julio' && login.senha == '123456') {
      Navigator.popAndPushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha inválidos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                initialValue: 'julio',
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deve informar o usuário';
                  }
                  if (value.length < 2) {
                    return 'O usuário deve ter pelo menos 2 caracteres';
                  }
                  login.user = value;
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: '123456',
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deve informar a senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  login.senha = value;
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _autenticar();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Login {
  String user = '';
  String senha = '';
}
