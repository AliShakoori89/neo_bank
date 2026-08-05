import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Core/Services/device_info_service.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Models/user_login_auth_success_model.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_request_again_result_model.dart';
import '../../../../Core/Const/app_exception.dart';

class RequestOtpCodeAgainRepository {
  final Dio dio;

  RequestOtpCodeAgainRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<OtpRequestAgainResultModel> requestOTPAgain(
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
        LocalStorage.save('secret_key', data.data!.secretKey!);
        LocalStorage.save(
          'expire_secret_key_time',
          data.data!.expireTime!.toIso8601String(),
        );

        return OtpRequestAgainResultModel(
          success: true,
          message: '',
          secretKey: data.data!.secretKey!,
          deviceId: data.data!.deviceId!,
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
}