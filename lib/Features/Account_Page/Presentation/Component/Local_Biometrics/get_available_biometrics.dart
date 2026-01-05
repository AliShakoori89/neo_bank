import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

Future<void> getAvailableBiometrics(
  LocalAuthentication auth,
  Function setState,
  Function mounted,
) async {
  late List<BiometricType> availableBiometrics;
  try {
    availableBiometrics = await auth.getAvailableBiometrics();
  } on PlatformException catch (e) {
    availableBiometrics = <BiometricType>[];
    print(e);
  }
  if (!mounted()) {
    return;
  }

  setState(() {
    availableBiometrics = availableBiometrics;
  });
}
