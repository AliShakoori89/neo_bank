import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/app_snackbar.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/add_gift_card.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/balance_value.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/input_value_text_field.dart';
import '../../../../../Core/Const/app_colors.dart';
import '../../../../../Core/Utils/custom_refresh_button.dart';
import '../../../../Fund_Transfer_Page/Presentation/component/bank_card_selector.dart';
import '../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../Charge_Internet_Page/Component/custom_header.dart';
import 'Component/custom_formatter.dart';
import 'Component/wallet_types_list.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  final CustomNumberFormatter balanceController = CustomNumberFormatter();
  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();

  int _selectedCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            CustomHeader(title: 'کیف پول'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: 20,
                          left: 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSpace.heightSpace_48, // کاهش از 128 به 48
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.withAlpha(25)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('کل موجودی',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.primaryFixed,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),),
                                            RefreshButtonWithAnimation(
                                              onPressed: () async {
                                                context.read<WalletBloc>().add(WalletDetailsPackagesEvent());
                                              },
                                              color: Theme.of(context).colorScheme.primaryFixed,
                                              size: 24,
                                            )

                                          ],
                                        ),
                                        AppSpace.heightSpace_16,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            BalanceValue(),
                                            AppSpace.widthSpace_5,
                                            Text('ریال',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.primaryFixed,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),),
                                          ],
                                        ),
                                        AppSpace.heightSpace_48, // کاهش از 32 به 24
                                      ],
                                    ),
                                  ),
                                ),
                                AppSpace.heightSpace_24, // کاهش از 32 به 24
                              ],
                            ),
                          ),
                          AppSpace.heightSpace_16,
                          AddGiftCard(),
                          AppSpace.heightSpace_32,
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey.withAlpha(25)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text('شماره کارت مبدا خود را انتخاب نمایید:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.primaryFixed,
                                    ),
                                  ),
                                  AppSpace.heightSpace_16,
                                  BankCardSelector(widthSize: double.infinity, heightSize: 55,),
                                  AppSpace.heightSpace_48,
                                  Text('مبلغ مورد نظر جهت شارژ کیف پول خود را وارد نمایید:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.primaryFixed,
                                    ),
                                  ),
                                  AppSpace.heightSpace_16,
                                  InputValueTextField(balanceController: balanceController, balanceFormKey: balanceFormKey)
                                ],
                              ),
                            ),
                          ),
                          AppSpace.heightSpace_48,
                          Text('لیست کیف ها:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          AppSpace.heightSpace_16,
                          // PayTypesList(theme: theme, selectedCardIndex: _selectedCardIndex),
                          WalletTypesList(),
                          AppSpace.heightSpace_48,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (balanceFormKey.currentState?.validate() ?? false) {
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.splashGradiantColor1,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('پرداخت'),
                            ),
                          ),
                          AppSpace.heightSpace_48,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
