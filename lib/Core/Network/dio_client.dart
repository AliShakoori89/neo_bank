import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/local_storag.dart';

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
