import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../../Data/Model/internet_package_model.dart';
import '../../../../Internet_package/Package_Card_Component/get_package_color.dart';

Widget buildChargePackagePaymentInfoCard(BuildContext context, ThemeData theme, InternetPackage package, String title, String amount) {

  final packageTime = package.packageTime;

  return Container(
    padding: const EdgeInsets.all(16),
    margin: EdgeInsets.only(
        right: 20,
        left: 20
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          getPackageColor(packageTime).withAlpha(30),
          getPackageColor(packageTime).withAlpha(10),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.payment, color: Theme.of(context).colorScheme.onPrimary, size: 28),
            AppSpace.widthSpace_8,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        if (package.description.isNotEmpty) ...[
          AppSpace.heightSpace_12,
          Text(
            package.description,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
        AppSpace.heightSpace_16,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ قابل پرداخت:',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 14),
              ),
              Text(
                '${amount.toString().seRagham().toPersianDigit()} تومان',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
