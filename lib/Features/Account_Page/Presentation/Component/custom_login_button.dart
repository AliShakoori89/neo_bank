import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Network/Internet/check_internet_when_press_button.dart';
import '../../../../Core/Routes/otp_args.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Widgets/app_snackbar.dart';
import '../Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import '../Bloc/User_Login_Auth/user_login_auth_event.dart';
import '../Bloc/User_Login_Auth/user_login_auth_state.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    super.key,
    required this.nationalCodeController,
    required this.phoneNumberController,
    required this.nationalCodeFormKey,
    required this.phoneNumberFormKey,
  });

  final TextEditingController nationalCodeController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> nationalCodeFormKey;
  final GlobalKey<FormState> phoneNumberFormKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginAuthBloc, UserLoginAuthState>(
      listener: (context, state) {
        if (state.status == UserLoginAuthStatus.success && state.loginStatus) {
          context.go(
            '/otp_code_page',
            extra: OtpArgs(
              phoneNumber: phoneNumberController.text,
              nationalCode: nationalCodeController.text,
              deviceId: state.deviceId,
              secretKey: state.secretKey,
              expireTime: state.expireTime,
            ),
          );
        }

        if (state.status == UserLoginAuthStatus.error) {
          print(state.loginMessage);
          AppSnackBar.errorTop(context, state.loginMessage);
        }
      },

      builder: (context, state) {
        final isLoading = state.status == UserLoginAuthStatus.loading;

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
            onPressed: isLoading
                ? null
                : () {
                    if (nationalCodeFormKey.currentState!.validate() &&
                        phoneNumberFormKey.currentState!.validate()) {

                      CheckInternetWhenPressButton.checkInternet(
                        context: context,
                        onSuccess: () {
                          context.read<UserLoginAuthBloc>().add(
                            UserLoginEvent(
                              nationalCode: nationalCodeController.text,
                              phoneNumber: phoneNumberController.text,
                            ),
                          );
                        });

                    }
                  },
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: isLoading
                  ? Row(
                      key: const ValueKey('loading'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.3,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'در حال بررسی…',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Positioned(
                            right: 2,
                            child: Icon(Icons.arrow_back, size: 24),
                          ),
                          Text(
                            'تایید و ادامه',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
