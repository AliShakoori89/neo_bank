import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.gradiantColor1, AppColors.gradiantColor2],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/Logomark.png',
                  width: 31.66,
                  height: 37.99,
                ),
                SizedBox(width: 9.5),
                Text(
                  'فیروزه بانک',
                  style: TextStyle(
                    fontSize: 24.47,
                    color: AppColors.appWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text('نسخه 1.0', style: TextStyle(color: AppColors.appWhite)),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
