import 'package:flutter/material.dart';
import '../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../../../Data/Model/card_list_model.dart';
import '../../Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/card_balance.dart';
import '../../Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/card_header.dart';
import '../../Bank_Cards_Slider/Bank_Cards/Bank_Card_Component/card_number_and_date.dart';

class CustomSelectorCard extends StatelessWidget {
  const CustomSelectorCard({super.key, required this.theme, required this.isSelected, required this.onTap, required this.bankCard});

  final ThemeData theme;
  final bool isSelected;
  final VoidCallback onTap;
  final CardDataModel bankCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding:EdgeInsets.only(
                right: 15
            ),
            child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: isSelected ? AppColors.splashGradiantColor1 : Colors.grey,
                        width: 2
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected ? AppColors.splashGradiantColor1 : Colors.grey.withAlpha(70),
                  ),
                    margin: EdgeInsets.only(
                        right: 15,
                        left: 3,
                        bottom: 3,
                        top: 3
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.splashGradiantColor2.withValues(alpha: 0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                        child: Column(
                          children: [
                            buildCardHeader(),
                            AppSpace.heightSpace_32,
                            buildCardNumberAndDate(bankCard),
                            CardBalanceWidget(balance: bankCard.availableBalance!),
                          ],
                        ),
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 20,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimaryFixed,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isSelected ? AppColors.splashGradiantColor1 : Colors.grey,
                      width: 2
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: isSelected ? AppColors.splashGradiantColor1 : theme.colorScheme.onPrimaryFixed,
                      shape: BoxShape.circle
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
