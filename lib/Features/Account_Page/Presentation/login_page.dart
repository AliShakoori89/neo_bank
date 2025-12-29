import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/custom_button.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/custom_text_button.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/custom_text_form_field.dart';
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
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceDim,
                                ),
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // نام کاربری
                                  CustomTextFormField(
                                    textInputType: TextInputType.name,
                                    hintText: 'نام کاربری',
                                    obscureText: false,
                                    controller: usernameController,
                                  ),
                                  Divider(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceDim,
                                  ),

                                  // رمز عبور
                                  CustomTextFormField(
                                    textInputType: TextInputType.none,
                                    hintText: 'رمز عبور',
                                    obscureText: true,
                                    controller: passwordController,
                                  ),
                                ],
                              ),
                            ),
                            AppSpace.heightSpace_32,

                            // ورود با اثر انگشت
                            CustomButton(
                              usernameController: usernameController,
                              passwordController: passwordController,
                            ),
                            AppSpace.heightSpace_16,

                            // نمی توانید وارد شوید
                            CustomTextButton(),

                            Spacer(), // 👈 بقیه محتوا رو بالا نگه می‌داره

                            NeoBankVersion(
                              textColor: Theme.of(context).colorScheme.tertiary,
                            ),
                            AppSpace.heightSpace_42, // 👈 فاصله‌ی دقیق از پایین
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
