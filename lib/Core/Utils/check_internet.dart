import 'dart:async';
import 'dart:io';

Future<bool> checkInternetConnection({
  Duration timeout = const Duration(seconds: 5),
}) async {
  try {
    final result = await InternetAddress.lookup('example.com').timeout(timeout);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException catch (_) {
    return false;
  } on TimeoutException catch (_) {
    return false;
  }
}
