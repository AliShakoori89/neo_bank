import 'package:flutter/material.dart';

IconData getPackageIcon(String packageTime) {
  switch (packageTime) {
    case 'روزانه':
      return Icons.wb_sunny;
    case 'شبانه':
      return Icons.nightlight_round;
    case 'ترکیبی':
      return Icons.compare_arrows;
    case 'مناسبتی':
      return Icons.celebration;
    default:
      return Icons.wifi;
  }
}
