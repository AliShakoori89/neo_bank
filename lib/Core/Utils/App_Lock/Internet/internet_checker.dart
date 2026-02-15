import 'dart:io';
import 'package:flutter/material.dart';

class InternetChecker {
  static Future<bool> checkInternet({
    required BuildContext context,
    required VoidCallback onSuccess, // برای ریفرش
  }) async {
    bool hasInternet = false;

    try {

      final request = await HttpClient()
          .getUrl(Uri.parse("https://clients3.google.com/generate_204"))
          .timeout(const Duration(seconds: 3));

      final response = await request.close()
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 204) {
        hasInternet = true;
      }

    } catch (_) {
      hasInternet = false;
    }

    if (!hasInternet) {
      _showNoInternetDialog(
        context: context,
        onSuccess: onSuccess,
      );
    }

    return hasInternet;
  }

  static void _showNoInternetDialog({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          alignment: Alignment.topCenter,
          backgroundColor: Colors.transparent, // تا فقط کانتینر رنگ داشته باشه
          child: Container(
            width: double.infinity, // عرض کامل صفحه
            height: 60,
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.red.shade600.withAlpha((0.85 * 255).toInt()),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    'اتصال اینترنت برقرار نیست!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(ctx).pop();

                    final connected = await checkInternet(
                      context: context,
                      onSuccess: onSuccess,
                    );

                    if (connected) {
                      onSuccess(); // ← رفرش انجام میشه
                    }
                  },
                  child: const Text(
                    'تلاش مجدد',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
