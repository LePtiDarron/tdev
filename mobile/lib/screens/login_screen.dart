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

  Future<void> login(context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Missing field(s).';
      });
      return;
    }

    final response = await AuthService().login(username, password);

    if (response['success']) {
      await AuthService().saveToken(response['token']);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        errorMessage = response['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset('assets/logo.png', width: 200),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
                SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => login(context),
                child: Text('Login'),
              ),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              const Text('Don\'t have an account?'),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: const Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
