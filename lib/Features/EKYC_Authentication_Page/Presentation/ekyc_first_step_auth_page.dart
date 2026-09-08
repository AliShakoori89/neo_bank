import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Widgets/app_snackbar.dart';
import '../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import 'Bloc/Create_Token_Bloc/create_token_bloc.dart';
import 'Bloc/Create_Token_Bloc/create_token_event.dart';
import 'Bloc/Create_Token_Bloc/create_token_state.dart';
import 'Bloc/Validate_token_Bloc/validate_token_bloc.dart';
import 'Bloc/Validate_token_Bloc/validate_token_event.dart';
import 'Bloc/Validate_token_Bloc/validate_token_state.dart';
import 'Component/convert_shamsi_to_miladi_method.dart';
import 'Component/custom_loading_button.dart';
import 'Component/input_serial_number_expire_date_widget.dart';
import 'Component/input_serial_number_widget.dart';

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

    return MultiBlocListener(
      listeners: [

        /// Create Token Listener
        BlocListener<CreateTokenBloc, CreateTokenState>(
          listener: (context, state) {

            if (state.status.isSuccess) {

              final tokenData = state.createTokenResponse.data;

              if (tokenData == null) {
                AppSnackBar.errorTop(context, 'اطلاعات توکن دریافت نشد');
                return;
              }

              context.read<ValidateTokenBloc>().add(
                ValidateTokenResponseEvent(
                  orderId: tokenData.orderId!,
                  tokenValue: tokenData.tokenValue!,
                  tokenExpirationDateTime: tokenData.tokenExpirationDateTimeUtc!.toIso8601String(),
                  cardExpDate: convertShamsiToMiladiMethod(yearController.text, monthController.text),
                  cardSerialNo: cardSerialController.text
                ),
              );
            }

            if (state.status.isError) {
              print(state.errorMessage);
              AppSnackBar.errorTop(
                context,
                state.errorMessage,
              );
            }
          },
        ),

        /// Validate Token Listener
        BlocListener<ValidateTokenBloc, ValidateTokenState>(
          listener: (context, state) {

            if (state.status.isSuccess) {
              context.go('/send_video_page');
            }

            if (state.status.isError) {
              AppSnackBar.errorTop(
                context,
                state.errorMessage,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: SafeArea(
          child: Column(
            children: [
              CustomHeader(title: 'احراز هویت', hasBackArrow: true,),
              AppSpace.heightSpace_32,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// ----------------- Card Serial -----------------
                      inputSerialNumberWidget(theme, cardSerialController, cardSerialFormKey),
                      // Text(
                      //   'شماره سریال کارت ملی:',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //     color: theme.appBarTheme.titleTextStyle?.color,
                      //   ),
                      // ),
                      // AppSpace.heightSpace_8,
                      //
                      // customTextField(
                      //   controller: cardSerialController,
                      //   hint: '1G23456789',
                      //   formKey: cardSerialFormKey,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'شماره سریال الزامی است';
                      //     }
                      //     return null;
                      //   },
                      // ),

                      AppSpace.heightSpace_24,

                      /// ----------------- Expiry Date -----------------

                      inputSerialNumberExpireDateWidget(
                          theme,
                          monthFormKey,
                          yearFormKey,
                          monthController,
                          yearController)
                      // Text(
                      //   'تاریخ انقضاء کارت ملی:',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //     color: theme.appBarTheme.titleTextStyle?.color,
                      //   ),
                      // ),
                      // AppSpace.heightSpace_8,
                      //
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     border: Border.all(
                      //       color: theme.colorScheme.surfaceDim,
                      //     ),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       /// Month
                      //       Expanded(
                      //         child: Form(
                      //           key: monthFormKey,
                      //           child: TextFormField(
                      //             controller: monthController,
                      //             keyboardType: TextInputType.number,
                      //             textAlign: TextAlign.center,
                      //             validator: (value) {
                      //               if (value == null || value.isEmpty) {
                      //                 return 'ماه الزامی است';
                      //               }
                      //
                      //               final month = int.tryParse(value);
                      //               if (month == null || month < 1 || month > 12) {
                      //                 return 'ماه باید بین 1 تا 12 باشد';
                      //               }
                      //
                      //               return null;
                      //             },
                      //             inputFormatters: [
                      //               FilteringTextInputFormatter.digitsOnly,
                      //               LengthLimitingTextInputFormatter(2),
                      //             ],
                      //             decoration: const InputDecoration(
                      //               hintText: 'MM',
                      //               hintStyle: TextStyle(
                      //                 color: AppColors.customHeaderTextColor
                      //               ),
                      //               border: InputBorder.none,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //
                      //       Text(
                      //         '/',
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //           color: theme.colorScheme.primary,
                      //         ),
                      //       ),
                      //
                      //       /// Year
                      //       Expanded(
                      //         child: Form(
                      //           key: yearFormKey,
                      //           child: TextFormField(
                      //             controller: yearController,
                      //             keyboardType: TextInputType.number,
                      //             textAlign: TextAlign.center,
                      //             validator: (value) {
                      //               if (value == null || value.isEmpty) {
                      //                 return 'سال الزامی است';
                      //               }
                      //
                      //               final year = int.tryParse(value);
                      //               if (year == null || year < 1300 || year > 1500) {
                      //                 return 'سال نامعتبر است';
                      //               }
                      //
                      //               return null;
                      //             },
                      //             inputFormatters: [
                      //               FilteringTextInputFormatter.digitsOnly,
                      //               LengthLimitingTextInputFormatter(4),
                      //             ],
                      //             decoration: const InputDecoration(
                      //               hintText: 'YYYY',
                      //               hintStyle: TextStyle(
                      //                   color: AppColors.customHeaderTextColor
                      //               ),
                      //               border: InputBorder.none,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              CustomLoadingButton(
                  onPressed: () {
                    if (cardSerialFormKey.currentState!.validate() &&
                        yearFormKey.currentState!.validate() &&
                        monthFormKey.currentState!.validate()) {

                      context.read<CreateTokenBloc>().add(
                        CreateTokenResponseEvent(
                          cardSerialNo: cardSerialController.text,
                          cardExpDate: convertShamsiToMiladiMethod(yearController.text, monthController.text),
                        ),
                      );

                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  }