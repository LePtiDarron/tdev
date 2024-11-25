import 'package:flutter/material.dart';
import './screens/signup_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(),
      routes: {
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
