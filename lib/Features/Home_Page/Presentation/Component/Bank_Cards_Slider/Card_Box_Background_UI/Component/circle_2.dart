import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../../../Core/Theme/app_colors.dart';

class Circle2 extends StatefulWidget {
  const Circle2({super.key});

  @override
  State<Circle2> createState() => _Circle2State();
}

class _Circle2State extends State<Circle2> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 100,
      top: -250,
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
