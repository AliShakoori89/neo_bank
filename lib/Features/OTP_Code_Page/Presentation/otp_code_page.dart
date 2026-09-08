import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Network/Internet/check_internet_when_press_button.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Widgets/neo_bank_logo.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'Bloc/Request_OTP_Again/request_otp_again_bloc.dart';
import 'Bloc/Request_OTP_Again/request_otp_again_event.dart';
import 'Bloc/Request_OTP_Again/request_otp_again_state.dart';
import 'Component/confirmation_button.dart';
import 'Component/edit_phone_number_bottun.dart';
import 'Component/otp_code_box.dart';
import 'Component/phone_number.dart';


class OtpCodePage extends StatefulWidget {
  const OtpCodePage({
    super.key,
    required this.phoneNumber,
    required this.secretKey,
    required this.deviceId,
    required this.nationalCode,
    required this.expireTime,
  });

  final String phoneNumber;
  final String nationalCode;
  final String secretKey;
  final String deviceId;
  final int expireTime;

  @override
  State<OtpCodePage> createState() => _OtpCodePageState();
}

class _OtpCodePageState extends State<OtpCodePage> {
  final TextEditingController _otpController = TextEditingController();

  bool isOtpComplete = false;
  int resendTimer = 0;
  Timer? timer;

  String? newSecretKey;
  String? newDeviceId;

  void _onOtpChanged(bool value) {
    setState(() {
      isOtpComplete = value;
    });
  }

  void _startTimer(int expireTime) {
    resendTimer = expireTime;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (resendTimer == 0) {
        t.cancel();
      } else {
        resendTimer--;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _restartTimerSafely(widget.expireTime);
  }

  void _restartTimerSafely(int expireTime) {
    timer?.cancel();
    resendTimer = expireTime;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }

      if (resendTimer == 0) {
        t.cancel();
      } else {
        setState(() {
          resendTimer--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestOtpAgainBloc, RequestOtpAgainState>(
      listenWhen: (previous, current) {
        return previous.status != current.status && current.status.isSuccess;
      },
      listener: (context, state) {
        newSecretKey = state.secretKey;
        newDeviceId = state.deviceId;

        _restartTimerSafely(widget.expireTime);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, theme) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 1),
                  radius: 2,
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    theme == AppTheme.lightTheme ? Colors.white : Colors.black,
                  ],
                  stops: [0.0, 0.5],
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints){
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              AppSpace.heightSpace_128,
                              NeoBankLogo(
                                logoColor: AppColors.splashGradiantColor1,
                                logoWidth: 98,
                                logoHeight: 24,
                                space: 5,
                              ),
                              AppSpace.heightSpace_32,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  bottom: 24,
                                  top: 24,
                                ),
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  top: 24,
                                  bottom: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.splashGradiantColor2.withAlpha(30),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    //edit phone number container
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.splashGradiantColor2.withAlpha(30),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 30, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            EditPhoneNumberButton(),
                                            AppSpace.widthSpace_48,
                                            PhoneNumber(phoneNumber: widget.phoneNumber),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AppSpace.heightSpace_24,
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 24),
                                      child: Text(
                                        'کد تایید را وارد کنید',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.primaryFixed,
                                        ),
                                      ),
                                    ),
                                    OtpCodeBox(
                                      otpController: _otpController,
                                      onCompleted: _onOtpChanged,
                                    ),
                                    AppSpace.heightSpace_24,
                                    ConfirmationButton(
                                      otpController: _otpController,
                                      isOtpComplete: isOtpComplete,
                                      secretKey: newSecretKey ?? widget.secretKey,
                                      deviceId: newDeviceId ?? widget.deviceId,
                                    ),
                                    AppSpace.heightSpace_24,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'زمان استفاده از کد',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).colorScheme.primaryFixed,
                                          ),
                                        ),
                                        resendTimer > 0
                                            ? Text(
                                          '$resendTimer ثانیه',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primaryFixed,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                            : GestureDetector(
                                          onTap: () {
                          
                                            CheckInternetWhenPressButton.checkInternet(
                                                context: context,
                                                onSuccess: () {
                                                  _startTimer(
                                                    widget.expireTime,
                                                  ); // ارسال مجدد OTP
                          
                                                  _otpController.clear();
                                                  _onOtpChanged(false);
                          
                                                  context.read<RequestOtpAgainBloc>().add(
                                                    RequestOTPCodeAgainEvent(
                                                      nationalCode: widget.nationalCode,
                                                      phoneNumber: widget.phoneNumber,
                                                    ),
                                                  );
                                                });
                          
                                          },
                                          child: Text(
                                            'ارسال مجدد کد',
                                            style: TextStyle(
                                              color: AppColors.splashGradiantColor1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
