import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserLoginAuthBloc, UserLoginAuthState>(
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
            context.go('/main_page');
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
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
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
            context.read<UserLoginAuthBloc>().add(
              UserLoginEvent(
                username: usernameController.text,
                password: passwordController.text,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fingerprint,
                  color: Theme.of(context).colorScheme.scrim,
                  size: 20,
                ),
                AppSpace.widthSpace_8,
                Text(
                  'ورود با اثر انگشت',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.appWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
