import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure to import this

class NeoBankLogo extends StatelessWidget {
  const NeoBankLogo({
    super.key,
    required this.logoColor,
    this.width,
    this.height,
    this.logoHeight,
    this.logoWidth,
    this.space,
  });

  final Color logoColor;
  final double? width;
  final double? height;
  final double? logoHeight;
  final double? logoWidth;
  final double? space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('assets/logo/Logomark.png', color: logoColor),
          ),
          SizedBox(width: space),
          SizedBox(
            width: logoWidth ?? 31.66,
            height: logoHeight ?? 37.99,
            child: SvgPicture.asset(
              'assets/svg/Union.svg',
              colorFilter: ColorFilter.mode(logoColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
