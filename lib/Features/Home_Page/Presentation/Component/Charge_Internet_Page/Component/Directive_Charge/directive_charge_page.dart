import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../Core/Widgets/custom_button.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../custom_header.dart';
import 'Component/charge_amount_card.dart';
import 'Component/charge_amounts.dart';

class DirectiveChargePage extends StatefulWidget {
  const DirectiveChargePage({super.key});

  @override
  State<DirectiveChargePage> createState() => _DirectiveChargePageState();
}

class _DirectiveChargePageState extends State<DirectiveChargePage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  String? selectedAmount;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(WalletDetailsPackagesEvent());
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomHeader(title: 'شارژ مستقیم', hasBackArrow: false),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpace.heightSpace_24,
                    // انتخاب مبلغ شارژ
                    Text(
                      'مبلغ شارژ را انتخاب کنید:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primaryFixed,
                      ),
                    ),
                    AppSpace.heightSpace_32,
        
                    // لیست مبالغ
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: chargeAmounts.length,
                        itemBuilder: (context, index) {
                          final charge = chargeAmounts[index];
                          return ChargeAmountCard(
                            amount: charge['amount'],
                            color: charge['color'],
                            isSelected: selectedAmount == charge['amount'],
                            onTap: () {
                              setState(() {
                                selectedAmount = charge['amount'];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
        
              ],
            ),
            Spacer(),
            // دکمه ادامه
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20
              ),
              child: CustomButton(
                buttonTitle: 'ادامه',
                buttonOnPressed: (phoneNumberFormKey.currentState?.validate() ?? false) && selectedAmount != null
                    ? () => _handleDirectCharge()
                    : (){},
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleDirectCharge() {
    // منطق پرداخت شارژ مستقیم
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تایید شارژ'),
        content: Text(
          'شماره: ${phoneNumberController.text}\n'
              'مبلغ: $selectedAmount تومان',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // اجرای عملیات شارژ
              _processCharge();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.splashGradiantColor1,
            ),
            child: const Text('تایید'),
          ),
        ],
      ),
    );
  }

  void _processCharge() {
    setState(() {
      isLoading = true;
    });

    // شبیه‌سازی درخواست به سرور
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
            content: const Text('شارژ با موفقیت انجام شد'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('باشه'),
              ),
            ],
          ),
        );
      }
    });
  }
}

