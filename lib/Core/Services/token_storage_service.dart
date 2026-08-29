import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class LocalStorageService {

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
      if (value.isEmpty || value == 'null') return null;
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

  // static Future<void> clearPrefsExcept() async {
  //   try {
  //     final List<String> keysToDelete = [];
  //     final List<String> allKey = ['local_password' , 'isDarkTheme', 'secret_key', 'access_token'];
  //
  //     for (String key in allKey) {
  //       if (key != 'isDarkTheme') {
  //         keysToDelete.add(key);
  //       }
  //     }
  //
  //     for (String key in keysToDelete) {
  //       await _prefs.remove(key);
  //       print('Deleted key: $key');
  //     }
  //
  //     print('Successfully cleared all encrypted preferences except local_password.');
  //
  //   } catch (e) {
  //     print("Error clearing encrypted preferences: $e");
  //   }
  // }

  static Future<void> clear() async {
    await _prefs.clear();
  }
}
