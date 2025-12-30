import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget customHeader(BuildContext context, Widget widget) {
  return Container(
    height: 92,
    width: double.infinity,
    padding: const EdgeInsets.only(
      top: 40, // spacing-5xl (مثلاً)
      right: 24, // spacing-3xl
      bottom: 16, // spacing-lg
      left: 24, // spacing-3xl
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).appBarTheme.backgroundColor,
      border: Border(
        bottom: BorderSide(
          color: Theme.of(context).colorScheme.surfaceDim,
          width: 1,
        ),
      ),
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          widget,
          const Spacer(),
          SvgPicture.asset(
            'assets/svg/search-md.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).appBarTheme.iconTheme!.color!,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    ),
  );
}
