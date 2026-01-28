import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/App_Lock/app_lock_service.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/navigator_key.dart';

class AppLockObserver extends StatefulWidget {
  final Widget child;
  const AppLockObserver({super.key, required this.child});

  @override
  State<AppLockObserver> createState() => _AppLockObserverState();
}

class _AppLockObserverState extends State<AppLockObserver>
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
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

      if (shouldLock) {
        debugPrint('🚨 LOCK NAVIGATION');
        rootNavigatorKey.currentContext?.go('/local_login_page');
      } else {
        debugPrint('✅ no lock needed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // همونی که گفتی 👌
  }
}
