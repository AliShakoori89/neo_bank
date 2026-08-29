import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import 'custom_formatter.dart';

class AddBalanceTextField extends StatelessWidget {
  const AddBalanceTextField({
    super.key,
    required this.balanceController,
    required this.balanceFormKey,
    this.onChanged,
  });

  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: balanceFormKey,
      child: SizedBox(
        height: 50,
        child: TextFormField(
          controller: balanceController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          autofocus: false,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لطفاً مبلغ را وارد کنید';
            }
            final rawValue = balanceController.rawValue;
            if (rawValue < 10000) {
              return 'حداقل مبلغ ۱۰,۰۰۰ تومان می‌باشد';
            }
            if (rawValue > 1000000000) {
              return 'حداکثر مبلغ ۱,۰۰۰,۰۰۰,۰۰۰ تومان می‌باشد';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'XXX',
            hintStyle: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14
            ),
            suffixText: 'تومان',
            suffixStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle
                  ?.color,
            ),
            filled: true,
            fillColor: Colors.grey.withAlpha(30),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.splashGradiantColor2,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}