import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/App_Lock/app_lock_observer.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/Repository/user_login_auth_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repository/Deposits_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repository/all_card_pan_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_pans_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/all_card_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Balanc_visibility/balanc_visibility.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repository/otp_code_check_repository.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Repository/profile_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Core/Const/Route/app_routes.dart';
import 'Features/Main_Page/Presentation/Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 قفل در حالت عمودی
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkTheme') ?? false;

  runApp(
    // DevicePreview(
    // child:
    // builder:
    //     (context) =>
    AppLockObserver(child: MyApp(isDark: isDark)),
    // )
  );
}

// enum ConnectivityStatus { online, offline }

// class ConnectivityCubit extends Cubit<ConnectivityStatus> {
//   ConnectivityCubit() : super(ConnectivityStatus.online);

//   void update(bool isOnline) {
//     emit(isOnline ? ConnectivityStatus.online : ConnectivityStatus.offline);
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isDark});

  final bool isDark;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeBloc(
            widget.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
          ),
        ),
        BlocProvider(
          create: (_) => MainNavigationBloc(initialIndex: 0), // ⭐ اضافه شود
        ),
        BlocProvider(
          create: (BuildContext context) =>
              UserLoginAuthBloc(UserLoginAuthRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) => AllCardsBloc(AllCardRepository()),
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
          create: (BuildContext context) => ProfileBloc(GetProfileRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              UserAllAccountBloc(DepositsRepository()),
        ),
        BlocProvider(create: (_) => BalanceVisibilityCubit()),
        BlocProvider(create: (BuildContext context) => RefreshCountBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return AnimatedTheme(
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
          );
        },
      ),
    );
  }
}
