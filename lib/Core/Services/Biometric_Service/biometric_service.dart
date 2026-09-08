import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  // بررسی اینکه دستگاه از بیومتریک پشتیبانی می‌کند یا نه
  Future<bool> isSupported() async {
    try {
      final biometrics = await _auth.getAvailableBiometrics();
      print('Available biometrics: $biometrics');
      print('Biometrics supported: ${await _auth.canCheckBiometrics}');
      print('Device supported: ${await _auth.isDeviceSupported()}');


      final canCheck = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (_) {
      return false;
    }
  }

  // احراز هویت بیومتریک
  Future<bool> authenticate(bool comeFromLogin) async {
    try {
      return await _auth.authenticate(
        localizedReason: comeFromLogin ? 'برای ورود بیومتریک احراز هویت شوید' : 'برای فعال‌سازی ورود بیومتریک احراز هویت شوید',
        biometricOnly: true,
      );
    } catch (e) {
      print('Biometric auth error: $e');
      return false;
    }
  }
}
