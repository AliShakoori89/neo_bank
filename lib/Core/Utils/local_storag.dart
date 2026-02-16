import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {

  static final EncryptedSharedPreferences _prefs =
  EncryptedSharedPreferences();

  static Future<void> save(String key, String value) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      print("Error saving encrypted value: $e");
    }
  }

  static Future<String?> get(String key) async {
    try {
      return await _prefs.getString(key);
    } catch (e) {
      print("Error reading encrypted value: $e");
      return null;
    }
  }

  // static Future<bool> isTokenExpired() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final expire = prefs.getString('token_expire_at');
  //
  //   if (expire == null) return true;
  //
  //   return DateTime.now().toUtc().isAfter(DateTime.parse(expire));
  // }

  static Future<void> clear() async {
    try {
      await _prefs.remove('token');
      await _prefs.remove('token_expire_at');
    } catch (e) {
      print("Error removing encrypted value: $e");
    }

  }
}
