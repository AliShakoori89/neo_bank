import 'package:flutter/material.dart';

import '../Spacing/app_space.dart';
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
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          const Text(
            'تایید و ادامه',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.loginPageHintFontColor,
            ),
          ),
          AppSpace.widthSpace_5,
          Icon(
            Icons.arrow_forward,
            color: AppColors.loginPageHintFontColor
          ),
        ],
      ),
    );
  }
}