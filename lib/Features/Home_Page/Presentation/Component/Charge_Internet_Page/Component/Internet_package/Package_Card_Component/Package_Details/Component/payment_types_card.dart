import 'package:flutter/material.dart';

import '../../../../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../../../../Core/Spacing/app_space.dart';

class PaymentTypesCard extends StatelessWidget {
  const PaymentTypesCard({
    super.key,
    required this.title,
    this.description,
    required this.isSelected,
    required this.onTap,

  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.splashGradiantColor1
                : Colors.grey.withAlpha(30),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? AppColors.splashGradiantColor1.withAlpha(10)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.splashGradiantColor1
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.splashGradiantColor1,
                  ),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.splashGradiantColor1
                          : theme.colorScheme.primaryFixed,
                    ),
                  ),
                  if (description != null) ...[
                    AppSpace.heightSpace_4,
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}