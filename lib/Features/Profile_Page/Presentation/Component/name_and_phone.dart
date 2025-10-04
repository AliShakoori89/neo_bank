import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../Core/Const/app_colors.dart';

class NameAndPhone extends StatelessWidget {
  const NameAndPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return                       Column(
      children: [
        Text('مهرداد علیمردانی',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.homePageCardTitleColor
          ),
        ),
        Text('09123456789'.toPersianDigit(),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.loginPageTextColor
          ),
        )
      ],
    );
  }
}
