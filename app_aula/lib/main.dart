import 'package:flutter/material.dart';
import 'package:app_aula/telas/home.dart';
import 'package:app_aula/telas/login.dart';
import 'package:app_aula/telas/tela_lista_pets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoção de Pets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/pets': (context) => const TelaListaPets(),
      },
    );
  }
}
