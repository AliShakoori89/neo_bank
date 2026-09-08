import 'package:dio/dio.dart';
import '../../../../Core/Services/device_info_service.dart';
import '../Models/user_login_response_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({
    required this.dio,
  });

  Future<UserLoginResponseModel> userLogin({
    required String nationalNumber,
    required String mobileNumber,
  }) async {

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
      data: body,
    );

    return UserLoginResponseModel.fromJson(response.data);
  }
}