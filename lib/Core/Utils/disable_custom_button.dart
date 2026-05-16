import 'package:flutter/material.dart';

import '../Const/app_colors.dart';

class DisableCustomButton extends StatelessWidget {
  const DisableCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        enableFeedback: false,
        backgroundColor: WidgetStateProperty.all<Color>(
          AppColors.loginPageIconColor,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
      onPressed: null, // ← این خط باعث دیزیبل شدن می‌شود
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            'تایید',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkModeIconIconColor
            ),
          ),
        ),
      ),
    );
  }
}
