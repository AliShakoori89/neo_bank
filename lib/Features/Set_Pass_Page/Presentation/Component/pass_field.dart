import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../../Core/Theme/app_colors.dart';

// ignore: must_be_immutable
class PassField extends StatelessWidget {
  const PassField({
    super.key,
    required this.passFieldController,
    required this.onpassFieldsIsFill,
  });

  final TextEditingController passFieldController;
  final Function onpassFieldsIsFill;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 4,
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: passFieldController,
        onChanged: (value) {
          onpassFieldsIsFill(value.length == 4);
        },
        onCompleted: (value) {
          onpassFieldsIsFill(true);
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
