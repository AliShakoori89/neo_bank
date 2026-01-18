import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_event.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_state.dart';

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
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<OtpCodeCheckBloc, OtpCodeCheckState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isOtpComplete
                  ? AppColors.splashGradiantColor1
                  : Colors.grey.shade400, // حالت غیرفعال
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            onPressed: isOtpComplete
                ? () {
                    final otp = otpController.text;
                    print('OTP => $otp');
                    // verify otp

                    print(
                      'state.otpLoginStatus       ' +
                          state.otpLoginStatus.toString(),
                    );

                    print(
                      'state.otpLoginStatus       ' + state.otpLoginMessage,
                    );

                    context.read<OtpCodeCheckBloc>().add(
                      OtpCodeCheckValueEvent(
                        deviceId: deviceId,
                        otpCode: otp,
                        secretKey: secretKey,
                      ),
                    );

                    if (state.otpLoginStatus) {
                      context.go('/set_page_page');
                    } else {
                      Fluttertoast.showToast(
                        msg: state.otpLoginMessage,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  }
                : null, // 👈 وقتی null باشه دکمه قفله

            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: const [
                  Text('تایید و ادامه'),
                  Positioned(
                    left: 5,
                    child: Icon(Icons.arrow_forward, size: 24),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
