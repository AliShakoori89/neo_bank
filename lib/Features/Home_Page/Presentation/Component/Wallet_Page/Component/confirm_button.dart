import 'package:flutter/material.dart';
import '../../../../../../Core/Theme/app_colors.dart';


class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
    required this.amount,
    required this.rawAmount,
    required this.deposit,
    required this.withdraw,
    required this.balanceFormKey,
    this.selectedDepositNumber,
    this.onConfirm,
    this.isLoading = false, // اضافه کردن این پارامتر
  });

  final String amount;
  final int rawAmount;
  final bool deposit;
  final bool withdraw;
  final GlobalKey<FormState> balanceFormKey;
  final String? selectedDepositNumber;
  final VoidCallback? onConfirm;
  final bool isLoading; // وضعیت لودینگ

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 10,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            isLoading ? Colors.grey : AppColors.splashGradiantColor1,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
        onPressed: isLoading
            ? null // غیرفعال کردن دکمه در زمان لودینگ
            : () {
          if (balanceFormKey.currentState?.validate() ?? false) {
            if (deposit && selectedDepositNumber == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('لطفاً شماره حساب را انتخاب کنید')),
              );
              return;
            }
            onConfirm?.call();
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: isLoading
                ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              'تایید',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}