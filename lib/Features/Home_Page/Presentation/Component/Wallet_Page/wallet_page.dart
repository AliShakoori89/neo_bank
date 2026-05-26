import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_state.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/all_balance_widget.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/confirm_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/deposit_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/deposit_input_container.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/withdraw_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/withdraw_input_container.dart';
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

  bool deposit = false;
  bool withdraw = false;

  List<String> walletList = [];

  @override
  void initState() {
    context.read<WalletBloc>().add(
        WalletDetailsPackagesEvent());
    super.initState();
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
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.transparent
                              ),
                              child: Column(
                                children: [
                                  AllBalanceWidget(),
                                  AppSpace.heightSpace_12,
                                  Row(
                                    children: [
                                      DepositButton(function: (){
                                        setState(() {
                                          deposit = true;
                                          withdraw = false;
                                        });
                                      },),
                                      AppSpace.widthSpace_5,
                                      WithdrawButton(function:(){
                                        setState(() {
                                          deposit = false;
                                          withdraw = true;
                                        });
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          // AppSpace.heightSpace_16,
                          // AddGiftCard(),
                          AppSpace.heightSpace_32,
                          DepositInputContainer(showDepositContainer: deposit, balanceController: balanceController, balanceFormKey: balanceFormKey),
                          WithdrawInputContainer(showWithdrawContainer: withdraw, walletList: walletList, balanceController: balanceController, balanceFormKey: balanceFormKey),
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
                          BlocBuilder<TransactionBloc, TransactionState>(
                            builder: (context, state) {
                              return ConfirmButton(
                                  deposit: deposit,
                                  withdraw: withdraw,
                                  balanceFormKey: balanceFormKey);
                            }
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
