import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Network/Internet/check_internet_when_press_button.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../Bloc/Local_Pass_Bloc/local_pass_bloc.dart';
import '../Bloc/Local_Pass_Bloc/local_pass_event.dart';

class SetPassButton extends StatelessWidget {
  const SetPassButton({
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

            CheckInternetWhenPressButton.checkInternet(
                context: context,
                onSuccess: () {

                  context.go('/main_page');
                  context.read<LocalPassBloc>().add(
                      SetPassEvent(pass: passField));
                });

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
