import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textInputType,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  final TextInputType textInputType;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: textInputType,
        obscureText: obscureText,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          hintText == 'شماره همراه'
              ? LengthLimitingTextInputFormatter(11)
              : LengthLimitingTextInputFormatter(10),
        ],
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
    );
  }
}
