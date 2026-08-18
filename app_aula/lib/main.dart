import 'package:app_aula/telas/contador.dart';
import 'package:app_aula/telas/home.dart';
import 'package:app_aula/telas/login.dart';
import 'package:app_aula/telas/sobre.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App aula',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 61, 168, 255),
        ),
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/contador': (context) => ContadorPage(title: "Contador"),
        '/sobre': (context) => SobrePage(),
      },
    );
  }
}
