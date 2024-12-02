import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  String errorMessage = '';

  Future<void> login(context) async {
    final email = emailController.text;
    final password = passwordController.text;
    final firstname = firstnameController.text;
    final lastname = lastnameController.text;
    final phonenumber = phonenumberController.text;
    final address = addressController.text;
    final zip = zipController.text;
    final city = cityController.text;
    final country = countryController.text;

    if (email.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty
        || phonenumber.isEmpty || address.isEmpty || zip.isEmpty || city.isEmpty || country.isEmpty) {
      setState(() {
        errorMessage = 'Missing field(s).';
      });
      return;
    }

    final response = await AuthService().signup(email, password, firstname, lastname, phonenumber, address, zip, city, country);
    
    if (response['success']) {
      Navigator.of(context).pushReplacementNamed('/login');
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
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: firstnameController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: lastnameController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phonenumberController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: addressController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: zipController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Zip Code'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: cityController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: countryController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Country'),
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
                child: Text('Signup'),
              ),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              const Text('Already have an account?'),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
