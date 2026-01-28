import 'package:flutter/material.dart';

class AppLockService {
  static DateTime? _backgroundAt;
  static const int lockAfterSeconds = 5;

  static void onBackground() {
    if (_backgroundAt == null) {
      _backgroundAt = DateTime.now();
      debugPrint('🕒 backgroundAt = $_backgroundAt');
    }
  }

  static bool shouldLock() {
    if (_backgroundAt == null) {
      debugPrint('⚠️ backgroundAt is null');
      return false;
    }

    final diff = DateTime.now().difference(_backgroundAt!);
    debugPrint('⏱ diff = ${diff.inSeconds}s');

    // بعد از resume ریست کن
    _backgroundAt = null;

    return diff.inSeconds >= lockAfterSeconds;
  }
}
