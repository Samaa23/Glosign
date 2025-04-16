import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
class SmallContainerCheckEmail extends StatelessWidget {
  const SmallContainerCheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.fieldBorder,
          width: 1.5,
        ),
      ),
    );
  }
}
