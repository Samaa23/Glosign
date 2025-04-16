import 'package:flutter/material.dart';

class AppColors {

  static const Color primary = Colors.blueAccent;

  static final Color primaryLight = Color(0xF0F5F9FF);

  static const Color background = Colors.white;

  static const Color textPrimary = Colors.black87;

  static Color textSecondary = Colors.grey[500]!;

  static final Color fieldBorder = Colors.grey.shade300;

  static const Color error = Colors.red;

  static const Color success = Colors.green;

  static final Color iconLight = Colors.grey[400]!;

  static final Color primaryOpacity20 = Colors.blueAccent.withAlpha(51);   // 30% = 255 * 0.3 = 76.5 ≈ 77
  static final Color primaryOpacity30 = Colors.blueAccent.withAlpha(77);   // 30% = 255 * 0.3 = 76.5 ≈ 77
  static final Color primaryOpacity50 = Colors.blueAccent.withAlpha(128); // 50% = 255 * 0.5 = 128
  static final Color primaryOpacity80 = Colors.blueAccent.withAlpha(204); // 80% = 255 * 0.8 = 204

}
