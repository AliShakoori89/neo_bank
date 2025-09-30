import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';

import '../../../../Core/Const/app_colors.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.iconPath,
    required this.iconName,
  });

  final String iconPath;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.loginBorderColor),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(10, 13, 18, 0.10),
                        offset: const Offset(0, -2),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: const Color.fromRGBO(10, 13, 18, 0.05),
                        offset: const Offset(1, 8),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        color: const Color.fromRGBO(10, 13, 18, 0.10),
                        offset: const Offset(0, 3),
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        color: const Color.fromRGBO(10, 13, 18, 0.10),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.08)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        AppColors.customHeaderTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSpace.heightSpace_8,
          Flexible(
            child: Text(
              iconName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.customHeaderTextColor,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
