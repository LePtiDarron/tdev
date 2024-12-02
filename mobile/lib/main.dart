import 'package:flutter/material.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syna',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.grey[300],
        scaffoldBackgroundColor: Colors.blue[50],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.grey[300],
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.grey[800], fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey[800]),
          hintStyle: TextStyle(color: Colors.grey[500]),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(200, 40),
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.black,
            iconColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}