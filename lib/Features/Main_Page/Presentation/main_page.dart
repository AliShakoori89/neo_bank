import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Services/check_connection_service.dart';
import '../../Account_Report_Page/Presentation/account_report_page.dart';
import '../../Bank_Services_Page/bank_services_page.dart';
import '../../Fund_Transfer_Page/Presentation/fund_transfer_page.dart';
import '../../Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_event.dart';
import '../../Home_Page/Presentation/home_page.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import '../../Profile_Page/Presentation/profile_page.dart';
import 'Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Bloc/Main_Navigation_Bloc/main_navigation_event.dart';
import 'Bloc/Main_Navigation_Bloc/main_navigation_state.dart';
import 'Component/navigation_bar.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? _lastBackPress;

  bool? hasInternet;
  bool isChecking = true;

  @override
  void initState() {
    super.initState();
    checkConnection(context);
    context.read<ThemeBloc>().add(ThemeEvent.load);
    BlocProvider.of<AllCardsBloc>(context).add(GetUserAllCardsEvent());
  }

  final List<Widget> _pages = [
    HomePage(),
    FundTransferPage(),
    BankServicesPage(),
    AccountReportPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    context.read<MainNavigationBloc>().add(ChangeTabEvent(index));
  }

  Future<bool> _handleBack() async {
    final navState = context.read<MainNavigationBloc>().state;

    // اگر روی تب غیر از Home هست
    if (navState.selectedIndex != 0) {
      context.read<MainNavigationBloc>().add(ChangeTabEvent(0));
      return false;
    }

    final now = DateTime.now();
    if (_lastBackPress == null ||
        now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
      _lastBackPress = now;
      Fluttertoast.showToast(
        msg: "برای خروج دوباره بزنید",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
      return false;
    }

    return true; // اجازه خروج
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: PopScope(
        canPop: false, // کنترل کامل خروج با خودتان
        onPopInvoked: (didPop) async {
          if (didPop) return;

          final shouldExit = await _handleBack();
          if (shouldExit) {
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: BlocBuilder<MainNavigationBloc, MainNavigationState>(
                builder: (context, navState) {
                  return Stack(
                    children: [
                      _pages[navState.selectedIndex],
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomBottomNavigationBar(
                          currentIndex: navState.selectedIndex,
                          onTap: _onItemTapped,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ),
      ),
    );
  }
}
