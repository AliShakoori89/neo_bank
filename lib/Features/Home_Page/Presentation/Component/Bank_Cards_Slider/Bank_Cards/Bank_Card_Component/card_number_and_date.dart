import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../Core/Theme/app_colors.dart';

Widget buildCardNumberAndDate(card) {
  final date = DateTime.parse(card.expireDate!.toString());

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SizedBox(
      width: 272,
      height: 20,
      child: Row(
        children: [
          Text(
            card.pan.toString().replaceAllMapped(
              RegExp(r".{1,4}"),
              (match) => "${match.group(0)} ".toPersianDigit(),
            ),
            textDirection: TextDirection.ltr,
            style: const TextStyle(
              color: AppColors.appWhite,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '${date.month.toString().padLeft(2, '0')}/${(date.year % 100).toString().padLeft(2, '0')}'
                .toPersianDigit(),
            style: const TextStyle(
              color: AppColors.appWhite,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
