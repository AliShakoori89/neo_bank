import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Features/Splash_Screen_Page/Presentation/splash_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // final isExpired = await LocalStorage.isTokenExpired();local_password
    final localPass = await LocalStorage.read('local_password');
    // final secretKey = await LocalStorage.read('secret_key');
    final access_token = await LocalStorage.read('access_token');

    await Future.delayed(
      const Duration(milliseconds: 100),
    ); // جلوگیری از flicker

    if (!mounted) return;

    if (access_token != null
    // && !isExpired
    ) {
      if (localPass != null) {
        context.go('/main_page');
      } else {
        context.go('/set_pass_page');
      }
    } else {
      await LocalStorage.clearPrefsExcept([]);
      context.go('/login_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreen());
  }
}
