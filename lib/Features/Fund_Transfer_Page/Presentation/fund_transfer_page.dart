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
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceDim
                )
              )
            ),
            width: double.infinity,
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                color: Theme.of(context).tabBarTheme.indicatorColor,
                borderRadius: BorderRadius.circular(8),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: 24),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.loginPageIconColor,
              dividerColor: Colors.transparent,
              tabs: List.generate(4, (index) {

                bool isSelected = tabController.index == index;

                return SizedBox(
                  width: 48,
                  height: 72,
                  child: ClipRect(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(14),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: index == 0 ? 4.17 : index == 1 ? 2.52 : index == 2 ? 3 : 1.67 ,
                                  left: index == 0 ? 1.67 : index == 1 ? 2.5 : index == 2 ? 3 : 1.67 ,
                                  child: SizedBox(
                                    width: index == 0 ? 16.67 : index == 1 ? 15 : index == 2 ? 13.34 : 16.67,
                                    height: index == 0 ? 11.67 : index == 1 ? 14.98 : index == 2 ? 15 : 16.67,
                                    child: SvgPicture.asset(
                                      imagePath[index]['icon_path']!,
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        isSelected
                                            ? AppColors.splashGradiantColor2
                                            : AppColors.loginPageIconColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppSpace.heightSpace_4,
                        Center(
                          child: Text(
                            imagePath[index]['icon_title']!,
                            style: TextStyle(
                                color: isSelected ? AppColors.splashGradiantColor2 : AppColors.loginPageIconColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            )
          ),

          // --- TabBarView (BODY) ---

          Expanded(
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