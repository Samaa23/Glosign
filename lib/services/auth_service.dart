import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://www.appnest.pro/GloSign/api";

  /// تسجيل الدخول
  static Future<http.Response> login({
    required String email,
    required String password,
  }) {
    final url = Uri.parse('$baseUrl/login');

    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }

  /// تسجيل حساب جديد
  static Future<http.Response> signup({
    required String email,
    required String password,
    required String confirmPassword,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    final url = Uri.parse("https://www.appnest.pro/GloSign/api/register");

    final body = jsonEncode({
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
    });
    print("🟡 SIGNUP BODY: $body");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    return response;
  }


  /// 1. إرسال الإيميل لاستلام كود
  static Future<bool> sendResetCode(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/forgot-password"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    return response.statusCode == 200;
  }

  /// 2. التحقق من الكود
  static Future<bool> verifyResetCode(String email, String code) async {
    final response = await http.post(
      Uri.parse("$baseUrl/verify-code"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "code": code,
      }),
    );

    return response.statusCode == 200;
  }

  /// 3. تعيين كلمة مرور جديدة
  static Future<bool> resetPassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse("$baseUrl/reset-password"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "new_password": newPassword,
      }),
    );

    return response.statusCode == 200;
  }
}