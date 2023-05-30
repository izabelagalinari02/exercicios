import 'package:flutter/material.dart';

class TelaIniciall extends StatelessWidget {
  final String? usuario;

  const TelaIniciall({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo'),
      ),
      body: Center(
        child: Text('Bem vindo, $usuario!'),
      ),
    );
  }
}