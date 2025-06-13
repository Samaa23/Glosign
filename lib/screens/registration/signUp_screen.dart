import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/colors.dart';
import 'package:untitled1/screens/registration/add_photo_screen.dart';
import 'package:untitled1/screens/registration/login_screen.dart';
import 'package:untitled1/services/auth_service.dart';
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscureText = true;
  bool isLoading = false;

  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> handleSignup() async {
    setState(() => isLoading = true);

    final names = fullNameController.text.trim().split(" ");
    final firstName = names.isNotEmpty ? names.first : null;
    final lastName = names.length > 1 ? names.sublist(1).join(" ") : null;

    try {
      if (passwordController.text.length < 6 || passwordController.text.length > 100) {
        throw 'Password must be between 6-100 characters';
      }

      if (passwordController.text != confirmPasswordController.text) {
        throw 'Passwords do not match';
      }

      final response = await AuthService.signup(
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneController.text.trim(),
      );
      print("📦 Response Body: ${response.body}");  // هنا طباعة الرد من السيرفر
      setState(() => isLoading = false);

      int statusCode = response.statusCode;
      print("🔍 Status Code: $statusCode");

      String message = 'Signup failed';

      if (statusCode == 200 || statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Account created successfully!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddPhotoScreen()),
        );
        return;
      }

      if (response.body.isNotEmpty) {
        try {
          final body = jsonDecode(response.body);
          message = body['detail'] ??
              body['title'] ??
              body['message'] ??
              (body['errors'] is Map ? _extractFirstError(body['errors']) : message);
        } catch (_) {
          message = "Invalid server response format";
        }
      } else {
        message = "Empty response from server (status $statusCode)";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ $message")),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠ ${e.toString()}")),
      );
    }
  }

  String _extractFirstError(Map<String, dynamic> errors) {
    if (errors.isEmpty) return 'Unknown error';
    final firstKey = errors.keys.first;
    final firstError = errors[firstKey];
    if (firstError is List) return firstError.isNotEmpty ? firstError[0].toString() : 'Unknown error';
    return firstError.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ديكور الخلفية
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: AppColors.primaryLight,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  Text(
                    "Sign up for\u00a0Glosign—",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Where speech meets sign,\nAnd communication \nbecomes limitless.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(fullNameController, "Enter your full name", Icons.person_outlined),
                  const SizedBox(height: 30),
                  _buildTextField(emailController, "Enter your Email", Icons.email_outlined),
                  const SizedBox(height: 30),
                  _buildTextField(phoneController, "Enter your phone number", Icons.phone_outlined),
                  const SizedBox(height: 30),
                  _buildPasswordField(passwordController, "Enter Your Password"),
                  const SizedBox(height: 30),
                  _buildPasswordField(confirmPasswordController, "Confirm password"),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: isLoading ? null : handleSignup,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?", style: TextStyle(color: AppColors.textPrimary, fontSize: 16)),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                        },
                        child: Text(" Sign In", style: TextStyle(color: AppColors.primary, fontSize: 16)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.primary,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primaryLight,
        prefixIcon: Icon(icon),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: AppColors.primaryLight)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: AppColors.primary)),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primary,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primaryLight,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
        prefixIcon: const Icon(Icons.lock_outlined, size: 20),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          onPressed: () => setState(() => obscureText = !obscureText),
        ),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: AppColors.fieldBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: AppColors.primary)),
      ),
    );
  }
}