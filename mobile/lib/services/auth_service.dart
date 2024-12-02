import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String apiUrl = 'http://localhost:3000/auth';

  Future<Map<String, dynamic>> signup(String email, String password, String firstname, String lastname, String phonenumber, String address, String zip, String city, String country) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'firstname': firstname,
          'lastname': lastname,
          'phonenumber': phonenumber,
          'address': address,
          'zip': zip,
          'city': city,
          'country': country,
        }),
      );
      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        return {'success': false, 'message': json.decode(response.body)['message']};
      }
    } catch (error) {
      return {'success': false, 'message': 'Erreur de connexion'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'token': data['token']};
      } else {
        return {'success': false, 'message': json.decode(response.body)['message']};
      }
    } catch (error) {
      return {'success': false, 'message': 'Erreur de connexion'};
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
