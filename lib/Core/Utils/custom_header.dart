import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Const/app_colors.dart';

Widget customHeader(Widget widget) {
  return Container(
    height: 90,
    width: double.infinity,
    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
    decoration: BoxDecoration(
      color: AppColors.appWhite,
      border: Border(bottom: BorderSide(
        color: AppColors.homePageDividerColor
      ))
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          widget,
          const Spacer(),
          SvgPicture.asset('assets/svg/search-md.svg'),
        ],
      ),
    ),
  );
}
