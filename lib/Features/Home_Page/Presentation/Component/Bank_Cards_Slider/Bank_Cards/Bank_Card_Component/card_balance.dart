import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../Core/Spacing/app_space.dart';
import '../../../../Bloc/Balanc_visibility/balanc_visibility.dart';

class CardBalanceWidget extends StatelessWidget {
  final int balance;

  const CardBalanceWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
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
      child: BlocBuilder<BalanceVisibilityCubit, bool>(
        builder: (context, isVisible) {
          return Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<BalanceVisibilityCubit>().toggle();
                },
                icon: Icon(
                  !isVisible
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.appWhite,
                  size: 20,
                ),
              ),
              AppSpace.widthSpace_12,
              Text(
                !isVisible
                    ? balance.toString().seRagham().toPersianDigit()
                    : '••••••',
                style: const TextStyle(
                  color: AppColors.appWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppSpace.widthSpace_5,
              const Text('ریال', style: TextStyle(color: AppColors.appWhite,
                fontSize: 16,
                fontWeight: FontWeight.w600,)),
            ],
          );
        },
      ),
    );
  }
}
