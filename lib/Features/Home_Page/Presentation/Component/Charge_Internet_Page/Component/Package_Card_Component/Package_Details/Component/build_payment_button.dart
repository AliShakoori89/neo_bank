import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../../../../../Core/Const/app_colors.dart';
import '../../format_price.dart';

Widget buildPaymentButton(BuildContext context, bool isLoading, Future<void> Function() handlePayment, int? priceWithTax) {
  final theme = Theme.of(context);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: theme.colorScheme.onPrimaryFixed,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(5),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    child: SafeArea(
      child: ElevatedButton(
        // حذف شرط _selectedWalletAddress == null
        onPressed: isLoading ? null : handlePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.splashGradiantColor2,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.payment, size: 20),
            const SizedBox(width: 8),
            Text(
              'پرداخت ${formatPrice(priceWithTax).toPersianDigit()} تومان',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}