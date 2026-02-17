import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static final EncryptedSharedPreferences _prefs =
  EncryptedSharedPreferences();

  static Future<void> save(String key, String value) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      // خطا در ذخیره‌سازی امن
      print("Error saving encrypted value: $e");
    }
  }

  static Future<void> remove(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      print("Error removing encrypted value: $e");
    }
  }

  static Future<String?> read(String key) async {
    try {
      final value = await _prefs.getString(key);
      if (value == null || value.isEmpty || value == 'null') return null;
      return value;
    } catch (e) {
      print("Error reading encrypted value: $e");
      return null;
    }
  }


  static Future<bool> isLoggedIn() async {
    final token = await read('secret_key');
    return token != null && token.isNotEmpty;
  }

  // static Future<bool> isTokenExpired() async {
  //   final expire = await read('token_expire_at');
  //   return expire == null || DateTime.now().isAfter(DateTime.parse(expire));
  // }

  static clearPrefsExcept(List<String> keepKeys) async {
    final prefs = await SharedPreferences.getInstance();

    // ذخیره مقدار کلیدهای مهم
    final Map<String, Object> backup = {};

    for (final key in keepKeys) {
      if (prefs.containsKey(key)) {
        final value = prefs.get(key);
        if (value != null) {
          backup[key] = value;
        }
      }
    }

    // پاک کردن همه چیز
    await prefs.clear();

    // برگرداندن کلیدهای مهم
    for (final entry in backup.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String)
        await prefs.setString(key, value);
      else if (value is int)
        await prefs.setInt(key, value);
      else if (value is bool)
        await prefs.setBool(key, value);
      else if (value is double)
        await prefs.setDouble(key, value);
      else if (value is List<String>) {
        await prefs.setStringList(key, value);
      }
    }
  }

  static Future<void> clear() async {
    try {
      await _prefs.remove('token');
      await _prefs.remove('token_expire_at');
    } catch (e) {
      print("Error removing encrypted value: $e");
    }

  }
}
