import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_code_response_model.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_request_result_model.dart';
import '../../../../Core/Const/app_exception.dart';

class OtpCodeCheckRepository {
  final Dio dio;

  OtpCodeCheckRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  FutureOr<OtpRequestResultModel?> otpLogin(
    String otpCode,
    String secretKey,
    String deviceID,
  ) async {
    final body = {
      "code": otpCode,
      "secretKey": secretKey,
      "deviceId": deviceID,
    };

    try {
      final response = await dio.post(
        "/api/auth/login",
        data: jsonEncode(body),
      );

      final data = OtpCodeResponseModel.fromJson(response.data);

      if (response.statusCode == 200 && data.success == true) {
        LocalStorage.save('access_token', data.data!.token!);
        LocalStorage.save(
          'access_token_expire_time',
          data.data!.expireAt!.toIso8601String(),
        );
        LocalStorage.save('user_name', data.data!.displayName!);
        LocalStorage.save('mobile_number', data.data!.mobileNumber!);

        return OtpRequestResultModel(
          message: '',
          success: true,
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