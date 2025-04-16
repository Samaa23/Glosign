import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/colors.dart';
import 'package:untitled1/screens/registration/login_screen.dart';

class Onboarding4Screen extends StatefulWidget {
  const Onboarding4Screen({super.key});

  @override
  State<Onboarding4Screen> createState() => _Onboarding4ScreenState();
}

class _Onboarding4ScreenState extends State<Onboarding4Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
           Stack(
            children: [
              ClipPath(
                clipper: TopWaveOnboarding4(),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF90C5FF),
                        Colors.blueAccent,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                  ),
                ),
              )),
              Positioned(
                top: 60,
                left: 52,
                height: 430,
                width: 350,
                child: Image.asset("assets/images/onboarding4.png",),
              )
            ],
          ),
          SizedBox(height: 70,),
          Text("Stay informed with real-time insights!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),),
          SizedBox(height: 20,),
          Text(" Glosign provides detailed \nstatistics to help you make \nsmarter \ndecisions with ease",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
          },
          child: Icon(Icons.arrow_forward,color: AppColors.background,),
        ),
    );
  }
}

class TopWaveOnboarding4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80); 

    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.50, size.height - 65,
    );

    path.quadraticBezierTo(
      size.width * 0.75, size.height - 160, 
      size.width , size.height - 300,       
    );
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

