import 'dart:convert';
import 'package:dio/dio.dart';
import '../Models/otp_code_response_model.dart';

class OtpCodeCheckRemoteDataSource {
  final Dio dio;

  OtpCodeCheckRemoteDataSource({
    required this.dio});

  Future<OtpCodeResponseModel> otpLogin({
    required String otpCode,
    required String secretKey,
    required String deviceID,}) async{

    final body = {
      "code": otpCode,
      "secretKey": secretKey,
      "deviceId": deviceID,
    };

    final response = await dio.post(
      "/api/auth/login",
      data: jsonEncode(body),
    );

    return OtpCodeResponseModel.fromJson(response.data);
  }
}