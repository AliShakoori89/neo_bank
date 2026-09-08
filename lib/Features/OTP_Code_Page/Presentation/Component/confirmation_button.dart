import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Network/Internet/check_internet_when_press_button.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Widgets/app_snackbar.dart';
import '../../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_bloc.dart';
import '../../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_event.dart';
import '../Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import '../Bloc/OTP_Code_Check/otp_code_check_event.dart';
import '../Bloc/OTP_Code_Check/otp_code_check_state.dart';

class ConfirmationButton extends StatefulWidget {
  const ConfirmationButton({
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
  State<ConfirmationButton> createState() => _ConfirmationButtonState();
}

class _ConfirmationButtonState extends State<ConfirmationButton> {

  @override
  void initState() {
    BlocProvider.of<LocalPassBloc>(context).add(IsFirstLoginEvent());
    super.initState();
  }


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
        return widget.isOtpComplete
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
              final otp = widget.otpController.text;

              CheckInternetWhenPressButton.checkInternet(
                  context: context,
                  onSuccess: () {
                    context.read<OtpCodeCheckBloc>().add(
                      OtpCodeCheckValueEvent(
                        deviceId: widget.deviceId,
                        otpCode: otp,
                        secretKey: widget.secretKey,
                      ),
                    );
                  });

              // context.read<OtpCodeCheckBloc>().add(
              //   OtpCodeCheckValueEvent(
              //     deviceId: widget.deviceId,
              //     otpCode: otp,
              //     secretKey: widget.secretKey,
              //   ),
              // );


            }, // 👈 وقتی null باشه دکمه قفله

            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: const [
                  Positioned(
                    right: 15,
                    child: Icon(Icons.arrow_back, size: 24),
                  ),
                  Text(
                    'تایید و ادامه',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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

                Positioned(
                  right: 15,
                  child: Icon(Icons.arrow_back, size: 24),
                ),
                Text(
                  'تایید و ادامه',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
