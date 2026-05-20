import 'package:flutter/material.dart';

import '../../../../../../Core/Const/app_space.dart';
import 'add_balance_Text_Field.dart';
import 'custom_formatter.dart';

class InputValueTextField extends StatelessWidget {
  const InputValueTextField({super.key, required this.balanceController, required this.balanceFormKey});

  final CustomNumberFormatter balanceController;
  final GlobalKey<FormState> balanceFormKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              int current = balanceController.rawValue;
              current -= 10000;

              if (current < 0) current = 0;

              balanceController.text = current.toString();
            },
            icon: const Icon(Icons.remove),
          ),
        ),

        AppSpace.widthSpace_8,

        Expanded(
          child: AddBalanceTextField(
            balanceController: balanceController,
            balanceFormKey: balanceFormKey,
          ),
        ),

        AppSpace.widthSpace_8,

        Container(
          width: 50,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              int current = balanceController.rawValue;
              current += 10000;

              balanceController.text = current.toString();
            },
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
