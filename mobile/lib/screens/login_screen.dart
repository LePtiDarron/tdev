import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  String token = '';

  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Veuillez remplir tous les champs.';
        token = '';
      });
      return;
    }

    final response = await AuthService().login(username, password);

    setState(() {
      if (response['success']) {
        token = response['token'];
        errorMessage = '';
      } else {
        errorMessage = response['message'];
        token = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mot de passe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Se connecter'),
            ),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: TextStyle(color: Colors.red)),
            if (token.isNotEmpty)
              Text('Token : $token', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
