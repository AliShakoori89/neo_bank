import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../../../Core/Services/device_info_service.dart';
import '../../../Account_Page/Data/Models/user_login_response_model.dart';

@lazySingleton
class RequestOtpCodeAgainRemoteDataSource {
  final Dio _dio;

  RequestOtpCodeAgainRemoteDataSource({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<UserLoginResponseModel> requestOTPAgain({
    required String nationalNumber,
    required String mobileNumber,}) async {

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

    final response = await _dio.post(
      "/api/auth/request-login",
      data: body,
    );

    return UserLoginResponseModel.fromJson(response.data);
  }
}