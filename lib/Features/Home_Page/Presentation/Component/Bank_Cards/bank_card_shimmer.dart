import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BankCardShimmer extends StatelessWidget {
  const BankCardShimmer({super.key});

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
        Positioned(
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
        ),

        /// Circle 2
        Positioned(
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
        ),

        /// Circle 3
        Positioned(
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
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30, left: 45, right: 45),
          child: Container(
            width: double.infinity,
            height: 192,
            constraints: const BoxConstraints(minWidth: 320, minHeight: 192),
            child: Shimmer(
              duration: Duration(seconds: 3), //Default value
              interval: Duration(
                seconds: 5,
              ), //Default value: Duration(seconds: 0)
              color: Colors.white, //Default value
              colorOpacity: 0, //Default value
              enabled: true, //Default value
              direction: ShimmerDirection.fromLTRB(), //Default Value
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
