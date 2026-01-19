import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/card_balance.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/card_header.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards/card_number_and_date.dart';

/// 🔹 کارت بانکی
Widget buildBankCard(CardDataModel card) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE0E0E0), // رنگ دلخواه border
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          color: AppColors.splashGradiantColor2.withValues(alpha: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
          child: Column(
            children: [
              buildCardHeader(),
              const Spacer(),
              buildCardNumberAndDate(card),
              AppSpace.heightSpace_12,
              buildCardBalance(card),
            ],
          ),
        ),
      ),
      // 🔹 لایه اول (gradient سیاه)
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(
              109.8 * (3.1415926 / 180),
            ), // تبدیل درجه به رادیان
            colors: [
              Color.fromRGBO(0, 0, 0, 0.016),
              Color.fromRGBO(0, 0, 0, 0.08),
            ],
            stops: [0.0011, 1.0011], // معادل درصدها در CSS
          ),
        ),
      ),

      // 🔹 لایه دوم (gradient سفید)
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(111.42 * (3.1415926 / 180)),
            colors: [
              Color.fromRGBO(255, 255, 255, 0.06),
              Color.fromRGBO(255, 255, 255, 0.0),
            ],
            stops: [0.0, 0.9998],
          ),
        ),
      ),
    ],
  );
}
