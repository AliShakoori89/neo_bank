import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';

import '../../../../Core/Const/app_colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 56,
              width: 56,
              child: SvgPicture.asset('assets/svg/Background_color.svg',
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.surfaceTint,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.splashGradiantColor1,
                    shape: BoxShape.circle
                ),
                child: Center(
                  child: SvgPicture.asset(
                    imagePath,
                  ),
                )
            )
          ],
        ),
        AppSpace.heightSpace_8,
        Text('شارژ و اینترنت',
          style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.surfaceBright,
              fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }
}
