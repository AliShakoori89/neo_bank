import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Services/check_connection_service.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Widgets/custom_header.dart';
import 'Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import 'Bloc/Account_Tab_Bloc/user_all_account_event.dart';
import 'Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import 'Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import 'component/Card/build_cart_tab_body.dart';
import 'component/build_account_tab_body.dart';
import 'component/build_tab_item.dart';

class FundTransferPage extends StatefulWidget {
  const FundTransferPage({super.key});

  @override
  State<FundTransferPage> createState() => _FundTransferPageState();
}

class _FundTransferPageState extends State<FundTransferPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _tabs = [
    {
      'icon': 'assets/svg/fund_transfer_page/credit-card-02.svg',
      'title': 'کارت',
    },
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
    _tabController = TabController(length: _tabs.length, vsync: this)
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
                  buildCartTabBody(context),
                  buildAccountTabBody(context),
                  const Center(child: Text("محتوای تب شبا")),
                  const Center(child: Text("محتوای تب هدیه")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
