import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../../../Core/Theme/app_colors.dart';

class Circle1 extends StatelessWidget {
  const Circle1({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -220,
      top: 50,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 16.1, sigmaY: 16.1),
        child: Container(
          width: 383,
          height: 383,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.splashGradiantColor2.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
