import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'is_valid_national_code.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textInputType,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.formKey,
  });

  final TextInputType textInputType;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: formKey,
        child: TextFormField(
          textDirection: TextDirection.ltr,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: textInputType,
          obscureText: obscureText,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle!.color,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            hintText == 'شماره همراه'
                ? LengthLimitingTextInputFormatter(11)
                : LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (hintText == 'کد ملی') {
              if (value == null || value.isEmpty) {
                return 'لطفا کدملی خود را وارد نمایید.';
              }
              if (value.length != 10) {
                return 'کد ملی وارد شده صحیح نمی باشد.';
              }
              if (isValidIranianNationalCode(value) == false) {
                return 'کد ملی وارد شده صحیح نمی باشد.';
              }
            }
            if (hintText == 'شماره همراه') {
              if (value == null || value.isEmpty) {
                return 'لطفا شماره همراه خود را وارد نمایید.';
              }
              if (value.length != 11) {
                return 'شماره همراه وارد شده صحیح نمی باشد.';
              }
              if (value.startsWith('09') == false) {
                return 'شماره همراه وارد شده صحیح نمی باشد.';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
            hintTextDirection: TextDirection.rtl,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
            ), // تنظیم پدینگ عمودی
          ),
        ),
      ),
    );
  }
}
