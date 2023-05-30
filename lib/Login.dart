import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MenuNavegacaoWidget.dart';
import 'cadastro.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState  extends State<Login>{
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool mostrarSenha = false;

  void _login() {
    final String email = loginController.text.trim();
    final String senha = senhaController.text.trim();

    if (email == 'teste@gmail.com' && senha == '987654') {
      // Perform login logic here
      const AlertDialog(content:Text('Sucesso'));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalido'),
            content: const Text('Usuario ou senha incorreto'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  void verificarLogin() async {
    final String email = loginController.text.trim();
    final String senha = senhaController.text.trim();

    // Read registration data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? emailRegistrado = prefs.getString('email');
    final String? senhaRegistrada = prefs.getString('senha');

    if (email == emailRegistrado && senha == senhaRegistrada) {
      // Credentials are correct, navigate to welcome screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaMenuNavegacaoInferior(),
        ),
      );
    } else {
      // Credentials are incorrect, display an AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalido'),
            content: Text('Usuario ou senha incorreto'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }



  void toggleSenha() {
    setState(() {
      mostrarSenha = !mostrarSenha;
    });
  }

  void _navigateRegistration() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Cadastro();
        },
      ),
    );
  }

  @override
  void dispose() {
    loginController.dispose();
    senhaController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body:
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imagem.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 16.0),

            TextFormField(
              controller: loginController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    mostrarSenha ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: toggleSenha,
                ),
              ),
              obscureText: !mostrarSenha,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                _login();
                verificarLogin();
                // Perform registration logic here
              },
              child: const Text('LOGIN'),
            ),
            GestureDetector(
              onTap: _navigateRegistration,
              child: const Text(
                  "Nao tem conta?", style:TextStyle(color: Colors.red)
              ),
            ),
          ],
        ),
      ),
    );
  }
}