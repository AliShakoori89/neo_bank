import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/Repository/user_login_auth_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repository/all_card_pan_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/All_cards_Pan_Bloc/all_cards_pans_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/all_card_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/otp_code_check_repository.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Repository/profile_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import 'Core/Const/app_routes.dart';
import 'Features/Main_Page/Presentation/Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 قفل در حالت عمودی
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    // DevicePreview(
    // child:
    // builder:
    //     (context) =>
    MyApp(),
    // )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<List<ConnectivityResult>>? subscription;
  late bool isOffline = false;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      // Received changes in available connectivity types!
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MainNavigationBloc(initialIndex: 0),
        ),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) =>
                    UserLoginAuthBloc(UserLoginAuthRepository()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    AllCardsBloc(AllCardRepository()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    AllCardsPansBloc(AllCardPanRepository()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    OtpCodeCheckBloc(OtpCodeCheckRepository()),
              ),
              BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(GetProfileRepository()),
              ),
            ],
            child: AnimatedTheme(
              data: theme,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: router,
                locale: const Locale("fa", "IR"),
                supportedLocales: const [Locale("fa", "IR")],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: theme,
              ),
            ),
          );
        },
      ),
    );
  }
}
