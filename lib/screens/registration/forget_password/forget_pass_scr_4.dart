import 'package:flutter/material.dart';
import 'package:untitled1/screens/registration/forget_password/forget_pass_scr_3.dart';
import 'package:untitled1/screens/registration/forget_password/forget_pass_scr_5.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/functions.dart';

class ForgetPassScr4 extends StatefulWidget {
  const ForgetPassScr4({super.key});

  @override
  State<ForgetPassScr4> createState() => _ForgetPassScr4State();
}

class _ForgetPassScr4State extends State<ForgetPassScr4> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
            children:[
              buildTopCircleDecorations(),
              buildBottomCircleDecorations(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 110),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScr3()));
                          }, child: Icon(Icons.arrow_back, size: 20),
                        ),),
                      SizedBox(height: 40),
                      Text(
                        "Set a new password ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Create a new password.Ensure it is differs from previous one for security.",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Password ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary
                      ),),
                      SizedBox(height: 10,),
                      TextField(
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 14
                        ),
                        obscureText: obscureText,
                        cursorColor: AppColors.primary,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.primaryLight,
                          hintText: "Enter your new password",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                          prefixIcon: Icon(Icons.lock_outlined,size: 20,),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.fieldBorder,
                              width: 1.5
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            )
                          )
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Confirm password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary
                      ),),
                      SizedBox(height: 10,),
                      TextField(
                        cursorColor: AppColors.primary,
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 14,
                        ),
                        obscureText: obscureText,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.primaryLight,
                            hintText: "Re-enter password",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                          prefixIcon: Icon(Icons.lock_outlined,size: 20,),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                              color: AppColors.fieldBorder,
                              width: 1.5
                          )
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        )
                    )
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScr5()));
                          },
                          child: Text(
                            "Update password",
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
