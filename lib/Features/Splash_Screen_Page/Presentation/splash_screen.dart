import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_version.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../Core/Utils/neo_bank_logo.dart';
import '../../Main_Page/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // ✅ بعد از ۲ ثانیه میره به مین پیج
    Timer(const Duration(seconds: 2), () {
      context.go('/login_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.splashGradiantColor2,
              AppColors.splashGradiantColor1],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            NeoBankLogo(
              logoColor: AppColors.appWhite,
              logoWidth: 98,
              logoHeight: 24,
              space: 5,
            ),
            Spacer(),
            NeoBankVersion(textColor: AppColors.appWhite,),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
