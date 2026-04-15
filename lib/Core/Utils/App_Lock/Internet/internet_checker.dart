import 'dart:io';
import 'package:flutter/material.dart';

class InternetChecker {

  /// ===============================
  /// 🔹 متد خالص چک اینترنت (بدون UI)
  /// ===============================
  static Future<bool> hasConnection() async {
    try {
      final request = await HttpClient()
          .getUrl(Uri.parse("https://www.tala.ir/favicon.ico"))
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
  static Future<bool> checkInternet({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {

    final connected = await hasConnection();

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

            return Dialog(
              alignment: Alignment.topCenter,
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade600.withOpacity(0.9),
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

                    GestureDetector(
                      onTap: handleRetry,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(
                              isLoading ? 0.2 : 0.35),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration:
                            const Duration(milliseconds: 200),
                            child: isLoading
                                ? const SizedBox(
                              key: ValueKey(1),
                              width: 18,
                              height: 18,
                              child:
                              CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              key: ValueKey(2),
                              'تلاش مجدد',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
