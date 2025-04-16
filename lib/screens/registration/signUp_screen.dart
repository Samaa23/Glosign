import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/colors.dart';
import 'package:untitled1/core/constants/functions.dart';
import 'package:untitled1/screens/registration/add_photo_screen.dart';
import 'package:untitled1/screens/registration/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscureText = true;
  String selectedStatus = 'normal';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          buildTopCircleDecorations(),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Text(textAlign: TextAlign.center,
                    "Sign up for Glosign—",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),),
                  SizedBox(height: 20,),
                  Text(textAlign: TextAlign.center,
                    "Where speech meets sign,\nAnd communication \nbecomes limitless.",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),),
                  SizedBox(height: 20,),
                  TextField(
                    cursorColor: AppColors.primary,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.primaryLight,
                      prefixIcon: Icon(Icons.person_outlined),
                      hintText: "Enter your full name",
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primaryLight,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1
                        )
                      )

                    ),
                  ),
                  SizedBox(height: 30,),
                  TextField(
                    cursorColor: AppColors.primary,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.primaryLight,
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Enter your Email",
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.primaryLight,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1
                            )
                        )

                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    cursorColor: AppColors.primary,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.primaryLight,
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.lock_outlined, size: 20),
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
                            width: 1,
                          )

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    cursorColor: AppColors.primary,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.primaryLight,
                      hintText: "Confirm password",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.lock_outlined, size: 20),
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
                            width: 1,
                          )

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },

                    items: ['normal', 'silent'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value[0].toUpperCase() + value.substring(1),
                          style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.primaryLight,
                      prefixIcon: Icon(Icons.person_outlined),

                      hintText: "User Status",
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primaryLight,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1,
                        ),
                      ),
                    ),
                    dropdownColor: AppColors.primaryLight,
                    iconEnabledColor: AppColors.textPrimary,
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                  ),

                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                      ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPhotoScreen()));
                        },
                        child: Text("Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),)),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(textAlign: TextAlign.center,
                        "Already have an account ?",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                        ),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: Text(textAlign: TextAlign.center,
                          " Sign In",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ]

      )
    );
  }
}
