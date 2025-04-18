import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onNotificationsTap;

  const ProfileCard({
    super.key,
    required this.onEditProfile,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Colors.black),
              title: const Text('Edit profile information'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: onEditProfile,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.notifications_none_outlined, color: Colors.black),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: onNotificationsTap,
            ),
          ],
        ),
      ),
    );
  }
}
