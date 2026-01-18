import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> isLoggedIn() async {
    final token = await read('secret_key');
    return token != null && token.isNotEmpty;
  }

  // static Future<bool> isTokenExpired() async {
  //   final expire = await read('token_expire_at');
  //   return expire == null || DateTime.now().isAfter(DateTime.parse(expire));
  // }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
