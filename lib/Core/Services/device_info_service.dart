import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class DeviceInfoService {
  static final _deviceInfo = DeviceInfoPlugin();

  static Future<String> _getAppScopedId() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'app_device_id';

    final existing = prefs.getString(key);
    if (existing != null) return existing;

    final newId =
        '${DateTime.now().millisecondsSinceEpoch}_${Platform.operatingSystem}';
    await prefs.setString(key, newId);
    return newId;
  }

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      return {
        "platform": "ANDROID",
        "deviceModel": "${android.brand} ${android.model}",
        "osVersion": android.version.release,
        "deviceId": android.id, // ANDROID_ID
        "appDeviceId": await _getAppScopedId(),
        "appVersion": packageInfo.version,
      };
    }

    if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      return {
        "platform": "IOS",
        "deviceModel": ios.utsname.machine,
        "osVersion": ios.systemVersion,
        "deviceId": ios.identifierForVendor,
        "appDeviceId": await _getAppScopedId(),
        "appVersion": packageInfo.version,
      };
    }

    throw UnsupportedError('Unsupported platform');
  }
}
