import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../Core/Const/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
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
        if (state.status == UserLoginAuthStatus.success) {
          if (state.logedin) {
            Fluttertoast.showToast(
              msg: 'ورود با موفقیت انجام شد',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            context.go('/otp_code_page', extra: phoneNumberController.text);
          } else {
            Fluttertoast.showToast(
              msg: 'نام کاربری یا رمز عبور اشتباه است',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else if (state.status == UserLoginAuthStatus.error) {
          Fluttertoast.showToast(
            msg: 'خطایی در برقراری ارتباط رخ داد',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
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
                      context.read<UserLoginAuthBloc>().add(
                        UserLoginEvent(
                          nationalCode: nationalCodeController.text,
                          phoneNumber: phoneNumberController.text,
                        ),
                      );
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
                  : const Text(
                      'ورود',
                      key: ValueKey('normal'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
