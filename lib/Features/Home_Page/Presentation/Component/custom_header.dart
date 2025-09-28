import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Utils/neo_bank_logo.dart';

Widget buildHeader() {
  return Container(
    height: 90,
    width: double.infinity,
    color: AppColors.appWhite,
    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          NeoBankLogo(
            logoColor: AppColors.splashGradiantColor1,
            width: 88,
            height: 24,
            logoHeight: 20,
            logoWidth: 62,
            space: 4,
          ),
          const Spacer(),
          SvgPicture.asset('assets/svg/search-md.svg'),
        ],
      ),
    ),
  );
}