import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/Route/otp_args.dart';
import 'package:neo_bank_mehr_iran/Core/Const/auth_gate.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/navigator_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/local_login_page.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/login_page.dart';
import 'package:neo_bank_mehr_iran/Features/Main_Page/Presentation/Component/internet_check_page.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/request_otp_code_again_repository.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/requerst_otp_again_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/otp_code_page.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/set_pass_page.dart';
import '../../../Features/Main_Page/main_page.dart';

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthGate()),

    GoRoute(
      path: '/main_page',
      builder: (context, state) {
        final index = state.extra as int? ?? 0;

        return InternetCheckPage(
          child: MainPage(initialIndex: index), // صفحه واقعی
        );
      },
    ),

    GoRoute(
      path: '/otp_code_page',
      builder: (context, state) {
        final args = state.extra as OtpArgs;

        return InternetCheckPage(
          child: BlocProvider(
            create: (_) =>
                RequerstOtpAgainBloc(RequestOtpCodeAgainRepository()),
            child: OtpCodePage(
              phoneNumber: args.phoneNumber,
              nationalCode: args.nationalCode,
              deviceId: args.deviceId,
              secretKey: args.secretKey,
              expireTime: args.expireTime,
            ),
          ),
        );
      },
    ),

    GoRoute(
      path: '/login_page',
      builder: (context, state) {
        return InternetCheckPage(child: LoginPage());
      },
    ),

    GoRoute(
      path: '/set_pass_page',
      builder: (context, state) {
        return InternetCheckPage(child: SetPassPage());
      },
    ),

    GoRoute(
      path: '/local_login_page',
      builder: (context, state) => const LocalLoginPage(),
    ),

    // GoRoute(
    //   path: '/cant_login',
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       transitionDuration: Duration(milliseconds: 500),
    //       child: CantLogin(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         const begin = Offset(0.0, 1.0); // Bottom to top transition
    //         const end = Offset.zero;
    //         const curve = Curves.easeOut;
    //         var tween = Tween(
    //           begin: begin,
    //           end: end,
    //         ).chain(CurveTween(curve: curve));
    //         return SlideTransition(
    //           position: animation.drive(tween),
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/forget_username',
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       transitionDuration: Duration(milliseconds: 500),
    //       child: ForgetUsername(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         const begin = Offset(-1.0, 0.0); // Bottom to top transition
    //         const end = Offset.zero;
    //         const curve = Curves.easeOut;
    //         var tween = Tween(
    //           begin: begin,
    //           end: end,
    //         ).chain(CurveTween(curve: curve));
    //         return SlideTransition(
    //           position: animation.drive(tween),
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
  ],
);
