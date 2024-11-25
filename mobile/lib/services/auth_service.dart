import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl = 'http://localhost:3000/auth'; // Remplace par l'URL de ton API

  // Inscription
  Future<Map<String, dynamic>> signup(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
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

  // Connexion
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
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
}
