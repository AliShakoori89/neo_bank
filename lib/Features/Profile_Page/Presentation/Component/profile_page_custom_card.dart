import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/profile_page_custom_icon.dart';

import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';
import 'card_custom_column.dart';

class ProfilePageCustomRow extends StatelessWidget {
  ProfilePageCustomRow({super.key, required this.iconPath, required this.title, this.value, required this.widget});

  final String iconPath;
  final String title;
  String? value;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ProfilePageCustomIcon(iconPath: iconPath),
            AppSpace.widthSpace_8,
            CardCustomColumn(title: title, value: value ?? '')
          ],
        ),
        widget
      ],
    );
  }
}
