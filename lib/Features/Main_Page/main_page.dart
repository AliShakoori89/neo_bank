import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Report_Page/Presentation/account_report_page.dart';
import '../Bank_Services_Page/bank_services_page.dart';
import '../Fund_Transfer_Page/Presentation/fund_transfer_page.dart';
import '../Home_Page/Presentation/home_page.dart';
import '../Profile_Page/Presentation/profile_page.dart';
import 'Presentation/Bloc/Main_Navigation_Bloc/main_navigation_bloc.dart';
import 'Presentation/Bloc/Main_Navigation_Bloc/main_navigation_event.dart';
import 'Presentation/Bloc/Main_Navigation_Bloc/main_navigation_state.dart';
import 'Presentation/Component/navigation_bar.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? _lastBackPress;

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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (await _handleBack()) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).maybePop();
            });
          }
        },
        child: SafeArea(
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
        ),
      ),
    );
  }
}
