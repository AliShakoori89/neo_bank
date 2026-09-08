import 'package:flutter/material.dart';
import '../../../../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../../../../Core/Spacing/app_space.dart';

customRow(String number, String text){
  return Container(
    margin: EdgeInsets.only(
        left: 20,
        right: 20
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.copy, color: AppColors.splashGradiantColor2),
            AppSpace.widthSpace_30,
            Icon(Icons.share, color: AppColors.splashGradiantColor2,)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(number.toString()),
            AppSpace.heightSpace_4,
            Text(text),
          ],
        ),
      ],
    ),
  );
}
