import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_logo.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Component/confirmation_bottun.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Component/edit_phone_number_bottun.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Component/otp_code_box.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Component/phone_number.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

class OtpCodePage extends StatefulWidget {
  const OtpCodePage({
    super.key,
    required this.phoneNumber,
    required this.secretKey,
    required this.deviceId,
  });

  final String phoneNumber;
  final String secretKey;
  final String deviceId;

  @override
  State<OtpCodePage> createState() => _OtpCodePageState();
}

class _OtpCodePageState extends State<OtpCodePage> {
  final TextEditingController _otpController = TextEditingController();

  bool isOtpComplete = false;
  int resendTimer = 0;
  Timer? timer;

  void _onOtpChanged(bool value) {
    setState(() {
      isOtpComplete = value;
    });
  }

  void _startTimer() {
    resendTimer = 120;
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
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme == AppTheme.lightTheme
                    ? [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ]
                    : [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ],
              ),
            ),
            child: Column(
              children: [
                AppSpace.heightSpace_128,
                NeoBankLogo(
                  logoColor: AppColors.splashGradiantColor1,
                  logoWidth: 98,
                  logoHeight: 24,
                  space: 5,
                ),
                AppSpace.heightSpace_128,
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
                              EditPhoneNumberBottun(),
                              AppSpace.widthSpace_48,
                              PhoneNumber(phoneNumber: widget.phoneNumber),
                            ],
                          ),
                        ),
                      ),
                      AppSpace.heightSpace_24,
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: const Text(
                          'کد تایید را وارد کنید',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      OtpCodeBox(
                        otpController: _otpController,
                        onCompleted: _onOtpChanged,
                      ),
                      AppSpace.heightSpace_24,
                      ConfirmationBottun(
                        otpController: _otpController,
                        isOtpComplete: isOtpComplete,
                        secretKey: widget.secretKey,
                        deviceId: widget.deviceId,
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
                              color: AppColors.customHeaderTextColor,
                            ),
                          ),
                          resendTimer > 0
                              ? Text(
                                  '$resendTimer ثانیه',
                                  style: TextStyle(
                                    color: AppColors.customHeaderTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    _startTimer(); // ارسال مجدد OTP
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
          );
        },
      ),
    );
  }
}
