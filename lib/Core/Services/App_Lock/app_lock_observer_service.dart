import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/Biometric_Service/biometric_service.dart';
import 'app_lock_service.dart';
import 'navigator_key.dart';

class AppLockObserverService extends StatefulWidget {
  final Widget child;
  const AppLockObserverService({super.key, required this.child});

  @override
  State<AppLockObserverService> createState() => _AppLockObserverServiceState();
}

class _AppLockObserverServiceState extends State<AppLockObserverService>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint('🟢 AppLockObserver init');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint('🔴 AppLockObserver dispose');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint('🔄 lifecycle = $state');

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      debugPrint('📌 -> App goes BACKGROUND');
      AppLockService.onBackground();
    }

    if (state == AppLifecycleState.resumed) {
      debugPrint('▶️ -> App RESUMED');

      final shouldLock = AppLockService.shouldLock();
      debugPrint('🔐 shouldLock = $shouldLock');

      if (!shouldLock) {
        debugPrint('✅ no lock needed');
        return;
      }

      // --- STEP 1: Check if biometric is enabled ---
      final prefs = await SharedPreferences.getInstance();
      final biometricEnabled = prefs.getBool('biometric_enabled') ?? false;

      if (biometricEnabled) {
        debugPrint('🟢 Biometric is enabled, trying authentication...');
        final success = await BiometricService().authenticate(true);

        if (success) {
          debugPrint('✅ Biometric success, unlock app');
          return; // اجازه ورود بدون نشان دادن local login
        } else {
          debugPrint('❌ Biometric failed, fallback to local login');
        }
      }

      // --- STEP 2: Fallback to local login page ---
      debugPrint('🚨 LOCK NAVIGATION');

      rootNavigatorKey.currentContext?.go('/local_login_page');

    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // همونی که گفتی 👌
  }
}
