import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Core/DI/injection_container.dart';
import 'Core/Routes/app_routes.dart';
import 'Core/Services/App_Lock/app_lock_observer_service.dart';
import 'Core/Theme/app_them.dart';
import 'Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/abort_token_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/create_token_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/get_citizen_ekyc_status_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/get_ekyc_state_inquiry_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/has_approved_ekyc_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/random_text_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/send_video_repository.dart';
import 'Features/EKYC_Authentication_Page/Domain/Repository/validate_token_repository.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Abort_Token_Bloc/abort_token_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Create_Token_Bloc/create_token_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Get_Citizen_EKYC_Status_Bloc/Get_Citizen_EKYC_Status_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Get_EKYC_State_Inquiry_Bloc/get_ekyc_state_inquiry_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Has_Approved_EKYC_Bloc/has_approved_ekyc_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Random_Text_Bloc/random_text_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Send_Video_Bloc/send_video_bloc.dart';
import 'Features/EKYC_Authentication_Page/Presentation/Bloc/Validate_token_Bloc/validate_token_bloc.dart';
import 'Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import 'Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import 'Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import 'Features/Home_Page/Presentation/Bloc/Balanc_visibility/balanc_visibility.dart';
import 'Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_bloc.dart';
import 'Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import 'Features/Home_Page/Presentation/Bloc/Loan_Page_Bloc/loan_page_bloc.dart';
import 'Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_bloc.dart';
import 'Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'Features/Main_Page/Presentation/Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import 'Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/request_otp_again_bloc.dart';
import 'Features/Profile_Page/Domain/Repositories/profile_repository.dart';
import 'Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'Features/Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart';
import 'Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import 'Features/Set_Pass_Page/Domain/Repository/local_pass_repository.dart';
import 'Features/Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_bloc.dart';
import 'Features/Splash_Screen_Page/Presentation/VPN_Bloc/vpn_bloc.dart';
import 'Features/Splash_Screen_Page/Presentation/VPN_Bloc/vpn_event.dart';
import 'Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // 🔒 قفل در حالت عمودی
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkTheme') ?? false;

  configureDependencies();

  runApp(
    // DevicePreview(
    // builder:
    //     (context) =>
    AppLockObserverService(child: MyApp(isDark: isDark)),
    // )
  );
}

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
          create: (_) => VpnBloc()..add(CheckVpnEvent()),
        ),
        BlocProvider(
          create: (_) => MainNavigationBloc(initialIndex: 0), // ⭐ اضافه شود
        ),
        BlocProvider(
          create: (_) => sl<UserLoginAuthBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<AllCardsBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<AllCardsDetailBloc>(),
        ),
        BlocProvider(
            create: (_) => sl<OtpCodeCheckBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<RequestOtpAgainBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProfileBloc(GetProfileRepository()),
        ),
        BlocProvider(
            create: (_) => sl<StatementBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<UserAllAccountBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              LocalPassBloc(LocalPassRepository()),
        ),
        BlocProvider(create: (_) => BalanceVisibilityCubit()),
        BlocProvider(create: (BuildContext context) => RefreshCountBloc()),
        BlocProvider(
          create: (_) => sl<InternetPackageBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<WalletBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<TransactionBloc>(),
        ),
        BlocProvider(
            create: (_) => sl<CitizenEkycStatusBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              CreateTokenBloc(CreateTokenRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              ValidateTokenBloc(ValidateTokenRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              GetEkycStateInquiryBloc(GetEkycStateInquiryRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              RandomTextBloc(RandomTextRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              SendVideoBloc(SendVideoRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AbortTokenBloc(AbortTokenRepository()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              HasApprovedEkycBloc(HasApprovedEkycRepository()),
        ),
        BlocProvider(
          create: (_) => sl<LoanPageBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              GetCitizenEkycStatusBloc(GetCitizenEkycStatusRepository()),
        ),
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
                PersianMaterialLocalizations.delegate,
                PersianCupertinoLocalizations.delegate,
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
