import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_logo.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Component/pass_field.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Component/set_pass_button.dart';
import 'package:pinput/pinput.dart';

class SetPassPage extends StatefulWidget {
  SetPassPage({super.key});

  @override
  State<SetPassPage> createState() => _SetPassPageState();
}

class _SetPassPageState extends State<SetPassPage> {
  bool? passFieldsIsFill;

  void _onpassFieldsIsFill(bool value) {
    setState(() {
      passFieldsIsFill = value;
    });
  }

  final TextEditingController _passFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme == AppTheme.lightTheme
                    ? [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ]
                    : [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ],
              ),
            ),
            child: Column(
              children: [
                AppSpace.heightSpace_128,
                NeoBankLogo(
                  logoColor: AppColors.splashGradiantColor1,
                  logoWidth: 98,
                  logoHeight: 24,
                  space: 5,
                ),
                AppSpace.heightSpace_128,
                Container(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    top: 24,
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.splashGradiantColor2.withAlpha(30),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'برای دسترسی آسان به اپلیکیشن رمز عبور مورد نظر خود را تعیین نمایید.',
                        style: TextStyle(
                          color: AppColors.homePageCardTitleColor,
                        ),
                      ),
                      SizedBox(height: 50),
                      PassField(
                        passFieldController: _passFieldController,
                        onpassFieldsIsFill: _onpassFieldsIsFill,
                      ),
                      SizedBox(height: 50),
                      passFieldsIsFill != true
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  bottom: 5,
                                ),
                                child: Text(
                                  'رمز عبور باید از چهار رقم تشکیل شده باشد.',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : Text(''),
                      SetPassButton(
                        passField: _passFieldController.text,
                        onpassFieldsIsFill: passFieldsIsFill,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
