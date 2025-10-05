import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'component/build_cart_tab_body.dart';

class FundTransferPage extends StatefulWidget {
  const FundTransferPage({super.key});

  @override
  State<FundTransferPage> createState() => _FundTransferPageState();
}

class _FundTransferPageState extends State<FundTransferPage> with SingleTickerProviderStateMixin {

  late TabController tabController;

  final List<Map<String, String>> imagePath = [
    {'icon_path': 'assets/svg/fund_transfer_page/credit-card-02.svg', 'icon_title': 'کارت'},
    {'icon_path': 'assets/svg/fund_transfer_page/bank.svg', 'icon_title': 'حساب'},
    {'icon_path': 'assets/svg/fund_transfer_page/Layer_1.svg', 'icon_title': 'شبا'},
    {'icon_path': 'assets/svg/fund_transfer_page/gift-01.svg', 'icon_title': 'هدیه'},
  ];

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: Column(
        children: [

          // --- Header ---

          customHeader(context, Text('انتقال وجه',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).appBarTheme.titleTextStyle!.color
            ),
          )),

          // --- TabBar ---

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceDim
                )
              )
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TabBar(
                controller: tabController,
                indicator: BoxDecoration(
                  color: AppColors.navBarIconShadowColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 40),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.loginPageIconColor,
                dividerColor: Colors.transparent,
                tabs: List.generate(4, (index) {

                  bool isSelected = tabController.index == index;

                  return ClipRect(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            imagePath[index]['icon_path']!,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              isSelected ? AppColors.splashGradiantColor2 : AppColors.loginPageIconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        AppSpace.heightSpace_24,
                        Text(
                          imagePath[index]['icon_title']!,
                          style: TextStyle(
                            color: isSelected ? AppColors.splashGradiantColor2 : AppColors.loginPageIconColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          // --- TabBarView (BODY) ---

          Flexible(
            fit: FlexFit.loose,
            child: TabBarView(
              controller: tabController,
              children: [
                buildCartTabBody(context),
                Center(child: Text("محتوای تب ۲")),
                Center(child: Text("محتوای تب ۳")),
                Center(child: Text("محتوای تب ۴")),
              ],
            ),
          )
        ],
      ),
    );
  }
}