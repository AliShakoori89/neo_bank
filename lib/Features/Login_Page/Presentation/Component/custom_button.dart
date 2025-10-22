import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              AppColors.splashGradiantColor1),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0), // Adjust for desired corner radius
            ),
          ),
        ),
        onPressed: (){
          context.go('/main_page');
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint,
                color: Theme.of(context).colorScheme.scrim,
                size: 20,
              ),
              AppSpace.widthSpace_8,
              Text('ورود با اثر انگشت',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.appWhite,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
