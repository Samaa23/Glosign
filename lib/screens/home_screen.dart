import 'package:flutter/material.dart';
import 'package:untitled1/screens/chat_screen.dart';
import 'package:untitled1/screens/profile_screen.dart';

import 'package:untitled1/screens/statistics_screen.dart';
import '../core/constants/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/home_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -10,
            child: Container(
              width: 160,
              height: 160,
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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryOpacity50,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 130),
                const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 50),
                HomeButton(
                  text: "Profile",
                  fontWeight: FontWeight.bold,
                  onTap: () => navigateTo(context,  ProfileScreen()),
                ),
                const SizedBox(height: 20),
                HomeButton(
                  text: "Statistics",
                  fontWeight: FontWeight.bold,
                  onTap: () => navigateTo(context, StatisticsScreen()),
                ),
                const SizedBox(height: 20),
                HomeButton(
                  text: "Chat",
                  fontWeight: FontWeight.bold,
                  onTap: () => navigateTo(context,ChatsPage()),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
