import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../Core/Const/app_colors.dart';
import '../../../../../Core/Const/app_space.dart';

Widget buildCardBalance(card) {
  final availableBalance = card.availableBalance;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(71),
      gradient: LinearGradient(
        colors: [
          const Color.fromRGBO(250, 250, 250, 0.03).withAlpha(0),
          const Color.fromRGBO(250, 250, 250, 0.15).withAlpha(50),
        ],
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        const Icon(
          Icons.remove_red_eye_outlined,
          color: AppColors.appWhite,
          size: 20,
        ),
        AppSpace.widthSpace_12,
        Text(
          availableBalance.toString().seRagham().toPersianDigit(),
          style: const TextStyle(
            color: AppColors.appWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpace.widthSpace_5,
        const Text(
          'ریال',
          style: TextStyle(
            color: AppColors.appWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
