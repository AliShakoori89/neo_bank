import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/profile_page.dart';
import '../Card_Page/Presentation/card_page.dart';
import '../Home_Page/Presentation/home_page.dart';
import '../Menu_Page/menu_page.dart';
import 'Presentation/Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Presentation/Bloc/Main_Navigation_Bloc/main_navigation_event.dart';
import 'Presentation/Bloc/Main_Navigation_Bloc/main_navigation_state.dart';
import 'Presentation/Component/navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? currentBackPressTime;

  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final GlobalKey<FormState> firstNameFormKey = GlobalKey<FormState>();

  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> lastNameFormKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  final TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> rePasswordFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  final List<Widget> _pages = [
    HomePage(),
    Container(),
    MenuPage(),
    CardPage(),
    ProfilePage(),
  ];

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'برای خروج، دوباره دکمه بازگشت را بزنید.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
      return false;
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }
    return true;
  }

  void _onItemTapped(int index) {
    context.read<MainNavigationBloc>().add(ChangeTabEvent(index));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocBuilder<MainNavigationBloc, MainNavigationState>(
              builder: (context, navState) {
                return Stack(
                  children: [
                    _pages[navState.selectedIndex],
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomBottomNavigationBar(
                        currentIndex: navState.selectedIndex,
                        onTap: (index) => _onItemTapped(index),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}