import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Network/Internet/check_internet_when_press_button.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Widgets/app_snackbar.dart';
import '../../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_bloc.dart';
import '../../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_state.dart';

class CustomLocalLoginButton extends StatelessWidget {
  const CustomLocalLoginButton({super.key, required this.localPassController});

  final TextEditingController localPassController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalPassBloc, LocalPassState>(
      builder: (context, state){
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(
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
            onPressed: () async {

              final localPass = state.localPass;

              if(localPassController.text.length < 4){

                AppSnackBar.errorTop(
                  context,
                  'پسورد را کامل وارد نمایید.',
                );
              } else{
                if (localPassController.text ==
                    localPass.toString()) {

                  CheckInternetWhenPressButton.checkInternet(
                    context: context,
                    onSuccess: () {
                      context.go('/main_page', extra: 0);
                    },
                  );

                } else {
                  AppSnackBar.errorTop(
                    context,
                    'پسورد اشتباه است.',
                  );
                }
              }


            },
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'تایید',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
