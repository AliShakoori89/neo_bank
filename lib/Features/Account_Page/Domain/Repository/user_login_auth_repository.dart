import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Core/Services/device_info_service.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Models/login_result_model.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Models/user_login_auth_success_model.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/calcute_expire_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginAuthRepository {
  final dio = Dio();

  FutureOr<LoginResultModel> userLogin(
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

      final data = UserLoginAuthModel.fromJson(response.data);

      if (response.statusCode == 200 && data.success == true) {
        print('*');
        print('otpcode     ${data.data!.code}');
        print('deviceId     ${data.data!.deviceId}');
        print('secretKey     ${data.data!.secretKey}');
        print(calculateExpireTime(data.data!.expireTime.toString()));
        print('**');

        LocalStorage.save('secret_key', data.data!.secretKey!);
        LocalStorage.save(
          'expire_secret_key_time',
          data.data!.expireTime!.toIso8601String(),
        );

        return LoginResultModel(
          success: true,
          message: '',
          secretKey: data.data!.secretKey!,
          deviceId: data.data!.deviceId!,
          expireTime: calculateExpireTime(data.data!.expireTime.toString()),
        );
      }

      return LoginResultModel(
        success: false,
        message: data.error?.errorMessage ?? 'خطای نامشخص',
        secretKey: '',
        deviceId: '',
        expireTime: '',
      );
    } catch (e) {
      return LoginResultModel(
        success: false,
        message: 'خطا در ارتباط با سرور',
        secretKey: '',
        deviceId: '',
        expireTime: '',
      );
    }
  }

  Future<bool> userIsLogin() async {
    final encryptedPrefs = EncryptedSharedPreferences();

    // خواندن توکن
    final token = await encryptedPrefs.getString('token');

    // اگر توکن موجود بود true، در غیر این صورت false
    return token != null && token.isNotEmpty;
  }
}
