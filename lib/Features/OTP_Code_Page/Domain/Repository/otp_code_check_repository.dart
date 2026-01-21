import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_code_response_model.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_request_result_model.dart';

class OtpCodeCheckRepository {
  final dio = Dio();

  FutureOr<OtpRequestResultModel?> otpLogin(
    String otpCode,
    String secretKey,
    String deviceID,
  ) async {
    try {
      // final secretKey = LocalStorage.read('secret_key');

      print('###########################');
      print('otpCode   ' + otpCode);
      print('secretKey    ' + secretKey);
      print('deviceID    ' + deviceID);

      final body = {
        "code": otpCode,
        "secretKey": secretKey,
        "deviceId": deviceID,
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

      final data = OtpCodeResponseModel.fromJson(response.data);
      print('*****************');
      print(data.data);

      if (response.statusCode == 200 && data.success == true) {
        LocalStorage.save('access_token', data.data!.token!);
        LocalStorage.save(
          'access_token_expire_time',
          data.data!.expireAt!.toIso8601String(),
        );

        return OtpRequestResultModel(
          message: data.success == true ? '' : data.error!.errorMessage!,
          success: data.success!,
        );
      }
      return OtpRequestResultModel(
        message: data.error!.errorMessage ?? 'خطای نامشخص',
        success: false,
      );
    } catch (e) {
      return OtpRequestResultModel(
        message: 'خطا در ارتباط با سرور',
        success: false,
      );
    }
  }
}
