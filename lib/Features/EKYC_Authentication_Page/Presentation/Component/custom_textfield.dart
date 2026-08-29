import 'package:flutter/material.dart';
import '../../../../Core/Theme/app_colors.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hint,
  required FormFieldValidator<String> validator,
  required GlobalKey<FormState> formKey,
}) {
  return Form(
    key: formKey,
    child: TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: AppColors.customHeaderTextColor
        ),
        border: OutlineInputBorder(),
      ),
    ),
  );
}