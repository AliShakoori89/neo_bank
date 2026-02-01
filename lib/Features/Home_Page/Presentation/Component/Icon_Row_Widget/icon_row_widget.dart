import 'package:flutter/material.dart';

import 'custom_icon.dart';

Widget buildIconRow() {
  return SizedBox(
    height: 120,
    child: Padding(
      padding: EdgeInsets.only(right: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(width: 24),
        padding: const EdgeInsets.only(left: 24, top: 20),
        itemBuilder: (context, index) =>
            const CustomIcon(imagePath: 'assets/svg/simcard.svg'),
      ),
    ),
  );
}
