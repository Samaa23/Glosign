import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final FontWeight fontWeight;

  const HomeButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primaryOpacity20,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
