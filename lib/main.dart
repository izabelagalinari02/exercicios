
import 'package:flutter/material.dart';

import 'Cadastro.dart';
import 'Login.dart';
import 'MenuNavegacaoWidget.dart';
import 'PaginaLista.dart';


void main() async {
  runApp(const ExerciseHubApp());
}



class ExerciseHubApp extends StatelessWidget {
  const ExerciseHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Hub',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/Exercicio1': (context) => const Cadastro(),
        '/Exercicio2': (context) => Login(),
        '/Exercicio3': (context) => const TelaMenuNavegacaoInferior(),
        '/Exercicio4': (context) => PaginaLista(),

        // Add more routes for other exercises
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercicios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Exercicio1');
              },
              child: const Text('Exercício cadastro'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Exercicio2');
              },
              child: const Text('Exercício Login'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Exercicio3');
              },
              child: const Text('Exercício Menu navegacao'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Exercicio4');
              },
              child: const Text('Exercício lista itens'),
            ),
            // Add more buttons for other exercises
          ],
        ),
      ),
    );
  }
}