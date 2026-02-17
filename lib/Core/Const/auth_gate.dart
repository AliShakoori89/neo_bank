import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Features/Splash_Screen_Page/Presentation/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Features/Profile_Page/Presentation/Component/Biometric_Service/biometric_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final BiometricService _biometricService = BiometricService();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final localPass = await LocalStorage.read('local_password');
    final accessToken = await LocalStorage.read('access_token');
    final biometricEnabled = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getBool('biometric_enabled') ?? false);

    await Future.delayed(const Duration(milliseconds: 100)); // جلوگیری از flicker

    if (!mounted) return;

    if (accessToken != null && accessToken.isNotEmpty && accessToken != 'null') {
      if (localPass != null && localPass.isNotEmpty) {
        // اگه بیومتریک فعال بود، ابتدا احراز هویت بیومتریک
        if (biometricEnabled) {
          final success = await _biometricService.authenticate();
          if (!mounted) return;

          if (success) {
            // ورود موفق → مستقیم به صفحه اصلی
            GoRouter.of(context).go('/main_page'); // صفحه اصلی اپ
            return;
          } else {
            // اگه فینگرپرینت ناموفق بود، fallback روی پسورد
            GoRouter.of(context).go('/local_login_page');
            return;
          }
        } else {
          // بیومتریک فعال نبود → صفحه پسورد
          GoRouter.of(context).go('/local_login_page');
          return;
        }
      } else {
        // اگه پسورد محلی نبود → تنظیم پسورد
        GoRouter.of(context).go('/set_pass_page');
        return;
      }
    } else {
      // توکن نبود → صفحه لاگین
      print('// توکن نبود → صفحه لاگین');
      await LocalStorage.clearPrefsExcept([]);
      GoRouter.of(context).go('/login_page');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreen());
  }
}
