import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/bank_card_selector.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/repetitive_contacts.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/enter_amount_box.dart';
import '../../../../../Core/Convertor/custom_formatter.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Theme/app_colors.dart';

class CartTabBody extends StatefulWidget {
  const CartTabBody({super.key});

  @override
  State<CartTabBody> createState() => _CartTabBodyState();
}

class _CartTabBodyState extends State<CartTabBody> {

  final CustomNumberFormatter balanceController = CustomNumberFormatter();
  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();

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

          BankCardSelector(heightSize: 50,),

          AppSpace.heightSpace_12,

          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30
            ),
            height: 180,
            child: Column(
              children: [
                // مبلغ انتقال
                EnterAmountBox(
                  amountController: balanceController,
                  formKey: balanceFormKey
                ),

                AppSpace.heightSpace_24,

                // دکمه تایید
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
                      if (balanceFormKey.currentState!.validate()) {

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

          RepetitiveContacts(),
        ],
      ),
    );
  }
}