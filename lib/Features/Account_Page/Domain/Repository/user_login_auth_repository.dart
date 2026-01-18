import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Core/Services/device_info_service.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Models/user_login_auth_success_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginAuthRepository {
  final dio = Dio();

  FutureOr<List<dynamic>?> userLogin(
    String nationalNumber,
    String mobileNumber,
  ) async {
    try {
      final deviceInfo = await DeviceInfoService.getDeviceInfo();

      final body = {
        "mobileNumber": mobileNumber,
        "nationalNumber": nationalNumber,
        "deviceId": deviceInfo['deviceId'],
        "deviceModel": deviceInfo['deviceModel'],
        "platForm": deviceInfo['platform'],
        "osVersion": deviceInfo['osVersion'],
        "appVersion": deviceInfo['appVersion'],
      };

      final response = await dio.post(
        "${APIKey.baseUrl}/api/auth/request-login",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = UserLoginAuthModel.fromJson(response.data);

        print('111111111111111111');
        print('data.data!.code     ' + data.data!.code.toString());
        print('data.data!.deviceId     ' + data.data!.deviceId.toString());
        print('data.data!.secretKey     ' + data.data!.secretKey.toString());

        if (data.success!) {
          LocalStorage.save('secret_key', data.data!.secretKey!);
          LocalStorage.save(
            'expire_secret_key_time',
            data.data!.expireTime!.toIso8601String(),
          );
        }

        return [
          data.success,
          data.success == true ? '' : data.error!.errorMessage,
          data.success == true ? data.data!.secretKey! : '',
          data.success == true ? data.data!.deviceId : '',
        ];
      } else {
        final data = UserLoginAuthModel.fromJson(response.data);
        return [data.success, data.error!.errorMessage];
      }
    } catch (e) {
      return null;
    }
  }

  FutureOr<bool?> userIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null ? true : false;
  }
}
