import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomDropDownShimmer extends StatelessWidget {
  const CustomDropDownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.circleBorderColor,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: const BoxConstraints(minWidth: 320, minHeight: 40),
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
