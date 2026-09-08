import 'package:flutter/material.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Wallet_Page/Component/select_deposit_number_dropdown.dart';
import '../../../../../../Core/Spacing/app_space.dart';
import 'custom_formatter.dart';
import 'input_value_text_field.dart';

class DepositInputContainer extends StatefulWidget {
  const DepositInputContainer({
    super.key,
    required this.showDepositContainer,
    required this.balanceController,
    required this.balanceFormKey,
    required this.onDepositNumberSelected,
    required this.onClose,
    this.onAmountChanged,
  });

  final bool showDepositContainer;
  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;
  final Function(String) onDepositNumberSelected;
  final Function() onClose;
  final Function(int)? onAmountChanged;

  @override
  State<DepositInputContainer> createState() => _DepositInputContainerState();
}

class _DepositInputContainerState extends State<DepositInputContainer> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showDepositContainer,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withAlpha(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AppSpace.heightSpace_24,
                  Text(
                    'شماره حساب مورد نظر خود را انتخاب نمایید:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                  AppSpace.heightSpace_16,
                  SelectDepositNumberDropdown(
                    onSelected: widget.onDepositNumberSelected,  // ✅ ارسال callback
                  ),
                  AppSpace.heightSpace_24,
                  Text(
                    'مبلغ مورد نظر خود را وارد نمایید:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                  AppSpace.heightSpace_16,
                  InputValueTextField(
                    balanceController: widget.balanceController,
                    balanceFormKey: widget.balanceFormKey,
                    onAmountChanged: widget.onAmountChanged,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: widget.onClose,
            ),
          )
        ],
      ),
    );
  }
}
