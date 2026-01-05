import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

Future<void> checkBiometrics(
  LocalAuthentication auth,
  Function setState,
  Function mounted,
  bool canCheckBiometrics,
) async {
  try {
    canCheckBiometrics = await auth.canCheckBiometrics;
  } on PlatformException catch (e) {
    canCheckBiometrics = false;
    print(e);
  }
  if (!mounted()) {
    return;
  }

  setState(() {
    canCheckBiometrics = canCheckBiometrics;
  });
}
