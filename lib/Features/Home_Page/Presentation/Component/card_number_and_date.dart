import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Const/app_colors.dart';

Widget buildCardNumberAndDate(Map<String, String> card) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 5),
  child: Row(
    children: [
      Text(
        (card['card_number'] ?? '').replaceAllMapped(
          RegExp(r".{1,4}"),
              (match) => "${match.group(0)} ".toPersianDigit(),
        ),
        style: const TextStyle(color: AppColors.appWhite, fontSize: 14),
      ),
      const Spacer(),
      Text('${card['card_expire_date']}'.toPersianDigit(),
          style: const TextStyle(color: AppColors.appWhite, fontSize: 14)),
    ],
  ),
);
