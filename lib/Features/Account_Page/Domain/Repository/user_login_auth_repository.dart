import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Core/Services/device_info_service.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Models/user_login_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginAuthRepository {
  final dio = Dio();

  FutureOr<bool?> userLogin(String nationalCode, String phoneNumber) async {
    try {
      final deviceInfo = await DeviceInfoService.getDeviceInfo();

      final body = {
        "username": "string",
        "password": "string",
        // "nationalCode": nationalCode,
        // "phoneNumber": phoneNumber,
        // "device": deviceInfo,
      };

      final response = await dio.post(
        "${APIKey.baseUrl}/api/auth/login",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = UserLoginAuthData.fromJson(response.data['data']);
        TokenStorage.save('token', data.token!);
        await TokenStorage.save(
          'token_expire_at',
          data.expireAt!.toIso8601String(),
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  FutureOr<bool?> userIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null ? true : false;
  }
}
