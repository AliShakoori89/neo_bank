import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomDropDownShimmer extends StatelessWidget {
  const CustomDropDownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.circleBorderColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer(
        duration: Duration(seconds: 1), //Default value
        interval: Duration(
          microseconds: 1,
        ), //Default value: Duration(seconds: 0)
        //Default value
        colorOpacity: 5, //Default value
        enabled: true, //Default value
        direction: ShimmerDirection.fromLTRB(), //Default Value
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
