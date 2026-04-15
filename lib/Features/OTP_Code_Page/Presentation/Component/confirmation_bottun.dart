import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/app_snackbar.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_event.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_state.dart';

import '../../../../Core/Utils/App_Lock/Internet/button_internet_checker.dart';

class ConfirmationBottun extends StatelessWidget {
  const ConfirmationBottun({
    super.key,
    required this.otpController,
    required this.isOtpComplete,
    required this.secretKey,
    required this.deviceId,
  });

  final TextEditingController otpController;
  final bool isOtpComplete;
  final String secretKey;
  final String deviceId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCodeCheckBloc, OtpCodeCheckState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          if (state.otpLoginStatus) {
            context.go('/set_pass_page');
          } else {
            AppSnackBar.errorTop(context, state.otpLoginMessage);
          }
        }
      },
      builder: (context, state) {
        return isOtpComplete
            ? SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.splashGradiantColor1, // حالت غیرفعال
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  onPressed: () {
                    final otp = otpController.text;

                    ButtonInternetChecker.checkInternet(
                      context: context,
                      onSuccess: () {
                        context.read<OtpCodeCheckBloc>().add(
                          OtpCodeCheckValueEvent(
                            deviceId: deviceId,
                            otpCode: otp,
                            secretKey: secretKey,
                          ),
                        );
                      });

                    context.read<OtpCodeCheckBloc>().add(
                      OtpCodeCheckValueEvent(
                        deviceId: deviceId,
                        otpCode: otp,
                        secretKey: secretKey,
                      ),
                    );


                  }, // 👈 وقتی null باشه دکمه قفله

                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        Text(
                          'تایید و ادامه',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Positioned(
                          left: 5,
                          child: Icon(Icons.arrow_forward, size: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Text(
                        'تایید و ادامه',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Positioned(
                        left: 5,
                        child: Icon(Icons.arrow_forward, size: 24),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
