import 'package:flutter/material.dart';

import '../../../../../../Core/Theme/app_colors.dart';
import 'Component/circle_1.dart';
import 'Component/circle_2.dart';
import 'Component/circle_3.dart';

class CardBoxBackground extends StatelessWidget {
  const CardBoxBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 268,
          color: AppColors.splashGradiantColor1,
        ),

        /// Circle 1
        Circle1(),

        /// Circle 2
        Circle2(),

        /// Circle 3
        Circle3(),
      ],
    );
  }
}
