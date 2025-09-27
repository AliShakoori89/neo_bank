import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure to import this
import '../Const/app_colors.dart';

class NeoBankLogo extends StatelessWidget {
  NeoBankLogo({super.key, required this.logoColor, this.width, this.height, this.logoHeight, this.logoWidth, this.space});

  final Color logoColor;
  double? width;
  double? height;
  double? logoHeight;
  double? logoWidth;
  double? space;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset(
              'assets/logo/Logomark.png',
              color: logoColor,
            ),
          ),
          SizedBox(width: space),
          SizedBox(
            width:  logoWidth ?? 31.66,
            height:  logoHeight ?? 37.99,
            child: SvgPicture.asset('assets/svg/Union.svg', color: logoColor,),
          )

        ],
      ),
    );
  }
}
