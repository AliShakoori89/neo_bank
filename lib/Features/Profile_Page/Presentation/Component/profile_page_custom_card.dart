import 'package:flutter/material.dart';
import 'package:neo_bank/Features/Profile_Page/Presentation/Component/profile_page_custom_icon.dart';
import '../../../../Core/Spacing/app_space.dart';
import 'card_custom_column.dart';

class ProfilePageCustomCard extends StatelessWidget {
  const ProfilePageCustomCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.value,
    required this.widget,
  });

  final String iconPath;
  final String title;
  final String? value;
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
            CardCustomColumn(title: title, value: value ?? ''),
          ],
        ),
        widget,
      ],
    );
  }
}
