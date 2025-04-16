import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/colors.dart';
import 'package:untitled1/screens/onboarding/onboarding2_screen.dart';

class Onboarding1Screen extends StatefulWidget {
  const Onboarding1Screen({super.key});

  @override
  State<Onboarding1Screen> createState() => _Onboarding1ScreenState();
}

class _Onboarding1ScreenState extends State<Onboarding1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // top part
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                Positioned(
                  top: -420,
                  left: -60,
                  child: Container(
                    width: 800,
                    height: 800,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryOpacity80,
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 50,
                  right: 0,
                  child: Image.asset(
                    'assets/images/onboarding1.png',
                    height: 210,
                  ),
                ),
              ],
            ),
          ),

          // text
          SizedBox(height: 60),
          Text(
            'Turn your voice into\ntext easily!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color:AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Record your voice message and\nlet GloSign convert it to\ntext in seconds.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Onboarding2Screen()));
        },
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}
