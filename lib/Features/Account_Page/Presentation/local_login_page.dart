import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Services/Biometric_Service/biometric_service.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Widgets/neo_bank_logo.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_bloc.dart';
import '../../Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_event.dart';
import '../../Set_Pass_Page/Presentation/Component/pass_field.dart';
import 'Component/custom_local_login_button.dart';

class LocalLoginPage extends StatefulWidget {
  const LocalLoginPage({super.key});

  @override
  State<LocalLoginPage> createState() => _LocalLoginPageState();
}

class _LocalLoginPageState extends State<LocalLoginPage> {
  TextEditingController localPassController = TextEditingController();
  final BiometricService _biometricService = BiometricService();

  bool? localPassFieldsIsFill;
  bool isSwitchOn = false;

  static const _prefKey = 'biometric_enabled';

  void onLocalPassFieldsIsFill(bool value) {
    setState(() {
      localPassFieldsIsFill = value;
    });
  }

  @override
  void initState() {
    BlocProvider.of<LocalPassBloc>(context).add(FetchLocalPassEvent());
    _initAsync();
    super.initState();
  }

  Future<void> _initAsync() async {
    await _isEnableBiometricLogin();
  }

  Future<void> _isEnableBiometricLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final storedValue = prefs.getBool(_prefKey) ?? false;
    if (!mounted) return;
    setState(() {
      isSwitchOn = storedValue;
    });

    if(isSwitchOn){
      final success = await _biometricService.authenticate(true);
      if (success) {
        context.go('/main_page');
      }else{
        return;
      }
    }else{
      return;
    }
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
                            CustomLocalLoginButton(localPassController: localPassController),
                            isSwitchOn ? AppSpace.heightSpace_64 : Container(),
                            isSwitchOn ? IconButton(
                                onPressed: () async{
                                  final success = await _biometricService.authenticate(true);
                                  if(success){
                                    context.go('/main_page', extra: 0);
                                  }
                                },
                                icon: Icon(
                                  Icons.fingerprint,
                                  size: 50,
                                  color: theme.colorScheme.primary,))
                                : Container(),
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
