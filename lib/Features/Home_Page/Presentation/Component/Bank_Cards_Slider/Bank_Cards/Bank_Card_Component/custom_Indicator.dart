import 'package:flutter/material.dart';
import '../../../../../../../Core/Theme/app_colors.dart';

Widget buildIndicator(int length, int currentIndex) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, top: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(length, (index) {
        final isActive = currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 42 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.appWhite
                : AppColors.splashGradiantColor1,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }),
    ),
  );
}
