import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<http.Response> login({
    required String email,
    required String password,
  }) {
    final url = Uri.parse('https://www.appnest.pro/GloSign/api/login');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: '{"email": "$email", "password": "$password"}',
    );
  }
  static Future<http.Response> signup({
    required String email,
    required String password,
    required String confirmPassword,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) {
    final url = Uri.parse('https://www.appnest.pro/GloSign/api/register');
    final body = jsonEncode({
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    });

    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }
}

