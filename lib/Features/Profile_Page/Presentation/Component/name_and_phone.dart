import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../Core/Spacing/app_space.dart';

class NameAndPhone extends StatelessWidget {
  const NameAndPhone({
    super.key,
    required this.userName,
    required this.mobileNumber,
  });

  final String userName;
  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        AppSpace.heightSpace_12,
        Text(
          mobileNumber.toPersianDigit(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
