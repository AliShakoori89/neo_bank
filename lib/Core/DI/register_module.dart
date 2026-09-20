import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {

  @Named('openAiDio')
  @lazySingleton
  Dio get openAiDio => Dio(
    BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  @lazySingleton
  @Named('geminiDio')
  Dio get geminiDio => Dio(
    BaseOptions(
      baseUrl: 'https://generativelanguage.googleapis.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
}