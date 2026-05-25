import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/Component/select_deposit_number_dropdown.dart';
import '../../../../../../Core/Const/app_space.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/Card/custom_drop_down_shimmer.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/Card/custom_dropdown_button.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/bank_card_selector.dart';
import '../../../Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../../Bloc/All_cards_Bloc/all_cards_state.dart';
import 'custom_formatter.dart';
import 'input_value_text_field.dart';

class DepositInputContainer extends StatefulWidget {
  const DepositInputContainer({super.key, required this.showDepositContainer, required this.balanceController, required this.balanceFormKey});

  final bool showDepositContainer;
  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;

  @override
  State<DepositInputContainer> createState() => _DepositInputContainerState();
}

class _DepositInputContainerState extends State<DepositInputContainer> {

  List<String> cardDepositNumber = [];

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showDepositContainer,
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
              Text('شماره حساب مورد نظر خود را انتخاب نمایید:',
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
