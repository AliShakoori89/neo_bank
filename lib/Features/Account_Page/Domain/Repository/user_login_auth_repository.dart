import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Core/Services/device_info_service.dart';
import 'package:neo_bank_mehr_iran/Core/Services/token_storage_service.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/Entities/login_result.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Models/user_login_auth_success_model.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/calcute_expire_time.dart';
import '../../../../Core/Network/app_exception.dart';

class UserLoginAuthRepository {
  final Dio dio;

  UserLoginAuthRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  FutureOr<LoginResult> userLogin(
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
        "/api/auth/request-login",
        data: jsonEncode(body),
      );

      final data = UserLoginAuthModel.fromJson(response.data);

      if (response.statusCode == 200 && data.success == true) {
        // Debug prints for developer
        print('-----------------------------------------');
        print('OTP Code: ${data.data?.code}');
        print('Device ID: ${data.data?.deviceId}');
        print('Secret Key: ${data.data?.secretKey}');
        print('-----------------------------------------');

        LocalStorageService.save('secret_key', data.data!.secretKey!);
        LocalStorageService.save(
          'expire_secret_key_time',
          data.data!.expireTime!.toIso8601String(),
        );

        return LoginResult(
          success: true,
          message: '',
          secretKey: data.data!.secretKey!,
          deviceId: data.data!.deviceId!,
          expireTime: calculateExpireTime(data.data!.expireTime.toString()),
        );
      }

      throw AppException(data.error?.errorMessage ?? 'خطای نامشخص');
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  Future<bool> userIsLogin() async {
    final encryptedPrefs = EncryptedSharedPreferences();
    final token = await encryptedPrefs.getString('token');
    return token.isNotEmpty;
  }
}
