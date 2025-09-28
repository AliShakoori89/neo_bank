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
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
              color: Color(0xffA5F0FC),
              shape: BoxShape.circle
          ),
          child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.splashGradiantColor1,
                  shape: BoxShape.circle
              ),
              child: Center(
                child: SvgPicture.asset(
                  imagePath,
                ),
              )
          ),
        ),
        AppSpace.heightSpace_8,
        Text('شارژ و اینترنت',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }
}
