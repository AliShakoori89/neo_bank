import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Widgets/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Sheba_Tab_Body/sheba_tab_body.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Account_Tab_Body/account_tab_body.dart';
import '../../../Core/Services/check_connection_service.dart';
import 'component/Cart_Tab_Body/cart_tab_body.dart';
import 'component/Gift_Tab_Body/gift_tab_body.dart';
import 'component/build_tab_item.dart';
import 'fund_transfer_tab.dart';

class FundTransferPage extends StatefulWidget {

  final FundTransferTab initialTab;

  const FundTransferPage({
    super.key,
    this.initialTab = FundTransferTab.card,
  });

  @override
  State<FundTransferPage> createState() => _FundTransferPageState();
}

class _FundTransferPageState extends State<FundTransferPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _tabs = [
    {'icon': 'assets/svg/fund_transfer_page/credit-card-02.svg', 'title': 'کارت',},
    {'icon': 'assets/svg/fund_transfer_page/bank.svg', 'title': 'حساب'},
    {'icon': 'assets/svg/fund_transfer_page/Layer_1.svg', 'title': 'شبا'},
    {'icon': 'assets/svg/fund_transfer_page/gift-01.svg', 'title': 'هدیه'},
  ];

  @override
  void initState() {
    super.initState();

    checkConnection(context);

    BlocProvider.of<AllCardsDetailBloc>(context).add(GetAllCardsDetailEvent());
    BlocProvider.of<UserAllAccountBloc>(context).add(GetUserAllAccountEvent());
    _tabController = TabController(length: _tabs.length, vsync: this,
      initialIndex: widget.initialTab.index,)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            /// --- Header ---
            navHeader(
              context,
              Text(
                'انتقال وجه',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.appBarTheme.titleTextStyle?.color,
                ),
              ),
            ),
        
            /// --- Tab Bar ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                border: Border(
                  top: BorderSide(color: theme.colorScheme.surfaceDim),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: theme.tabBarTheme.indicatorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 24),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.loginPageIconColor,
                dividerColor: Colors.transparent,
                tabs: List.generate(_tabs.length, (index) {
                  final isSelected = _tabController.index == index;
                  return buildTabItem(
                    context,
                    iconPath: _tabs[index]['icon']!,
                    title: _tabs[index]['title']!,
                    isSelected: isSelected,
                  );
                }),
              ),
            ),
        
            /// --- Tab Body ---
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CartTabBody(),
                  AccountTabBody(context),
                  ShebaTabBody(),
                  GiftTabBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
