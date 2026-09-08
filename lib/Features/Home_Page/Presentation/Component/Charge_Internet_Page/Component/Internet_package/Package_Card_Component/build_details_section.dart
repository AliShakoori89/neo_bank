import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../Data/Model/internet_package_model.dart';
import 'build_detail_row.dart';
import 'format_traffic.dart';

Widget buildDetailsSection(BuildContext context, InternetPackage package, String phoneNumber) {
  final theme = Theme.of(context);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: theme.cardColor.withAlpha(5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: theme.colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'جزئیات بسته',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const Divider(height: 24),

        buildDetailRow(
          context,
          icon: Icons.data_usage,
          title: 'حجم ترافیک',
          value: formatTraffic(package.traffic),
        ),

        if (package.nightTraffic.isNotEmpty)
          buildDetailRow(
            context,
            icon: Icons.nightlight_round,
            title: 'ترافیک شبانه',
            value: formatTraffic(package.nightTraffic),
          ),

        buildDetailRow(
          context,
          icon: Icons.access_time,
          title: 'مدت اعتبار',
          value: '${package.duration.toPersianDigit()} روز',
        ),

        buildDetailRow(
          context,
          icon: Icons.phone_android,
          title: 'شماره مقصد',
          value: phoneNumber.toPersianDigit(),
        ),
      ],
    ),
  );
}
