import 'package:flutter/material.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/package_icon.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../Data/Model/internet_package_model.dart';
import 'format_price.dart';
import 'get_package_color.dart';

Widget buildMainPackageCard(BuildContext context, InternetPackage package) {

  final theme = Theme.of(context);
  final packageTime = package.packageTime;

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          getPackageColor(packageTime).withAlpha(30),
          getPackageColor(packageTime).withAlpha(10),
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: getPackageColor(packageTime).withAlpha(30),
        width: 1.5,
      ),
    ),
    child: Column(
      children: [
        // آیکون بزرگ
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: getPackageColor(packageTime).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            getPackageIcon(packageTime),
            color: getPackageColor(packageTime),
            size: 60,
          ),
        ),
        AppSpace.heightSpace_16,

        // عنوان بسته
        Text(
          packageTime,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        AppSpace.heightSpace_8,

        // قیمت
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              formatPrice(package.price).toPersianDigit(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.splashGradiantColor2,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'تومان',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),

        // قیمت قبل از تخفیف (اگر تخفیف دارد)
        if (package.price != package.priceWithTax)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '${formatPrice(package.priceWithTax).toPersianDigit()} تومان',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
      ],
    ),
  );
}
