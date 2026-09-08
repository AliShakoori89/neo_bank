import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Utils/Formatters/persian_date_format_h.dart';
import '../../../../Core/Utils/Formatters/persian_date_format_y_m_d.dart';

class TransactionInfo extends StatelessWidget {
  final dynamic item;

  const TransactionInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.actionDescription ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            AppSpace.heightSpace_4,
            Text(
              formatPersianDateH(item.date.toString()),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.transferAmount.toString().seRagham().toPersianDigit(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
                AppSpace.widthSpace_5,
                Text(
                  'ریال',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ],
            ),
            AppSpace.heightSpace_4,
            Text(
              formatPersianDateYMD(item.date.toString()),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}