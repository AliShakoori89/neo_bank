import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class NeoBankVersion extends StatelessWidget {
  const NeoBankVersion({super.key, required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text('نسخه ${'1.0'.toPersianDigit()}', style: TextStyle(color: textColor));
  }
}
