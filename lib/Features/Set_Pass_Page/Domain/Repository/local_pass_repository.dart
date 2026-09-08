import 'dart:async';
import 'package:dio/dio.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../../../Core/Services/token_storage_service.dart';

class LocalPassRepository {
  final Dio dio;

  LocalPassRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  setPass(passField) async {
    await LocalStorageService.save('local_password', passField);
  }

  Future<String> readPass() async {
    final localPass = await LocalStorageService.read(
      'local_password',
    );
    return localPass!;
  }

  Future<bool> isFirstLogin() async {
    final localPass = await LocalStorageService.read(
      'local_password',
    );
    return localPass == null ? true : false;
  }
}