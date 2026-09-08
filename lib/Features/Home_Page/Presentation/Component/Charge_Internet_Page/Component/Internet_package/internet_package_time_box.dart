import 'package:flutter/material.dart';

import '../../../../../../../Core/Theme/app_colors.dart';

class InternetPackageTimeBox extends StatelessWidget {
  const InternetPackageTimeBox({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.splashGradiantColor2  // رنگ در حالت انتخاب شده
              : Colors.grey.shade200.withAlpha(20), // رنگ در حالت عادی
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(
            color: AppColors.splashGradiantColor2,
            width: 1.5,
          )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.white  // رنگ متن در حالت انتخاب شده
                : theme.colorScheme.onPrimary,  // رنگ متن در حالت عادی
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}