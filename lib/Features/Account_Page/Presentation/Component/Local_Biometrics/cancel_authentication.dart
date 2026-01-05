import 'package:local_auth/local_auth.dart';

Future<void> cancelAuthentication(
  LocalAuthentication auth,
  bool isAuthenticating,
  Function setState,
) async {
  await auth.stopAuthentication();
  setState(() => isAuthenticating = false);
}
