import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_logo.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Component/pass_field.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Component/set_pass_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Profile_Page/Presentation/Component/Biometric_Service/biometric_service.dart';

class SetPassPage extends StatefulWidget {
  const SetPassPage({super.key});

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
    await _loadSwitchState();
  }

  // بارگذاری وضعیت سوئیچ از SharedPreferences
  Future<void> _loadSwitchState() async {
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
                        style: Theme.of(context).textTheme.titleMedium,
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
