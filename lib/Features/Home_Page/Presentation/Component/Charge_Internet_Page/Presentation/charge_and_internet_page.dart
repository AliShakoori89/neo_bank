import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import '../../../../../../Core/Const/app_space.dart';
import '../../../../../../Core/Utils/custom_header.dart';
import '../../../../../Account_Page/Presentation/Component/custom_text_form_field.dart';
import 'Component/Directive_Charge_Tab/directive_charge_tab.dart';

class ChargeAndInternetPage extends StatefulWidget {
  const ChargeAndInternetPage({super.key});

  @override
  State<ChargeAndInternetPage> createState() => _ChargeAndInternetPageState();
}

class _ChargeAndInternetPageState extends State<ChargeAndInternetPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  TextEditingController nationalCodeController = TextEditingController();
  final GlobalKey<FormState> nationalCodeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // ایجاد TabController با تعداد تب‌های مورد نیاز
    // و مشخص کردن TickerProvider برای انیمیشن‌ها
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // همیشه Controller را dispose کنید
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            Container(
              height: 92,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 40, // spacing-5xl (مثلاً)
                right: 24, // spacing-3xl
                bottom: 16, // spacing-lg
                left: 24, // spacing-3xl
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    width: 1,
                  ),
                ),
              ),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            context.pop();
                          },
                        ),
                      ),
                      Center(
                        child: Text(
                          'شارژ و اینترنت',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'شارژ مستقیم'),
                  Tab(text: 'بسته اینترنت'),
                ],
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                labelColor: AppColors.splashGradiantColor2,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.splashGradiantColor2,
                indicatorWeight: 1.0,
                splashFactory: NoSplash.splashFactory,
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // محتوای تب اول
                    DirectiveChargeTab(),
                    // محتوای تب دوم
                    Center(
                      child: Text('محتوای تنظیمات', style: Theme.of(context).textTheme.headlineMedium),
                    ),
                  ],
                )
            )



            ,
          ],
        )
      ),
    );
  }
}
