import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Core/Const/app_routes.dart';
import 'Features/Main_Page/Presentation/Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 قفل در حالت عمودی
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isAgreed = prefs.getBool('isAgreed') ?? false;
  bool isLoggedIn = (prefs.getString('accessToken') == null)
      ? false
      : true;

  runApp(
      // DevicePreview(
      // child:
      // builder:
      //     (context) =>
              MyApp(isLoggedIn: isLoggedIn, isAgreed: isAgreed)
  // )
  );
}

class MyApp extends StatefulWidget {

  final bool isLoggedIn;
  final bool isAgreed;

  const MyApp({super.key, required this.isLoggedIn, required this.isAgreed});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  StreamSubscription<List<ConnectivityResult>>? subscription;
  late bool isOffline = false;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
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
            create: (BuildContext context) =>
                MainNavigationBloc(initialIndex: 0)),
        BlocProvider(
            create: (_) => ThemeBloc(),)
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            locale: const Locale("fa", "IR"),
            supportedLocales: const [
              Locale("fa", "IR"),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: theme,
          );
        }
      ),
    );
  }
}
