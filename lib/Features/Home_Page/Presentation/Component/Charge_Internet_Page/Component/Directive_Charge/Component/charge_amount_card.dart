import 'package:flutter/material.dart';

import '../../../../../../../../Core/Theme/app_colors.dart';

class ChargeAmountCard extends StatelessWidget {
  const ChargeAmountCard({
    super.key,
    required this.amount,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String amount;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.loginPageIconColor,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? color.withAlpha(10) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            '$amount تومان',
            style: TextStyle(
              color: isSelected ? color : AppColors.loginPageIconColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}