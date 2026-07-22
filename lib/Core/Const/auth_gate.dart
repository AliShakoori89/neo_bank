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
    final localPass = await LocalStorage.read('local_password');
    final accessToken = await LocalStorage.read('access_token');

    await Future.delayed(
        const Duration(milliseconds: 100)); // جلوگیری از flicker

    if (!mounted) return;

    if (accessToken != null && accessToken.isNotEmpty &&
        accessToken != 'null') {
      if (localPass != null && localPass.isNotEmpty) {
        if (!mounted) return;
        GoRouter.of(context).go('/local_login_page');
        return;
      } else {
        GoRouter.of(context).go('/set_pass_page');
        return;
      }
    } else {

      GoRouter.of(context).go('/login_page');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreen());
  }
}
