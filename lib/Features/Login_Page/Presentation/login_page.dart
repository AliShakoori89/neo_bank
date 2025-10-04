import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';

import '../../../Core/Const/stack_circle.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import '../../../Core/Utils/neo_bank_version.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: theme == AppTheme.lightTheme
                      ? [
                    Theme
                        .of(context)
                        .colorScheme
                        .primaryContainer,
                    Theme
                        .of(context)
                        .colorScheme
                        .secondaryContainer,
                  ]
                      : [
                    Theme
                        .of(context)
                        .colorScheme
                        .primaryContainer,
                    Theme
                        .of(context)
                        .colorScheme
                        .primaryContainer,
                    Theme
                        .of(context)
                        .colorScheme
                        .primaryContainer,
                    Theme
                        .of(context)
                        .colorScheme
                        .secondaryContainer,
                    Theme
                        .of(context)
                        .colorScheme
                        .secondaryContainer,
                  ]
              )
            ),
            child: Column(
              children: [
                AppSpace.heightSpace_128,
                NeoBankLogo(logoColor: AppColors.splashGradiantColor1,
                  logoWidth: 98,
                  logoHeight: 24,
                  space: 5,
                ),
                AppSpace.heightSpace_128,
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: Theme.of(context).colorScheme.surfaceDim),
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'نام کاربری',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                              hintTextDirection: TextDirection.rtl,
                              contentPadding: EdgeInsets.symmetric(vertical: 12.0), // تنظیم پدینگ عمودی
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.surfaceDim
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.right,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'رمز عبور',
                              hintStyle: TextStyle(
                                color: AppColors.loginPageHintFontColor,
                                fontWeight: FontWeight.w400,
                              ),
                              hintTextDirection: TextDirection.rtl,
                              contentPadding: EdgeInsets.symmetric(vertical: 12.0), // تنظیم پدینگ عمودی
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpace.heightSpace_32,
                Container(
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
                ),
                AppSpace.heightSpace_16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        context.push('/cant_login');
                      },
                      child: Text('نمی توانید وارد شوید؟',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AppSpace.widthSpace_5,
                    Icon(Icons.arrow_forward,
                      size: 20,
                      color: AppColors.loginPageIconColor,
                    ),
                  ],
                ),
                Spacer(),
                NeoBankVersion(textColor: Theme.of(context).colorScheme.tertiary),
                SizedBox(height: 40),
              ],
            ),
          );
        }
      ),
    );
  }
}
