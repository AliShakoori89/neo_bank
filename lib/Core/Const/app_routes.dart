import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/auth_gate.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/forget_username.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/login_page.dart';
import 'package:neo_bank_mehr_iran/Features/Splash_Screen_Page/Presentation/splash_screen.dart';
import '../../Features/Account_Page/Presentation/Component/cant_login.dart';
import '../../Features/Main_Page/main_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) {
    //     return SplashScreen();
    //   },
    // ),
    GoRoute(path: '/', builder: (context, state) => const AuthGate()),

    GoRoute(
      path: '/main_page',
      builder: (context, state) {
        final index = state.extra as int? ?? 0;
        return MainPage(initialIndex: index);
      },
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: '/cant_login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: Duration(milliseconds: 500),
          child: CantLogin(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Bottom to top transition
            const end = Offset.zero;
            const curve = Curves.easeOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/forget_username',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: Duration(milliseconds: 500),
          child: ForgetUsername(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0); // Bottom to top transition
            const end = Offset.zero;
            const curve = Curves.easeOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
