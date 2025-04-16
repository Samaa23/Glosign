import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/colors.dart';
import 'package:untitled1/screens/onboarding/onboarding2_screen.dart';
import 'package:untitled1/screens/onboarding/onboarding4_screen.dart';

class Onboarding3Screen extends StatefulWidget {
  const Onboarding3Screen({super.key});

  @override
  State<Onboarding3Screen> createState() => _Onboarding3ScreenState();
}

class _Onboarding3ScreenState extends State<Onboarding3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(height: 300,
          child:
              Stack(
                children: [
                  Positioned(
                      top: -300,
                      right: -138,
                      child: Container(
                        height: 600,
                        width: 600,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF90C5FF),
                              Colors.blueAccent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                      )
                  )
                ],
              )
          ),
          Image.asset("assets/images/onboarding3.png"),
          Text("Keep in touch seamlessly!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),),
          SizedBox(height: 20,),
          Text(
            textAlign: TextAlign.center,
            "Glosign is designed to be easy to use for \neveryone.",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Onboarding4Screen()));
      },
      child: Icon(Icons.arrow_forward,color: AppColors.background,),
      ),
    );
  }
}


class TopWaveOnboarding2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height - 60,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height - 120,
      size.width, size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
