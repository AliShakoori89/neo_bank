import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expire = prefs.getString('token_expire_at');

    if (expire == null) return true;

    return DateTime.now().toUtc().isAfter(DateTime.parse(expire));
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('token_expire_at');
  }
}
