import 'package:flutter/material.dart';

import '../../../../../../Core/Const/app_colors.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.showDepositContainer, required this.showWithdrawContainer, required this.balanceFormKey});

  final GlobalKey<FormState> balanceFormKey;
  final bool showDepositContainer;
  final bool showWithdrawContainer;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showDepositContainer || showWithdrawContainer,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (balanceFormKey.currentState?.validate() ?? false) {
              Navigator.pop(context);
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
