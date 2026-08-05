import 'dart:async';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class LocalPassRepository {
  final Dio dio;

  LocalPassRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  setPass(passField) async {
    await LocalStorage.save('local_password', passField);
  }

  Future<String> readPass() async {
    final localPass = await LocalStorage.read(
      'local_password',
    );
    return localPass!;
  }

  Future<bool> isFirstLogin() async {
    final localPass = await LocalStorage.read(
      'local_password',
    );
    return localPass == null ? true : false;
  }
}