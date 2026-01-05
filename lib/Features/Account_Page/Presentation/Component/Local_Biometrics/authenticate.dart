import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

Future<void> authenticate(
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
      localizedReason: 'Let OS determine authentication method',
      persistAcrossBackgrounding: true,
    );
    setState(() {
      isAuthenticating = false;
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
      authorized = 'Unexpected error - ${e.message}';
    });
    return;
  }
  if (!mounted()) {
    return;
  }

  setState(() => authorized = authenticated ? 'Authorized' : 'Not Authorized');
}
