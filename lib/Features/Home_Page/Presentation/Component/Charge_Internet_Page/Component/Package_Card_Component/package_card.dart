import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Package_Card_Component/package_icon.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../../../Core/Const/app_colors.dart';
import '../../../../../Data/Model/internet_package_model.dart';
import 'format_price.dart';
import 'format_traffic.dart';
import 'get_package_color.dart';
import 'info_chip.dart';

Widget buildPackageCard(BuildContext context, InternetPackageModel package, int index, String destinationPhoneNumber, int selectedOperator) {
  final theme = Theme.of(context);

  // استخراج اطلاعات از package
  String? packageTime = package.packageTime;
  String rawTraffic = package.traffic ?? '0';  // مقدار خام
  String? rawNightTraffic = package.nightTraffic?.toString();
  String duration = package.duration ?? '';
  String price = formatPrice(package.price);
  String priceWithTax = formatPrice(package.priceWithTax);
  String description = package.description ?? '';

  // فرمت کردن برای نمایش
  String formattedTraffic = formatTraffic(rawTraffic);
  String? formattedNightTraffic = rawNightTraffic != null ? formatTraffic(rawNightTraffic) : null;

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color:  theme.cardColor.withAlpha(10),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        width: 1,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.push(
            '/internet_package_details_page',
            extra: {
              'package': package,
              'phoneNumber': destinationPhoneNumber, // شماره تلفن کاربر
              'operatorCode': selectedOperator, // کد اپراتور
            },
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // هدر: نوع بسته و قیمت
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // آیکون و نوع بسته
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.darkModeIconIconColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      getPackageIcon(packageTime!),
                      color: getPackageColor(packageTime),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          packageTime,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // قیمت
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${price.toPersianDigit()} تومان',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.splashGradiantColor2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${priceWithTax.toPersianDigit()} تومان',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  buildInfoChip(
                    context: context,
                    icon: Icons.data_usage,
                    label: formattedTraffic,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                  buildInfoChip(
                    context: context,
                    icon: Icons.access_time,
                    label: '$duration روزه',
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                  if (formattedNightTraffic != null) ...[
                    buildInfoChip(
                      context: context,
                      icon: Icons.nightlight_round,
                      label: 'شبانه: $formattedNightTraffic',
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
