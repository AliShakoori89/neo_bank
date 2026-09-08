import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../../../Core/Theme/app_colors.dart';

class Circle3 extends StatelessWidget {
  const Circle3({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 250,
      top: 150,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 16.1, sigmaY: 16.1),
        child: Container(
          width: 195,
          height: 195,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.splashGradiantColor2.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
