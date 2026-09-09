import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Sheba_Tab_Body/Component/sheba_text_field.dart';

import '../../../../../Core/Convertor/custom_formatter.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../custom_button.dart';
import '../repetitive_contacts.dart';
import '../transfer_fund_box.dart';

class ShebaTabBody extends StatefulWidget {
  const ShebaTabBody({super.key});

  @override
  State<ShebaTabBody> createState() => _ShebaTabBodyState();
}

class _ShebaTabBodyState extends State<ShebaTabBody> {
  late final CustomNumberFormatter balanceController;
  late final TextEditingController shebaNumberController;

  @override
  void initState() {
    super.initState();

    balanceController = CustomNumberFormatter();
    shebaNumberController = TextEditingController();
  }

  @override
  void dispose() {
    balanceController.dispose();
    shebaNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpace.heightSpace_24,

                Text(
                  'شماره شبا مقصد:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryFixed,
                  ),
                ),

                AppSpace.heightSpace_8,

                ShebaTextField(
                  controller: shebaNumberController,
                  onChanged: (value) {
                    final rawSheba =
                    ShebaInputFormatter.normalize(value);

                    debugPrint('Sheba: $rawSheba');
                  },
                ),

                AppSpace.heightSpace_24,
                TransferFundBox(
                  balanceController: balanceController,
                ),
                AppSpace.heightSpace_24,
                CustomButton(),
                AppSpace.heightSpace_32,

              ],
            ),
          ),
          Expanded(child: RepetitiveContacts()),

        ],
      ),
    );
  }
}