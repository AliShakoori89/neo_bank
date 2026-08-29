import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Spacing/app_space.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.push('/cant_login');
          },
          child: Text(
            'نمی توانید وارد شوید؟',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppSpace.widthSpace_5,
        Icon(
          Icons.arrow_forward,
          size: 20,
          color: AppColors.loginPageIconColor,
        ),
      ],
    );
  }
}
