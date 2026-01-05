import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

Future<void> authenticateWithBiometrics(
  LocalAuthentication auth,
  bool isAuthenticating,
  String authorized,
  Function setState,
  Function mounted,
) async {
  bool authenticated = false;
  try {
    setState(() {
      isAuthenticating = true;
      authorized = 'Authenticating';
    });
    authenticated = await auth.authenticate(
      localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
      persistAcrossBackgrounding: true,
      biometricOnly: true,
    );
    setState(() {
      isAuthenticating = false;
      authorized = 'Authenticating';
    });
  } on LocalAuthException catch (e) {
    print(e);
    setState(() {
      isAuthenticating = false;
      if (e.code != LocalAuthExceptionCode.userCanceled &&
          e.code != LocalAuthExceptionCode.systemCanceled) {
        authorized =
            'Error - ${e.code.name}${e.description != null ? ': ${e.description}' : ''}';
      }
    });
    return;
  } on PlatformException catch (e) {
    print(e);
    setState(() {
      isAuthenticating = false;
      authorized = 'Unexpected Error - ${e.message}';
    });
    return;
  }
  if (!mounted()) {
    return;
  }

  final String message = authenticated ? 'Authorized' : 'Not Authorized';
  setState(() {
    authorized = message;
  });
}
