import 'package:flutter/material.dart';

import '../../../../../../Core/Const/app_colors.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.balanceFormKey, required this.deposit, required this.withdraw});

  final bool deposit;
  final bool withdraw;
  final GlobalKey<FormState> balanceFormKey;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: deposit || withdraw,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (balanceFormKey.currentState?.validate() ?? false) {

            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.splashGradiantColor1,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('تایید'),
        ),
      ),
    );
  }
}
