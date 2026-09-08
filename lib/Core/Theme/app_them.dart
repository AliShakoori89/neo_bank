import 'package:flutter/material.dart';

class AppTheme {
  // 🌞 تم روشن
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'IRANSans',

    colorScheme: const ColorScheme.light(
      primary: Color(0xff4CA30D), // سبز اصلی بانک
      secondary: Color(0xff66C61C), // سبز مکمل
      primaryContainer: Color(0xFFE6E6FA), // پس‌زمینه اصلی صفحه
      secondaryContainer: Color(0xFFB8D8A1), // پس‌زمینه اصلی صفحه
      surface: Color(0xFF717680), // هینت تکست ها
      scrim: Color(0xFFFFFFFF), // اپ لوگو
      onSurface: Color(0xFF535862), // تکست ها
      tertiary: Color(0xff4CA30D), // رنک کلمه نسخه
      outline: Colors.white54, //بک گراند تکست فیلدها
      surfaceDim: Color(0xFFD5D7DA),
      surfaceTint: Color(0xFFECFDFF),
      surfaceBright: Color(0xFF414651),
      surfaceContainer: Color(0xFFFFFFFF),
      surfaceContainerHigh: Color(0xFFCECFD2),
      surfaceContainerLow: Color(0xFF66C61C),
      onTertiary: Color(0xFF079455),
      onPrimary: Color(0xFF535862),
      onSecondary: Color(0xFF079354),
      onInverseSurface: Color(0xFF70757F),
      inverseSurface: Color(0xFFDCFAE6),
      surfaceContainerHighest: Color(0xFFF3F3F3),
      onPrimaryFixed: Color(0xFFF8F8F8),
      tertiaryFixed: Color(0xFFFFFFFF),
      primaryFixed: Color(0xFF181D27),
    ),

    iconTheme: IconThemeData(color: Color(0xFF717680)),

    cardTheme: CardThemeData(color: Color(0xFFF5F5F5)),

    tabBarTheme: TabBarThemeData(indicatorColor: Color(0xFFE3FBCC)),

    textTheme: TextTheme(titleMedium: TextStyle(color: Color(0xFF181D27))),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      indicatorColor: Color(0xFFCFF9FE),
    ),

    scaffoldBackgroundColor: Color(0xffFAFAFA),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      iconTheme: IconThemeData(color: Color(0xFF414651)),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF414651),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF414651),
        foregroundColor: Color(0xFFFFFFFF),
        iconColor: Color(0xFFA6EF67),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF00A5CF);
        }
        return Colors.grey.shade300;
      }),
      thumbColor: WidgetStateProperty.all(Colors.white),
    ),

    dividerColor: Color(0xFFE9EAEB),
  );



  // 🌚 تم تاریک
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'IRANSans',

    colorScheme: ColorScheme.dark(
      primary: Color(0xff4CA30D), // آبی اصلی بانک
      secondary: Color(0xff66C61C), // آبی مکمل
      primaryContainer: Color(0xFF13161B), // پس‌زمینه اصلی صفحه
      secondaryContainer: Color(0xFFB8D8A1), // پس‌زمینه اصلی صفحه
      outline: Color(0xFF0C0E12),
      surface: Color(0xFF85888E),
      scrim: Color(0xFFFFFFFF), // اپ لوگو
      onSurface: Color(0xFF94979C),
      surfaceDim: Color(0xFF373A41),
      surfaceTint: Color(0xFF0D2D3A),
      surfaceBright: Color(0xFFCECFD2),
      surfaceContainer: Color(0xFF0C0E12),
      surfaceContainerHigh: Color(0xFFCECFD2),
      surfaceContainerLow: Color(0xFF66C61C),
      onTertiary: Color(0xFF079455),
      onPrimary: Color(0xFF94979C),
      onSecondary: Color(0xFF079354),
      onInverseSurface: Color(0xFF70757F),
      inverseSurface: Color(0xFFDCFAE6),
      surfaceContainerHighest: Color(0xFF22262F),
      onPrimaryFixed: Color(0xFF13161B),
      tertiaryFixed: Color(0xFF13161B),
      primaryFixed: Color(0xFFFFFFFF),
    ),

    cardTheme: CardThemeData(color: Color(0xFF22262F)),

    iconTheme: IconThemeData(color: Color(0xFFECECED)),

    tabBarTheme: TabBarThemeData(indicatorColor: Color(0xFFE3FBCC)),

    textTheme: TextTheme(
      titleMedium: TextStyle(color: Color.fromRGBO(238, 239, 241, 1)),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Color(0xFF0C0E12),
      indicatorColor: Color(0xFF164C63),
    ),

    scaffoldBackgroundColor: const Color(0xFF0E0E0E),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0C0E12),
      iconTheme: IconThemeData(color: Color(0xFFCECFD2)),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFFCECFD2),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF414651),
        foregroundColor: Colors.white,
        iconColor: Color(0xFFA6EF67),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF00A5CF);
        }
        return Colors.grey.shade700;
      }),
      thumbColor: WidgetStateProperty.all(Colors.white),
    ),

    dividerColor: Color(0xFF22262F),
  );
}
