import 'package:flutter/material.dart';

class BankInfo {
  final String name;
  final String code;
  final Color color;
  final IconData? icon; // آیکون Material (اختیاری)
  final String? imageAsset; // آدرس تصویر سفارشی

  const BankInfo(
      this.name,
      this.code,
      this.color, {
        this.icon,
        this.imageAsset,
      });
}