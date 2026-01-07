import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Text(
      phoneNumber.toPersianDigit(),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.customHeaderTextColor,
      ),
    );
  }
}
