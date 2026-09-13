import 'package:flutter/material.dart';

import '../Spacing/app_space.dart';
import '../Theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonTitle, required this.buttonOnPressed});

  final String buttonTitle;
  final Function buttonOnPressed;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
        WidgetStateProperty.all<Color>(
          AppColors.splashGradiantColor1,
        ),
        shape:
        WidgetStateProperty.all<
            RoundedRectangleBorder
        >(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              7.0,
            ), // Adjust for desired corner radius
          ),
        ),
      ),
      onPressed: (){
        buttonOnPressed();
      },
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppSpace.widthSpace_5,
              Icon(Icons.arrow_forward, color: AppColors.appWhite)
            ],
          ),
        ),
      ),
    );
  }
}
