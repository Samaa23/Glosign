import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/functions.dart';
import 'package:untitled1/screens/registration/forget_password/forget_pass_scr_3.dart';
import 'package:untitled1/widgets/small_container_check_email.dart';

import '../../../core/constants/colors.dart';
import 'forget_pass_scr_1.dart';

class ForgetPassScr2 extends StatefulWidget {
  const ForgetPassScr2({super.key});

  @override
  State<ForgetPassScr2> createState() => _ForgetPassScr2State();
}

class _ForgetPassScr2State extends State<ForgetPassScr2> {
  String personEmail = "test@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children:[
            buildBottomCircleDecorations(),
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScr1()));
                      }, child: Icon(Icons.arrow_back, size: 20),
                    ),),                  SizedBox(height: 40),
                  Text(
                    "Check your email",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We sent a reset link to ${personEmail}.\n com enter 5 digit code that mentioned in \nthe email",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallContainerCheckEmail(),
                      SizedBox(width: 10,),
                      SmallContainerCheckEmail(),
                      SizedBox(width: 10,),
                      SmallContainerCheckEmail(),
                      SizedBox(width: 10,),
                      SmallContainerCheckEmail(),
                      SizedBox(width: 10,),
                      SmallContainerCheckEmail(),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScr3()));
                      },
                      child: Text(
                        "Verify code",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),

      ),
    );
  }
}
