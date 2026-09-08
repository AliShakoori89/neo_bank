import 'package:flutter/material.dart';

Color getPackageColor(String packageTime) {
  switch (packageTime) {
    case 'روزانه':
      return Colors.orange;
    case 'شبانه':
      return Colors.indigo;
    case 'ترکیبی':
      return Colors.purple;
    case 'مناسبتی':
      return Colors.red;
    default:
      return Colors.teal;
  }
}