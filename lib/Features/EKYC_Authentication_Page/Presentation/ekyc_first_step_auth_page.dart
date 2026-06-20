import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import '../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';

class EkycFirstStepAuthPage extends StatefulWidget {
  const EkycFirstStepAuthPage({super.key});

  @override
  State<EkycFirstStepAuthPage> createState() => _EkycFirstStepAuthPageState();
}

class _EkycFirstStepAuthPageState extends State<EkycFirstStepAuthPage> {

  final TextEditingController cardSerialController = TextEditingController();
  final GlobalKey<FormState> cardSerialFormKey = GlobalKey<FormState>();

  final TextEditingController monthController = TextEditingController();
  final GlobalKey<FormState> monthFormKey = GlobalKey<FormState>();

  final TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> yearFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(title: 'احراز هویت'),
            AppSpace.heightSpace_32,

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// ----------------- Card Serial -----------------
                    Text(
                      'شماره سریال کارت ملی:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.appBarTheme.titleTextStyle?.color,
                      ),
                    ),
                    AppSpace.heightSpace_8,

                    _customTextField(
                      controller: cardSerialController,
                      formKey: cardSerialFormKey,
                      hint: '1G23456789',
                      keyboardType: TextInputType.number,
                    ),

                    AppSpace.heightSpace_24,

                    /// ----------------- Expiry Date -----------------
                    Text(
                      'تاریخ انقضاء کارت ملی:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.appBarTheme.titleTextStyle?.color,
                      ),
                    ),
                    AppSpace.heightSpace_8,

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.surfaceDim,
                        ),
                      ),
                      child: Row(
                        children: [
                          /// Month
                          Expanded(
                            child: Form(
                              key: monthFormKey,
                              child: TextFormField(
                                controller: monthController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفا ماه انقضای کارت خود را وارد نمایید.';
                                  }
                                  return null;},
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'MM',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          Text(
                            '/',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),

                          /// Year
                          Expanded(
                            child: Form(
                              key: yearFormKey,
                              child: TextFormField(
                                controller: yearController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفا سال انقضای کارت خود را وارد نمایید.';
                                  }
                                  return null;},
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'YYYY',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      AppColors.splashGradiantColor1,
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if(cardSerialFormKey.currentState!.validate() &&
                    yearFormKey.currentState!.validate() &&
                    monthFormKey.currentState!.validate()){
                      context.go('/send_video_page');
                    }
                  },
                  child: const Text("تأیید و ادامه"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable TextField
  Widget _customTextField({
    required TextEditingController controller,
    required GlobalKey<FormState> formKey,
    required String hint,
    required TextInputType keyboardType,
  }) {
    return Form(
      key: cardSerialFormKey,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
          return 'لطفا شماره سریال کارت ملی خود را وارد نمایید.';
        }
          return null;},
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.splashGradiantColor1,
            ),
          ),
        ),
      ),
    );
  }
}