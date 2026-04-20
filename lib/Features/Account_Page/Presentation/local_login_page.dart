import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/app_snackbar.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_state.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Component/pass_field.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Utils/App_Lock/Internet/button_internet_checker.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_event.dart';

class LocalLoginPage extends StatefulWidget {
  const LocalLoginPage({super.key});

  @override
  State<LocalLoginPage> createState() => _LocalLoginPageState();
}

class _LocalLoginPageState extends State<LocalLoginPage> {
  TextEditingController localPassController = TextEditingController();

  bool? localPassFieldsIsFill;

  void onLocalPassFieldsIsFill(bool value) {
    setState(() {
      localPassFieldsIsFill = value;
    });
  }

  @override
  void initState() {
    BlocProvider.of<LocalPassBloc>(context).add(FetchLocalPassEvent());
    super.initState();
  }

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSpace.heightSpace_64,
                            NeoBankLogo(
                              logoColor: AppColors.splashGradiantColor1,
                              logoWidth: 98,
                              logoHeight: 24,
                              space: 5,
                            ),
                            AppSpace.heightSpace_32,
                            PassField(
                              passFieldController: localPassController,
                              onpassFieldsIsFill: onLocalPassFieldsIsFill,
                            ),
                            AppSpace.heightSpace_16,

                            // ورود
                            localPassFieldsIsFill != true
                                ? Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  bottom: 5,
                                ),
                                child: Text(
                                  'رمز عبور خود را وارد نمایید.',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                                : Text(''),
                            BlocBuilder<LocalPassBloc, LocalPassState>(
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
                                      shape:
                                      WidgetStateProperty.all<
                                          RoundedRectangleBorder
                                      >(
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

                                          ButtonInternetChecker.checkInternet(
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
                            ),
                            AppSpace.heightSpace_128,
                          ],
                        )
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
