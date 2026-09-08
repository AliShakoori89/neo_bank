import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Text(
      phoneNumber.toPersianDigit(),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
