import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';

class SetPassButton extends StatelessWidget {
  SetPassButton({
    super.key,
    required this.passField,
    required this.onpassFieldsIsFill,
  });

  final String passField;
  final bool? onpassFieldsIsFill;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            AppColors.splashGradiantColor1,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                7.0,
              ), // Adjust for desired corner radius
            ),
          ),
        ),
        onPressed: () {
          if (onpassFieldsIsFill != null &&
              onpassFieldsIsFill == true &&
              passField.length == 4) {
            context.go('/main_page');

            LocalStorage.save('local_password', passField);
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              'تایید',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
