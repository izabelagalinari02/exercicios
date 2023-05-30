import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool mostrarSenha = false;
  bool _inativarEmailNotifications = false;
  bool _inativarPhoneNotifications = false;
  String _selecionarGenero = '';
  double _fontSize = 16.0;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    dobController.dispose();
    celularController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void registrar() async {
    final String nome = nomeController.text.trim();
    final String dob = dobController.text.trim();
    final String celular = celularController.text.trim();
    final String email = emailController.text.trim();
    final String senha = senhaController.text.trim();

    // Save registration data using SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nome);
    await prefs.setString('dob', dob);
    await prefs.setString('phone', celular);
    await prefs.setString('email', email);
    await prefs.setString('password', senha);
  }


  void _toggleSenha() {
    setState(() {
      mostrarSenha = !mostrarSenha;
    });
  }

  void _onGenero(String value) {
    setState(() {
      _selecionarGenero = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              maxLength: 50,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: dobController,
              decoration: const InputDecoration(labelText: 'Data de nascimento'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: celularController,
              decoration: const InputDecoration(labelText: 'Celular'),
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
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
                  onPressed: _toggleSenha,
                ),
              ),
              obscureText: !mostrarSenha,
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('Masculino'),
              value: _selecionarGenero == 'Masculino',
              onChanged: (value) => _onGenero('Masculino'),
            ),
            CheckboxListTile(
              title: const Text('Feminino'),
              value: _selecionarGenero == 'Feminino',
              onChanged: (value) => _onGenero('Feminino'),
            ),
            const SizedBox(height: 16.0),
            SwitchListTile(
              title: const Text('Habilitar notificacoes do email'),
              value: _inativarEmailNotifications,
              onChanged: (value) {
                setState(() {
                  _inativarEmailNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Habilitar notificacoes do telefone'),
              value: _inativarPhoneNotifications,
              onChanged: (value) {
                setState(() {
                  _inativarPhoneNotifications = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Slider(
              value: _fontSize,
              min: 10.0,
              max: 24.0,
              divisions: 7,
              label: _fontSize.round().toString(),
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              style: TextStyle(fontSize: _fontSize),
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Fonte variável',
                labelStyle: TextStyle(fontSize: _fontSize),
              ),
              maxLength: 50,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                registrar();
                // Perform registration logic here
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
