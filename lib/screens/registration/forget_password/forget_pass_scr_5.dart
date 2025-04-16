import 'package:flutter/material.dart';
import 'package:untitled1/screens/home_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/functions.dart';
import 'forget_pass_scr_4.dart';

class ForgetPassScr5 extends StatefulWidget {
  const ForgetPassScr5({super.key});

  @override
  State<ForgetPassScr5> createState() => _ForgetPassScr5State();
}

class _ForgetPassScr5State extends State<ForgetPassScr5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            buildBottomCircleDecorations(),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 100,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppColors.primary,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Successful",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 40),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                              child: Text(
                                "Continue",
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
                ),
              ),
            ),
          ],
        ),)
    );
  }

}
