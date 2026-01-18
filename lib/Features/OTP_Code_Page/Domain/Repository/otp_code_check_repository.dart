import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Models/otp_code_respons_model.dart';

class OtpCodeCheckRepository {
  final dio = Dio();

  FutureOr<List<dynamic>?> otpLogin(
    String otpCode,
    String secretKey,
    String deviceID,
  ) async {
    try {
      // final secretKey = LocalStorage.read('secret_key');

      print(otpCode);
      print(secretKey);
      print(deviceID);

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

      print('aaa');

      if (response.statusCode == 200) {
        print(response.data);

        final data = OtpCodeResponsModel.fromJson(response.data);

        print(data.owner);

        print('111111111111111111');

        if (data.success!) {
          LocalStorage.save('access_token', data.owner!.token!);
          LocalStorage.save(
            'access_token_expire_time',
            data.owner!.expireAt!.toIso8601String(),
          );
        }

        print(data.success);
        print(data.error!.errorMessage);

        return [
          data.success,
          data.success == true ? '' : data.error!.errorMessage,
        ];
      } else {
        final data = OtpCodeResponsModel.fromJson(response.data);
        return [data.success, data.error!.errorMessage];
      }
    } catch (e) {
      return null;
    }
  }
}
