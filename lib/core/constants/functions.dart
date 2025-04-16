import"package:flutter/material.dart";

import "colors.dart";


Widget buildTopCircleDecorations() {
  return Stack(
    children: [
      Positioned(
        top: -60,
        left: -10,
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOpacity50,
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: -60,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOpacity50,
          ),
        ),
      ),
    ],
  );
}

Widget buildBottomCircleDecorations() {
  return Stack(
    children: [
      Positioned(
        bottom: -60,
        right: -10,
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOpacity50,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: -60,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOpacity50,
          ),
        ),
      ),
    ],
  );
}