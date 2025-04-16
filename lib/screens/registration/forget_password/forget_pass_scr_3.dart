import 'package:flutter/material.dart';
import 'package:untitled1/screens/registration/forget_password/forget_pass_scr_4.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/functions.dart';
import 'forget_pass_scr_2.dart';
class ForgetPassScr3 extends StatefulWidget {
  const ForgetPassScr3({super.key});

  @override
  State<ForgetPassScr3> createState() => _ForgetPassScr3State();
}

class _ForgetPassScr3State extends State<ForgetPassScr3> {
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScr2()));
                            }, child: Icon(Icons.arrow_back, size: 20),
                          ),),
                        SizedBox(height: 40),
                      Text(
                        "Password  reset",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your password has been successfully reset.\nClick confirm to reset the password. ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScr4()));
                          },
                          child: Text(
                            "Confirm",
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
