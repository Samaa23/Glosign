import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../screens/eidit_profile.dart';

class ProfileHeader extends StatelessWidget {
  final String subtitle;

  const ProfileHeader({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: CurvedClipper(),
          child: Container(
            height: 250,
            width: double.infinity,
            color: AppColors.primaryOpacity20,
          ),
        ),
        Positioned(
          top: 100,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.background,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/icons/Glosihn_icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                'User',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: const Text(
                    'Edit Information',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
