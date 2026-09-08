import 'package:flutter/material.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Widgets/neo_bank_logo.dart';
import '../../../Core/Widgets/neo_bank_version.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Component/custom_login_button.dart';
import 'Component/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> nationalCodeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 1),
                radius: 2,
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  theme == AppTheme.lightTheme ? Colors.white : Colors.black,
                ],
                stops: [0.0, 0.5],
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
                                  // کد ملی
                                  CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    hintText: 'کد ملی',
                                    obscureText: false,
                                    controller: nationalCodeController,
                                    formKey: nationalCodeFormKey,
                                  ),
                                  Divider(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceDim,
                                  ),

                                  // شماره همراه
                                  CustomTextFormField(
                                    textInputType: TextInputType.phone,
                                    hintText: 'شماره همراه',
                                    obscureText: false,
                                    controller: phoneNumberController,
                                    formKey: phoneNumberFormKey,
                                  ),
                                ],
                              ),
                            ),
                            AppSpace.heightSpace_32,

                            // ورود
                            CustomLoginButton(
                              nationalCodeController: nationalCodeController,
                              phoneNumberController: phoneNumberController,
                              nationalCodeFormKey: nationalCodeFormKey,
                              phoneNumberFormKey: phoneNumberFormKey,
                            ),

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
