import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Widgets/app_snackbar.dart';
import '../../Bloc/Transaction_Bloc/transaction_bloc.dart';
import '../../Bloc/Transaction_Bloc/transaction_event.dart';
import '../../Bloc/Transaction_Bloc/transaction_state.dart';
import '../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../Bloc/Wallet_Bloc/wallet_state.dart';
import '../Charge_Internet_Page/Component/custom_header.dart';
import 'Component/all_balance_widget.dart';
import 'Component/confirm_button.dart';
import 'Component/custom_formatter.dart';
import 'Component/deposit_button.dart';
import 'Component/deposit_input_container.dart';
import 'Component/wallet_types_list.dart';
import 'Component/withdraw_button.dart';
import 'Component/withdraw_input_container.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final CustomNumberFormatter balanceController = CustomNumberFormatter();
  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();

  bool deposit = false;
  bool withdraw = false;
  String? _selectedDepositNumber;

  @override
  void initState() {
    context.read<WalletBloc>().add(WalletDetailsPackagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state.status == TransactionStatus.success) {
              // نمایش پیام موفقیت
              AppSnackBar.successTop(context, state.message ?? 'تراکنش با موفقیت انجام شد');

              // آپدیت موجودی
              context.read<WalletBloc>().add(WalletDetailsPackagesEvent());

              // ریست کردن فرم
              balanceController.clear();
              setState(() {
                deposit = false;
                withdraw = false;
                _selectedDepositNumber = null;
              });

            } else if (state.status == TransactionStatus.error) {
              // نمایش پیام خطا
              AppSnackBar.errorTop(context, state.message ?? 'خطا در انجام تراکنش');
            }
          },
          builder: (context, transactionState) {
            final isLoading = transactionState.status == TransactionStatus.loading;

            return Column(
              children: [
                CustomHeader(title: 'کیف پول', hasBackArrow: false,),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSpace.heightSpace_48,
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: [
                                      AllBalanceWidget(),
                                      AppSpace.heightSpace_12,
                                      Row(
                                        children: [
                                          DepositButton(
                                            function: () {
                                              if (!isLoading) {
                                                setState(() {
                                                  deposit = true;
                                                  withdraw = false;
                                                });
                                              }
                                            },
                                          ),
                                          AppSpace.widthSpace_5,
                                          WithdrawButton(
                                            function: () {
                                              if (!isLoading) {
                                                setState(() {
                                                  deposit = false;
                                                  withdraw = true;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              AppSpace.heightSpace_32,
                              DepositInputContainer(
                                showDepositContainer: deposit && !isLoading,
                                balanceController: balanceController,
                                balanceFormKey: balanceFormKey,
                                onDepositNumberSelected: (value) {
                                  if (!isLoading) {
                                    setState(() {
                                      _selectedDepositNumber = value;
                                    });
                                  }
                                },
                                onClose: () {
                                  setState(() {
                                    deposit = false;
                                  });
                                },
                                onAmountChanged: (amount) {
                                  if (!isLoading) {
                                    setState(() {
                                    });
                                  }
                                },
                              ),
                              WithdrawInputContainer(
                                showWithdrawContainer: withdraw && !isLoading,
                                onDepositNumberSelected: (value) {
                                  if (!isLoading) {
                                    setState(() {
                                      _selectedDepositNumber = value;
                                    });
                                  }
                                },
                                onClose: () {
                                  setState(() {
                                    withdraw = false;
                                  });
                                },
                                onAmountChanged: (amount) {
                                  if (!isLoading) {
                                    setState(() {
                                    });
                                  }
                                },
                                balanceController: balanceController,
                                balanceFormKey: balanceFormKey,
                              ),
                              AppSpace.heightSpace_48,
                              Text(
                                'لیست کیف ها:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.primaryFixed,
                                ),
                              ),
                              AppSpace.heightSpace_16,
                              WalletTypesList(),
                              AppSpace.heightSpace_48,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<WalletBloc, WalletState>(
                  builder: (context, walletState) {
                    return balanceController.text != 0.toString() && balanceController.text.isNotEmpty
                        ? ConfirmButton(
                      amount: balanceController.text,
                      deposit: deposit,
                      withdraw: withdraw,
                      selectedDepositNumber: _selectedDepositNumber,
                      balanceFormKey: balanceFormKey,
                      rawAmount: balanceController.rawValue,
                      isLoading: isLoading,
                      onConfirm: () {
                        if (deposit && walletState.walletDetails.isNotEmpty) {
                          context.read<TransactionBloc>().add(
                            ChargeTransactionEvent(
                              customerWalletAddress: walletState.walletDetails.first.address!,
                              amount: balanceController.rawValue,
                              customerDepositNumber: _selectedDepositNumber!,
                            ),
                          );
                        } else if (withdraw && walletState.walletDetails.isNotEmpty) {
                          context.read<TransactionBloc>().add(
                            WithdrawTransactionEvent(
                              customerWalletAddress: walletState.walletDetails.first.address!,
                              amount: balanceController.rawValue,
                              customerDepositNumber: _selectedDepositNumber!,
                            ),
                          );
                        }
                      },
                    )
                        : Container();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}