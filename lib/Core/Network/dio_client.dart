import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIKey.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  )..interceptors.add(_authInterceptor);

  static Dio get dio => _dio;

  /// 🔐 interceptor احراز هویت + expire
  static final InterceptorsWrapper _authInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      // چک expire واقعی
      final isExpired = await TokenStorage.isTokenExpired();
      if (isExpired) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: 'TOKEN_EXPIRED',
            response: Response(requestOptions: options, statusCode: 401),
          ),
        );
        return;
      }

      // ست کردن توکن
      final token = await TokenStorage.get('token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    },

    onError: (error, handler) {
      // اینجا فقط پاس می‌دیم تا Bloc تصمیم بگیره
      handler.next(error);
    },
  );
}

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
