import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/bank_card_selector.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/custom_button.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/repetitive_contacts.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/transfer_fund_box.dart';
import '../../../../../Core/Convertor/custom_formatter.dart';
import '../../../../../Core/Spacing/app_space.dart';

class CartTabBody extends StatefulWidget {
  const CartTabBody({super.key});

  @override
  State<CartTabBody> createState() => _CartTabBodyState();
}

class _CartTabBodyState extends State<CartTabBody> {
  late final CustomNumberFormatter balanceController;

  @override
  void initState() {
    super.initState();

    balanceController = CustomNumberFormatter();
  }

  @override
  void dispose() {
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSpace.heightSpace_24,

          BankCardSelector(),

          AppSpace.heightSpace_12,

          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30
            ),
            height: 144,
            child: Column(
              children: [
                // مبلغ انتقال
                TransferFundBox(balanceController: balanceController),

                AppSpace.heightSpace_24,

                // دکمه تایید
                CustomButton(),

                AppSpace.heightSpace_32,
              ],
            ),
          ),

          RepetitiveContacts(),
        ],
      ),
    );
  }
}