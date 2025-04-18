import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_card.dart';
import 'eidit_profile.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor:AppColors.primaryOpacity20,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(subtitle: ''),
            const SizedBox(height: 20),
            const Text(
              'User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 80),

            ProfileCard(
              onEditProfile: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfile(),
                  ),
                );
              },
              onNotificationsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotificationsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
