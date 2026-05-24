import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../Core/Const/app_colors.dart';
import '../../../../../../../Core/Const/app_space.dart';
import '../../../../../../../Core/Utils/custom_button.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../custom_header.dart';

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

  final List<Map<String, dynamic>> chargeAmounts = [
    {'amount': '10,000', 'value': 10000, 'color': AppColors.splashGradiantColor1},
    {'amount': '20,000', 'value': 20000, 'color': Colors.blue},
    {'amount': '50,000', 'value': 50000, 'color': Colors.green},
    {'amount': '100,000', 'value': 100000, 'color': Colors.orange},
    {'amount': '200,000', 'value': 200000, 'color': Colors.purple},
    {'amount': '500,000', 'value': 500000, 'color': Colors.red},
  ];

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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            CustomHeader(title: 'شارژ مستقیم'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // انتخاب مبلغ شارژ
                    Text(
                      'مبلغ شارژ را انتخاب کنید:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primaryFixed,
                      ),
                    ),
                    AppSpace.heightSpace_12,

                    // لیست مبالغ
                    GridView.builder(
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
                  ],
                ),
              ),
            ),
            Spacer(),
            // دکمه ادامه
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20
              ),
              child: CustomButton(
                buttonTitle: 'ادامه',
                buttonOnPressed: (phoneNumberFormKey.currentState?.validate() ?? false) && selectedAmount != null
                    ? () => _handleDirectCharge()
                    : (){},
              ),
            ),
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

class ChargeAmountCard extends StatelessWidget {
  const ChargeAmountCard({
    super.key,
    required this.amount,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String amount;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            '$amount تومان',
            style: TextStyle(
              color: isSelected ? color : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}