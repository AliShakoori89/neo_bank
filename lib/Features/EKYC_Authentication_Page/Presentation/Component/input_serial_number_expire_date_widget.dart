import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Spacing/app_space.dart';

Widget inputSerialNumberExpireDateWidget (
    theme,
    GlobalKey<FormState> monthFormKey,
    GlobalKey<FormState> yearFormKey,
    TextEditingController monthController,
    TextEditingController yearController
    ){
  return Column(
    children: [
      Text(
        'تاریخ انقضاء کارت ملی:',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.appBarTheme.titleTextStyle?.color,
        ),
      ),
      AppSpace.heightSpace_8,

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.surfaceDim,
          ),
        ),
        child: Row(
          children: [
            /// Month
            Expanded(
              child: Form(
                key: monthFormKey,
                child: TextFormField(
                  controller: monthController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ماه الزامی است';
                    }

                    final month = int.tryParse(value);
                    if (month == null || month < 1 || month > 12) {
                      return 'ماه باید بین 1 تا 12 باشد';
                    }

                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'MM',
                    hintStyle: TextStyle(
                        color: AppColors.customHeaderTextColor
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Text(
              '/',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),

            /// Year
            Expanded(
              child: Form(
                key: yearFormKey,
                child: TextFormField(
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'سال الزامی است';
                    }

                    final year = int.tryParse(value);
                    if (year == null || year < 1300 || year > 1500) {
                      return 'سال نامعتبر است';
                    }

                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'YYYY',
                    hintStyle: TextStyle(
                        color: AppColors.customHeaderTextColor
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}