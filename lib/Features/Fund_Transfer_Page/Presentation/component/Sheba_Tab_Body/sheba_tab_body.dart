import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Sheba_Tab_Body/Component/sheba_text_field.dart';
import '../../../../../Core/Convertor/custom_formatter.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../repetitive_contacts.dart';
import '../enter_amount_box.dart';

class ShebaTabBody extends StatefulWidget {
  const ShebaTabBody({super.key});

  @override
  State<ShebaTabBody> createState() => _ShebaTabBodyState();
}

class _ShebaTabBodyState extends State<ShebaTabBody> {
  final CustomNumberFormatter balanceController = CustomNumberFormatter();
  final TextEditingController shebaNumberController = TextEditingController();

  final GlobalKey<FormState> shebaNumberFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();


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
                  formKey: shebaNumberFormKey,
                  onChanged: (value) {
                    final rawSheba =
                    ShebaInputFormatter.normalize(value);

                    debugPrint('Sheba: $rawSheba');
                  },
                ),

                AppSpace.heightSpace_24,
                EnterAmountBox(
                  amountController: balanceController,
                  formKey: balanceFormKey,
                ),
                AppSpace.heightSpace_24,
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.splashGradiantColor1,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromRGBO(
                          255,
                          255,
                          255,
                          0.12,
                        ),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (shebaNumberFormKey.currentState!.validate()) {
                      if (balanceFormKey.currentState!.validate()) {

                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        'تایید و ادامه',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appWhite,
                        ),
                      ),
                      AppSpace.widthSpace_5,
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.iconColor
                            ?.resolve({}),
                      ),
                    ],
                  ),
                ),
              ),
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