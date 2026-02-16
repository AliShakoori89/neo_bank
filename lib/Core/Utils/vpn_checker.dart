import 'package:flutter/services.dart';

class VpnChecker {
  static const MethodChannel _channel = MethodChannel('vpn_checker');

  static Future<bool> isVpnActive() async {
    try {
      final bool isActive = await _channel.invokeMethod('isVpnActive');
      return isActive;
    } catch (e) {
      return false;
    }
  }
}
