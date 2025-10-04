import 'package:flutter/material.dart';

import '../../../../Core/Const/app_colors.dart';

class CardCustomColumn extends StatelessWidget {
  const CardCustomColumn({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return value != '' ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.homePageCardTitleColor
          ),
        ),
        Text(value)
      ],
    )
        : Center(
      child: Text(title,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.homePageCardTitleColor
        ),
      ),
    );
  }
}
