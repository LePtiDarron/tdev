import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  String successMessage = '';

  Future<void> signup() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Veuillez remplir tous les champs.';
        successMessage = '';
      });
      return;
    }

    final response = await AuthService().signup(username, password);

    setState(() {
      if (response['success']) {
        successMessage = response['message'];
        errorMessage = '';
      } else {
        errorMessage = response['message'];
        successMessage = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
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
              onPressed: signup,
              child: Text('S\'inscrire'),
            ),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: TextStyle(color: Colors.red)),
            if (successMessage.isNotEmpty)
              Text(successMessage, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
