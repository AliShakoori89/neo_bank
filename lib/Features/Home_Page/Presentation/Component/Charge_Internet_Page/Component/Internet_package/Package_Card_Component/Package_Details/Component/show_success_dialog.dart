import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../../../../Data/Model/internet_package_model.dart';

void showSuccessDialog(BuildContext context, String? resultMessage, InternetPackage package, String? selectedWalletTitle, String phoneNumber) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Column(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 16),
            Text('پرداخت موفق'),
          ],
        ),
        content: Text(
          'بسته ${package.packageTime} با موفقیت خریداری شد.\n'
              'شماره پیگیری: ${resultMessage ?? "---"}\n'
              'کیف پول: $selectedWalletTitle\n'
              'پیامک تأیید به شماره ${phoneNumber.toPersianDigit()} ارسال می‌شود.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/main_page');
            },
            child: const Text('باشه'),
          ),
        ],
      );
    },
  );
}