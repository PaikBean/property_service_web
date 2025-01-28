import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = "https://api.example.com";

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
