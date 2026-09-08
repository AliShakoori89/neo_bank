import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../custom_linear_gradient.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.imagePath, required this.serviceName});

  final String imagePath;
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:
                      Theme.of(context).colorScheme.tertiaryFixed ==
                          const Color(0xFFFFFFFF)
                      ? [
                          const Color(0xFFD0F8AB),
                          const Color(0xFFF3FEE7).withAlpha(0),
                          const Color(0xFFF3FEE7).withAlpha(0),
                        ]
                      : [
                          const Color(0xFFD0F8AB),
                          const Color(0xFF2B5314).withAlpha(0),
                          const Color(0xFF2B5314).withAlpha(0),
                        ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(1), // ضخامت بوردر
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: customLinearGradient(context),
                ),
              ),
            ),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: AppColors.splashGradiantColor1,
                shape: BoxShape.circle,
              ),
              child: Center(child: SvgPicture.asset(imagePath, color: Colors.white,)),
            ),
          ],
        ),
        AppSpace.heightSpace_8,
        Text(
          serviceName,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.surfaceBright,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
