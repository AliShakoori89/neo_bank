import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Spacing/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Balanc_visibility/balanc_visibility.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/card_balance.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/card_header.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/card_number_and_date.dart';
import '../../../../../../Core/DI/injection_container.dart';
import '../../../../Domain/Entities/card_list_entity.dart';

/// 🔹 کارت بانکی
Widget buildBankCard(CardEntity card) {
  return BlocProvider(
    create: (_) => sl<BalanceVisibilityCubit>(),
    child: Stack(
      children: [
        // کارت اصلی
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.splashGradiantColor2.withValues(alpha: 0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
            child: Column(
              children: [
                buildCardHeader(),
                AppSpace.heightSpace_32,
                buildCardNumberAndDate(card),
                CardBalanceWidget(balance: card.availableBalance!),
              ],
            ),
          ),
        ),

        // 🔹 گرادینت سیاه (بدون گرفتن تاچ)
        IgnorePointer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(109.8 * (3.1415926 / 180)),
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.016),
                  Color.fromRGBO(0, 0, 0, 0.08),
                ],
                stops: [0.0011, 1.0011],
              ),
            ),
          ),
        ),

        // 🔹 گرادینت سفید (بدون گرفتن تاچ)
        IgnorePointer(
          child: Container(
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
        ),
      ],
    ),
  );
}
