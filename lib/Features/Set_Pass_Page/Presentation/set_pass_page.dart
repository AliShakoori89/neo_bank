import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/Services/Biometric_Service/biometric_service.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Theme/app_them.dart';
import '../../../Core/Widgets/neo_bank_logo.dart';
import '../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'Component/pass_field.dart';
import 'Component/set_pass_button.dart';

class SetPassPage extends StatefulWidget {
  const SetPassPage({super.key, this.inputFromProfile});

  final bool? inputFromProfile;

  @override
  State<SetPassPage> createState() => _SetPassPageState();
}

class _SetPassPageState extends State<SetPassPage> {
  final BiometricService _biometricService = BiometricService();
  bool isSupported = false;
  bool isSwitchOn = false;
  bool? passFieldsIsFill;

  static const _prefKey = 'biometric_enabled';

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await _checkBiometricSupport();
    await _isEnableBiometricLogin();
  }

  // بارگذاری وضعیت سوئیچ از SharedPreferences
  Future<void> _isEnableBiometricLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final storedValue = prefs.getBool(_prefKey) ?? false;
    if (!mounted) return;
    setState(() {
      isSwitchOn = storedValue;
    });
  }

  void _onpassFieldsIsFill(bool value) {
    setState(() {
      passFieldsIsFill = value;
    });
  }

  Future<void> _checkBiometricSupport() async {
    final supported = await _biometricService.isSupported();
    if (!mounted) return;
    setState(() {
      isSupported = supported;
    });
  }

  final TextEditingController _passFieldController = TextEditingController();

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
                            AppSpace.heightSpace_32,
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
                                  widget.inputFromProfile == null
                                      ? Text(
                                    'برای دسترسی آسان به اپلیکیشن رمز عبور مورد نظر خود را تعیین نمایید.',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium,)
                                      : Text(
                                          'پسورد مورد نظر خود را وارد نمایید.',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium,)
                                  ,
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
                      ),
                    ),
                  );
                }
              ),
            ),
          );
        },
      ),
    );
  }
}
