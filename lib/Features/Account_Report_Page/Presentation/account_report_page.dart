import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'Component/build_balance_and_transaction_body.dart';
import 'Component/dropdown_button.dart';

class AccountReportPage extends StatefulWidget {
  const AccountReportPage({super.key});

  @override
  State<AccountReportPage> createState() => _AccountReportPageState();
}

class _AccountReportPageState extends State<AccountReportPage> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
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
      body: Column(
        children: [
          // --- Header ---
          customHeader(context, Text(
            'انتقال وجه',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.customHeaderTextColor),
          )),

          // --- Body ---
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Container(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    DropdownMenuExample(),
                    AppSpace.heightSpace_24,
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.customContainerBackGroundColor,
                          border: BoxBorder.all(
                              color: AppColors.homePageDividerColor
                          )
                      ),
                      child: TabBar(
                        controller: tabController,
                        // padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: const EdgeInsets.only(top: 5, bottom: 5),
                        labelColor: AppColors.customHeaderTextColor,
                        unselectedLabelColor: AppColors.loginPageHintFontColor,
                        dividerColor: Colors.white,
                        indicatorColor: Colors.white,
                        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                        indicator: BoxDecoration(
                          color: AppColors.appWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tabs: List.generate(2, (index) {

                          bool isSelected = tabController.index == index;

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Text(label[index]),
                          );
                        },
                        ),
                      ),
                    ),

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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}


