import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';

class ConfirmationBottun extends StatelessWidget {
  const ConfirmationBottun({
    super.key,
    required this.otpController,
    required this.isOtpComplete,
  });

  final TextEditingController otpController;
  final bool isOtpComplete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOtpComplete
              ? AppColors.splashGradiantColor1
              : Colors.grey.shade400, // حالت غیرفعال
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        onPressed: isOtpComplete
            ? () {
                final otp = otpController.text;
                print('OTP => $otp');
                // verify otp
                context.go('/main_page');
              }
            : null, // 👈 وقتی null باشه دکمه قفله

        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Text('تایید و ادامه'),
              Positioned(left: 5, child: Icon(Icons.arrow_forward, size: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
