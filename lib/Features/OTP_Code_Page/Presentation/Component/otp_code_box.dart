import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../../Core/Theme/app_colors.dart';

// ignore: must_be_immutable
class OtpCodeBox extends StatelessWidget {
  const OtpCodeBox({
    super.key,
    required this.otpController,
    required this.onCompleted,
  });

  final TextEditingController otpController;
  final Function onCompleted;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 5,
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: otpController,
        onChanged: (value) {
          onCompleted(value.length == 5);
        },
        onCompleted: (value) {
          onCompleted(true);
        },
        cursor: Icon(Icons.circle, color: Theme.of(context).colorScheme.primaryFixed),
        defaultPinTheme: PinTheme(
          width: 50,
          height: 55,
          textStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.splashGradiantColor1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
