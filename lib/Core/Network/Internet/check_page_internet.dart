import 'dart:io';
import 'package:flutter/material.dart';

import '../../Widgets/app_snack_bar_with_button.dart';

class InternetChecker {

  /// ===============================
  /// 🔹 متد خالص چک اینترنت (بدون UI)
  /// ===============================
  static Future<bool> hasConnection() async {
    try {
      final request = await HttpClient()
          .getUrl(Uri.parse("http://10.170.1.27:9000/swagger/index.html"))
          .timeout(const Duration(seconds: 5));

      final response =
      await request.close().timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// ===============================
  /// 🔹 متد اصلی که تصمیم میگیره دیالوگ نشون بده
  /// ===============================
  static Future<bool> checkPageInternet({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {

    final connected = await hasConnection();

    if (!context.mounted) return connected;

    if (!connected) {
      _showNoInternetDialog(
        context: context,
        onSuccess: onSuccess,
      );
    }

    return connected;
  }

  /// ===============================
  /// 🔹 دیالوگ عدم اتصال
  /// ===============================
  static void _showNoInternetDialog({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {

        bool isLoading = false; // ✅ فقط یکبار تعریف شده

        return StatefulBuilder(
          builder: (context, setState) {

            Future<void> handleRetry() async {
              if (isLoading) return;

              setState(() => isLoading = true);

              final results = await Future.wait([
                hasConnection(), // ✅ فقط چک خالص
                Future.delayed(const Duration(seconds: 3)), // ⏳ فرمالیته
              ]);

              final connected = results[0] as bool;

              if (connected) {
                Navigator.of(ctx).pop();
                onSuccess();
              } else {
                setState(() => isLoading = false);
              }
            }

            return AppSnackBarWithButton(
                errorText: 'اتصال اینترنت برقرار نیست!',
                isLoading: isLoading,
                handleRetry: handleRetry);
          },
        );
      },
    );
  }
}
