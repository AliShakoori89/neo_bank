import 'package:flutter/material.dart';

import '../Theme/app_colors.dart';

class CustomDisableButton extends StatelessWidget {
  const CustomDisableButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        enableFeedback: false,
        backgroundColor: WidgetStateProperty.all<Color>(
          AppColors.loginPageIconColor.withAlpha(50), // کمرنگ‌تر
        ),
        overlayColor: WidgetStateProperty.all<Color>(
          Colors.transparent, // بدون افکت هنگام لمس
        ),
        shadowColor: WidgetStateProperty.all<Color>(
          Colors.transparent, // بدون سایه در حالت دیزیبل
        ),
        elevation: WidgetStateProperty.all<double>(0), // بدون ارتفاع
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
      onPressed: null,
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            'تایید',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkModeIconIconColor.withAlpha(60), // متن کمرنگ‌تر
            ),
          ),
        ),
      ),
    );
  }
}