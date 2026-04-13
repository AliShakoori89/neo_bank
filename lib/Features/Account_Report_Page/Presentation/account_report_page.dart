import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Report_Page/Presentation/Component/custom_tab_bar.dart';
import '../../../Core/Utils/App_Lock/Internet/internet_checker.dart';
import '../../Main_Page/main_page.dart';
import 'Component/build_balance_and_transaction_body.dart';
import 'Component/dropdown_button.dart';

class AccountReportPage extends StatefulWidget {
  const AccountReportPage({super.key});

  @override
  State<AccountReportPage> createState() => _AccountReportPageState();
}

class _AccountReportPageState extends State<AccountReportPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {

    //این تغییر به دلیل قطعی اینترنت در زمان جنگ ایجاد گردیده
    // _checkConnection();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _refreshPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainPage(initialIndex: 3,)),
    );
  }

  Future<void> _checkConnection() async {
    await InternetChecker.checkInternet(
      context: context,
      onSuccess: _refreshPage,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final List label = ['موجودی و تراکنش', 'مدیریت هزینه‌ها'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: Column(
        children: [
          // --- Header ---
          customHeader(
            context,
            Text(
              'گزارش حساب',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
          ),

          // --- Body ---
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Container(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    CustomDropdownMenu(),
                    AppSpace.heightSpace_24,
                    CustomTabBar(tabController: tabController, label: label),
                    AppSpace.heightSpace_24,

                    // --- TabBarView (BODY) ---
                    Flexible(
                      fit: FlexFit.loose,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          buildBalanceAndTransactionBody(context),
                          Center(child: Text("محتوای تب ۲")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
