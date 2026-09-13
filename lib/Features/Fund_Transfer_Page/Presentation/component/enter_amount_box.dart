import 'package:flutter/material.dart';
import '../../../../Core/Convertor/thousands_separator_formatter.dart';
import '../../../../Core/Theme/app_colors.dart';

class EnterAmountBox extends StatelessWidget {
  const EnterAmountBox({super.key, required this.amountController, required this.formKey});

  final TextEditingController amountController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: amountController,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.number,
        inputFormatters: [
          ThousandsSeparatorFormatter(),
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.outline,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          hintText: 'مبلغ انتقال',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.surface,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, top: 12),
            child: Text(
              'ریال',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surfaceDim,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surfaceDim,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.splashGradiantColor1,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'لطفا مبلغ مورد نظر خود را بنویسید';
          }
          return null;
        },
      ),
    );
  }
}
