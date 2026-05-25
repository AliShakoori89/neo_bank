import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';

void showErrorDialog(BuildContext context, String error, {int? errorCode}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('خطا در پرداخت'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(error),
            if (errorCode != null) ...[
              const SizedBox(height: 8),
              Text(
                'کد خطا: $errorCode',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
            if (errorCode == 5001) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '⚠️ خطا در سرویس خرید شارژ. لطفاً چند دقیقه دیگر مجدد تلاش کنید.',
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ),
            ],
            if (errorCode == 5002) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '⚠️ موجودی کیف پول کافی نمی‌باشد.',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              context.read<InternetPackageBloc>().add(ResetBuyStatus());
            },
            child: const Text('باشه'),
          ),
        ],
      );
    },
  );
}