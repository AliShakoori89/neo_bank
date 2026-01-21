import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._();

  static void errorTop(BuildContext context, String message) {
    _showTop(context, message: message, backgroundColor: Colors.red);
  }

  static void successTop(BuildContext context, String message) {
    _showTop(context, message: message, backgroundColor: Colors.green);
  }

  static void _showTop(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.clearMaterialBanners();

    messenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.justify,
        ),
        leading: const Icon(Icons.info, color: Colors.white),
        actions: const [SizedBox()],
        padding: EdgeInsets.all(20),
      ),
    );

    Future.delayed(duration, () {
      messenger.hideCurrentMaterialBanner();
    });
  }
}
