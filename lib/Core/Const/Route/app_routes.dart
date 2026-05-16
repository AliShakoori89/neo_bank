import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/Route/otp_args.dart';
import 'package:neo_bank_mehr_iran/Core/Const/Route/transaction_detail_args.dart';
import 'package:neo_bank_mehr_iran/Core/Const/auth_gate.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/navigator_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/local_login_page.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/login_page.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Presentation/Component/Directive_Charge_Tab/Internet_Packages_Page/Presentation/internet_packages_page.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Presentation/charge_and_internet_page.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/request_otp_code_again_repository.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/requerst_otp_again_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/otp_code_page.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/set_pass_page.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/transaction_detail_page.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/statement_page.dart';
import '../../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Presentation/Component/Directive_Charge_Tab/directive_charge_page.dart';
import '../../../Features/Main_Page/Presentation/main_page.dart';

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthGate()),

    GoRoute(
      path: '/main_page',
      builder: (context, state) {
        final index = state.extra as int? ?? 0;

        return MainPage(initialIndex: index);
      },
    ),

    GoRoute(
      path: '/otp_code_page',
      builder: (context, state) {
        final args = state.extra as OtpArgs;

        return BlocProvider(
          create: (_) =>
              RequerstOtpAgainBloc(RequestOtpCodeAgainRepository()),
          child: OtpCodePage(
            phoneNumber: args.phoneNumber,
            nationalCode: args.nationalCode,
            deviceId: args.deviceId,
            secretKey: args.secretKey,
            expireTime: args.expireTime,
          ),
        );
      },
    ),

    GoRoute(
      path: '/login_page',
      builder: (context, state) {
        return LoginPage();
      },
    ),

    GoRoute(
      path: '/set_pass_page',
      builder: (context, state) {
        final bool? inputFromProfile = state.extra as bool?;
        return SetPassPage(inputFromProfile: inputFromProfile);
      },
    ),

    GoRoute(
      path: '/local_login_page',
      builder: (context, state) => const LocalLoginPage(),
    ),

    GoRoute(
      path: '/statement_page',
      builder: (context, state) => const StatementPage(),
    ),

    GoRoute(
      path: '/transaction_detail_page',
      builder: (context, state) {
        final args = state.extra as TransactionDetailArgs;

        return TransactionDetailPage(
          date: args.date,
          title: args.title,
          transferAmount: args.transferAmount,
          description: args.description,
        );
      },
    ),

    GoRoute(
      path: '/charge_internet_page',
      builder: (context, state) => const ChargeAndInternetPage(),
    ),

    GoRoute(
      path: '/directive_charge_page',
      builder: (context, state) => DirectiveChargePage(),
    ),

    GoRoute(
      path: '/internet_package_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return InternetPackagesPage(
          selectedOperator: extra?['selectedOperator'],
          phoneNumber: extra?['phoneNumber'],
        );
      },
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
