import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/select_deposit_number_dropdown.dart';
import '../../../../../../Core/Const/app_space.dart';
import 'custom_formatter.dart';
import 'input_value_text_field.dart';

class WithdrawInputContainer extends StatefulWidget {
  WithdrawInputContainer({super.key, required this.showWithdrawContainer, required this.walletList, required this.balanceController, required this.balanceFormKey});

  final bool showWithdrawContainer;
  late List<String> walletList;
  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;

  @override
  State<WithdrawInputContainer> createState() => _WithdrawInputContainerState();
}

class _WithdrawInputContainerState extends State<WithdrawInputContainer> {

  List<String> cardDepositNumber = [];

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showWithdrawContainer,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withAlpha(25)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('کیف پول مورد نظر خود را انتخاب نمایید:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              AppSpace.heightSpace_16,
              SelectDepositNumberDropdown(cardDepositNumber: cardDepositNumber,),
              AppSpace.heightSpace_24,
              Text('مبلغ مورد نظر خود را وارد نمایید:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              AppSpace.heightSpace_16,
              InputValueTextField(balanceController: widget.balanceController, balanceFormKey: widget.balanceFormKey)
            ],
          ),
        ),
      ),
    );
  }
}
