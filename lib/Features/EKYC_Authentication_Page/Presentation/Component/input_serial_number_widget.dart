import 'package:flutter/material.dart';
import '../../../../Core/Spacing/app_space.dart';
import 'custom_textfield.dart';

Widget inputSerialNumberWidget(
    dynamic theme,
    TextEditingController cardSerialController,
    GlobalKey<FormState> cardSerialFormKey
    ){
  return Column(
    children: [
      Text(
        'شماره سریال کارت ملی:',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.appBarTheme.titleTextStyle?.color,
        ),
      ),
      AppSpace.heightSpace_8,

      customTextField(
        controller: cardSerialController,
        hint: '1G23456789',
        formKey: cardSerialFormKey,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'شماره سریال الزامی است';
          }
          return null;
        },
      ),
    ],
  );
}