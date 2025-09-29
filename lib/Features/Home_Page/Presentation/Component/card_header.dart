import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Const/app_colors.dart';

Widget buildCardHeader() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
  child: Row(
    children: [
      SizedBox(
        width: 94,
        height: 24,
        child: SvgPicture.asset(
          'assets/svg/Union.svg',
          colorFilter:
          const ColorFilter.mode(AppColors.appWhite, BlendMode.srcIn),
        ),
      ),
      const Spacer(),
      Image.asset('assets/logo/Logomark.png',
          width: 27, height: 25, color: AppColors.appWhite),
    ],
  ),
);
