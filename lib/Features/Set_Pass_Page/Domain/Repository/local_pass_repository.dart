import 'dart:async';
import 'package:dio/dio.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';


class LocalPassRepository {
  final dio = Dio();

  setPass(passField) async{
    await LocalStorage.save('local_password', passField);
  }

  Future<String> readPass() async{
    final localPass = await LocalStorage.read(
      'local_password',
    );
    return localPass!;
  }

  Future<bool> isFirstLogin() async{
    final localPass = await LocalStorage.read(
      'local_password',
    );
    return localPass == null ? true : false;
  }
}