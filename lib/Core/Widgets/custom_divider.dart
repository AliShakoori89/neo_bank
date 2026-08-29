import 'package:flutter/material.dart';
import '../Theme/app_colors.dart';

Widget divider() => const Padding(
  padding: EdgeInsets.symmetric(vertical: 8),
  child: Divider(height: 1, color: AppColors.homePageDividerColor),
);