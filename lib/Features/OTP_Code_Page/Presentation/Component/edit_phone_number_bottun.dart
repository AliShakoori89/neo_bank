import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Services/token_storage_service.dart';
import '../../../../Core/Theme/app_colors.dart';

class EditPhoneNumberButton extends StatelessWidget {
  const EditPhoneNumberButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LocalStorageService.clear();
        context.go('/login_page');
      },
      child: Container(
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
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
        ),
      ),
    );
  }
}
