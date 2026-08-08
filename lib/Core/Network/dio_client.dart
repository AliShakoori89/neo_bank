import 'package:dio/dio.dart';
import '../../Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../Const/api_key.dart';
import 'error_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: APIKey.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptor for adding Authorization token to requests
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorage.read('access_token');
          
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = token;
            print('--- Network Request ---');
            print('Path: ${options.path}');
            print('Token: ${token.substring(0, 10)}...'); // فقط اولش رو پرینت میکنیم برای امنیت
          }
          return handler.next(options);
        },
      ),
    );

    // Interceptor for centralized error handling
    dio.interceptors.add(ErrorInterceptor());
  }
}
