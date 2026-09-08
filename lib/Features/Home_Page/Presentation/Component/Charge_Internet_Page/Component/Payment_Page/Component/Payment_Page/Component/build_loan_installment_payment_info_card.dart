import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../../../../Core/Spacing/app_space.dart';

Widget buildLoanInstallmentPaymentInfoCard(
    BuildContext context,
    ThemeData theme,
    String title,
    String amount,
    ) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.green.withAlpha(30),
          Colors.green.withAlpha(10),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.green.withAlpha(40),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.green,
                size: 25,
              ),
            ),

            AppSpace.widthSpace_8,

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: theme.colorScheme.primaryFixed,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        AppSpace.heightSpace_16,

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ قسط:',
                style: TextStyle(
                  color: theme.colorScheme.primaryFixed,
                  fontSize: 14,
                ),
              ),

              Text(
                '${amount.toString().seRagham().toPersianDigit()} تومان',
                style: TextStyle(
                  color: theme.colorScheme.primaryFixed,
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