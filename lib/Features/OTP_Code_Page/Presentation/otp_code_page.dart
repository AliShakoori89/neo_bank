import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_logo.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pinput/pinput.dart';

class OtpCodePage extends StatefulWidget {
  const OtpCodePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpCodePage> createState() => _OtpCodePageState();
}

class _OtpCodePageState extends State<OtpCodePage> {
  final TextEditingController _otpController = TextEditingController();

  bool isOtpComplete = false;
  int resendTimer = 0;
  Timer? timer;

  void _startTimer() {
    resendTimer = 60;
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

  void _stopTimer() {
    timer?.cancel();
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    _otpController.dispose(); // 👈 اینو اضافه کن
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
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
                              Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppColors.splashGradiantColor1,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'ویرایش',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              AppSpace.widthSpace_48,
                              Text(
                                widget.phoneNumber.toPersianDigit(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.customHeaderTextColor,
                                ),
                              ),
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
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          length: 5,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          controller: _otpController,
                          onChanged: (value) {
                            setState(() {
                              isOtpComplete = value.length == 5;
                            });
                          },
                          onCompleted: (value) {
                            setState(() {
                              isOtpComplete = true;
                            });
                          },
                          cursor: const Icon(Icons.circle, color: Colors.black),
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 55,
                            textStyle: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.splashGradiantColor1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      AppSpace.heightSpace_24,
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
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
                                  final otp = _otpController.text;
                                  print('OTP => $otp');
                                  // verify otp
                                  context.go('/main_page');
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
                        ),
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
