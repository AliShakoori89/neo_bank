import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../Core/Const/app_colors.dart';
import 'custom_formatter.dart';

class AddBalanceTextField extends StatelessWidget {
  const AddBalanceTextField({
    super.key,
    required this.balanceController,
    required this.balanceFormKey,
  });

  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: balanceFormKey,
      child: SizedBox(
        height: 55,
        child: TextFormField(
          controller: balanceController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          autofocus: true,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لطفا مبلغ مورد نظر خود را وارد نمایید.';
            }
            return null;
          },
          decoration: InputDecoration(
            suffixText: 'ریال',
            suffixStyle: TextStyle(
              fontSize: 26,
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
              borderSide: BorderSide(
                color: Colors.green.shade400,
              ),
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