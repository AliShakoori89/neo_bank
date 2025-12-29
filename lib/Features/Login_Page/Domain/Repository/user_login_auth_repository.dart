import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Data/Models/user_login_auth_model.dart';

class UserLoginAuthRepository {
  final dio = Dio();

  FutureOr<bool?> userLogin(String username, String password) async {
    try {
      var body = {"username": username, "password": password};

      print('11111111111111111');

      final response = await dio.post(
        "${APIKey.baseUrl}/api/auth/login",
        data: jsonEncode(body), // ✅ مهم!
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final data = UserLoginAuthData.fromJson(response.data['data']);
        TokenStorage.save('token', data.token!);

        print('token :                     ${data.token}');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
