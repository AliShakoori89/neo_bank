import 'package:flutter/material.dart';
import '../../../Core/Services/check_connection_service.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Widgets/custom_header.dart';
import 'Component/build_balance_and_transaction_body.dart';
import 'Component/custom_tab_bar.dart';
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

    checkConnection(context);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
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
          navHeader(
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
