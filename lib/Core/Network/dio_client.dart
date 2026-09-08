import 'package:dio/dio.dart';

import '../Constants/api_key.dart';
import '../Services/token_storage_service.dart';
import 'error_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient() : dio = Dio(
    BaseOptions(
      baseUrl: APIKey.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  ) {
    // Interceptor for adding Authorization token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorageService.read('access_token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = token;

            print('--- Network Request ---');
            print('Path: ${options.path}');
            print('Token: ${token.substring(0, 10)}...');
          }

          return handler.next(options);
        },
      ),
    );

    // Centralized error handling
    dio.interceptors.add(
      ErrorInterceptor(),
    );
  }
}