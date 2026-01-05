import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
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

enum _SupportState { unknown, supported, unsupported }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
      (bool isSupported) => setState(
        () => _supportState = isSupported
            ? _SupportState.supported
            : _SupportState.unsupported,
      ),
    );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print(availableBiometrics);
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        persistAcrossBackgrounding: true,
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on LocalAuthException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        if (e.code != LocalAuthExceptionCode.userCanceled &&
            e.code != LocalAuthExceptionCode.systemCanceled) {
          _authorized =
              'Error - ${e.code.name}${e.description != null ? ': ${e.description}' : ''}';
        }
      });
      return;
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Unexpected error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
      () => _authorized = authenticated ? 'Authorized' : 'Not Authorized',
    );
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        persistAcrossBackgrounding: true,
        biometricOnly: true,
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on LocalAuthException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        if (e.code != LocalAuthExceptionCode.userCanceled &&
            e.code != LocalAuthExceptionCode.systemCanceled) {
          _authorized =
              'Error - ${e.code.name}${e.description != null ? ': ${e.description}' : ''}';
        }
      });
      return;
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Unexpected Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
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
                                  // کد ملی
                                  CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    hintText: 'کد ملی',
                                    obscureText: false,
                                    controller: nationalCodeController,
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
                                  ),
                                ],
                              ),
                            ),
                            AppSpace.heightSpace_32,

                            // ورود
                            CustomButton(
                              nationalCodeController: nationalCodeController,
                              phoneNumberController: phoneNumberController,
                            ),

                            AppSpace.heightSpace_16,

                            // نمی توانید وارد شوید
                            CustomTextButton(),

                            AppSpace.heightSpace_128,

                            InkWell(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                child: Icon(
                                  Icons.fingerprint,
                                  color: Theme.of(context).colorScheme.scrim,
                                  size: 50,
                                ),
                              ),
                              onTap: () {
                                // if (_supportState == _SupportState.unknown)
                                //   const CircularProgressIndicator();
                                // else if (_supportState ==
                                //     _SupportState.supported)
                                //   const Text('This device is supported');
                                // else
                                //   const Text('This device is not supported');
                              },
                            ),

                            if (_supportState == _SupportState.unknown)
                              const CircularProgressIndicator()
                            else if (_supportState == _SupportState.supported)
                              const Text('This device is supported')
                            else
                              const Text('This device is not supported'),
                            const Divider(height: 100),
                            Text(
                              'Can check biometrics: $_canCheckBiometrics\n',
                            ),
                            ElevatedButton(
                              onPressed: _checkBiometrics,
                              child: const Text('Check biometrics'),
                            ),
                            const Divider(height: 100),
                            Text(
                              'Available biometrics: $_availableBiometrics\n',
                            ),
                            ElevatedButton(
                              onPressed: _getAvailableBiometrics,
                              child: const Text('Get available biometrics'),
                            ),
                            const Divider(height: 100),
                            Text('Current State: $_authorized\n'),
                            if (_isAuthenticating)
                              ElevatedButton(
                                onPressed: _cancelAuthentication,
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('Cancel Authentication'),
                                    Icon(Icons.cancel),
                                  ],
                                ),
                              )
                            else
                              Column(
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: _authenticate,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('Authenticate'),
                                        Icon(Icons.perm_device_information),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: _authenticateWithBiometrics,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          _isAuthenticating
                                              ? 'Cancel'
                                              : 'Authenticate: biometrics only',
                                        ),
                                        const Icon(Icons.fingerprint),
                                      ],
                                    ),
                                  ),
                                ],
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
