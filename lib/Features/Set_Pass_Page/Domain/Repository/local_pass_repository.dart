import 'dart:async';
import 'package:dio/dio.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';


class LocalPassRepository {
  final dio = Dio();

  setPass(passField){
    LocalStorage.save('local_password', passField);
  }

  Future<bool> isFirstLogin() async{

    final localPass = await LocalStorage.read(
      'local_password',
    );

    print("localPass");
    print(localPass);

    return localPass == null ? true : false;
  }
}