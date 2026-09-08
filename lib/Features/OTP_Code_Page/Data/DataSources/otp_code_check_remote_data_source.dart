import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Models/otp_code_response_model.dart';

@lazySingleton
class OtpCodeCheckRemoteDataSource {
  final Dio _dio;

  OtpCodeCheckRemoteDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<OtpCodeResponseModel> otpLogin({
    required String otpCode,
    required String secretKey,
    required String deviceID,}) async{

    final body = {
      "code": otpCode,
      "secretKey": secretKey,
      "deviceId": deviceID,
    };

    final response = await _dio.post(
      "/api/auth/login",
      data: jsonEncode(body),
    );

    return OtpCodeResponseModel.fromJson(response.data);
  }
}