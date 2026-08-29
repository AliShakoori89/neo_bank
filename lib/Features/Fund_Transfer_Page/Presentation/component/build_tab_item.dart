import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Spacing/app_space.dart';

Widget buildTabItem(
    BuildContext context, {
      required String iconPath,
      required String title,
      required bool isSelected,
    }) {
  final Color iconColor =
  isSelected ? AppColors.splashGradiantColor2 : AppColors.loginPageIconColor;

  return SizedBox(
    width: 60,
    height: 72,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            iconPath,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        AppSpace.heightSpace_4,
        Text(
          title,
          style: TextStyle(
            color: iconColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
