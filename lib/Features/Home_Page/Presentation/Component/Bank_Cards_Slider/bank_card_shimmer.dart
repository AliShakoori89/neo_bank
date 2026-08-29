import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_colors.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/Component/circle_1.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/Component/circle_2.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Bank_Cards_Slider/Card_Box_Background_UI/Component/circle_3.dart';
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
        Circle1(),

        /// Circle 2
        Circle2(),

        /// Circle 3
        Circle3(),

        Padding(
          padding: const EdgeInsets.only(top: 30, left: 45, right: 45),
          child: SizedBox(
            width: double.infinity,
            height: 192,
            child: Shimmer(
              interval: Duration(
                microseconds: 100,
              ), //Default value: Duration(seconds: 0)
              color: Colors.white, //Default value
              colorOpacity: 0.5, //Default value
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
