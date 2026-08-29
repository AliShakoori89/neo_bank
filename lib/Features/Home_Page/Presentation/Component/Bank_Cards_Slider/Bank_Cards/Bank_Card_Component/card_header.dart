import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../Core/Theme/app_colors.dart';

Widget buildCardHeader() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
  child: SizedBox(
    height: 32,
    width: 272,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 4,
          ),
          child: SizedBox(
            width: 94,
            height: 24,
            child: SvgPicture.asset(
              'assets/svg/Union.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.appWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Image.asset(
            'assets/logo/Logomark.png',
            width: 27,
            height: 25,
            color: AppColors.appWhite,
          ),
        ),
      ],
    ),
  ),
);
