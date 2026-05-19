import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/add_gift_card.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/balance_value.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/increase_balance.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/withdraw_transfer_balance.dart';
import '../Charge_Internet_Page/Component/custom_header.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  final TextEditingController balanceController = TextEditingController();

  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();

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
                    AppSpace.heightSpace_12,
                    Container(
                      margin: EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('جزئیات موجودی',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          AppSpace.heightSpace_48, // کاهش از 128 به 48
                          Center(
                            child: Column(
                              children: [
                                Text('کل موجودی'),
                                AppSpace.heightSpace_16,
                                BalanceValue(),
                                AppSpace.heightSpace_16,
                                Text('ریال'),
                                AppSpace.heightSpace_24, // کاهش از 32 به 24
                                Container(
                                  width: double.infinity,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.withAlpha(10)
                                  ),
                                ),
                                AppSpace.heightSpace_24, // کاهش از 32 به 24
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IncreaseBalance(
                                      balanceController: balanceController,
                                      balanceFormKey: balanceFormKey,),
                                    AppSpace.widthSpace_5,
                                    WithdrawTransferBalance(),
                                  ],
                                )
                              ],
                            ),
                          ),
                          AppSpace.heightSpace_16,
                          Divider(
                            color: Colors.grey.withAlpha(10),
                          ),
                          AppSpace.heightSpace_16,
                          AddGiftCard()
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
