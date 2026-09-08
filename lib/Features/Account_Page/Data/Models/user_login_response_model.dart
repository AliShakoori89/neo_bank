import '../../../../Core/Network/Models/api_error_model.dart';

class UserLoginResponseModel {
  final UserLoginResponseDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  UserLoginResponseModel({this.data, this.success, this.traceId, this.error});

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return UserLoginResponseModel(
      data: json['data'] != null
          ? UserLoginResponseDataModel.fromJson(json['data'])
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class UserLoginResponseDataModel {
  final String? code;
  final String? secretKey;
  final String? deviceId;
  final DateTime? expireTime;

  UserLoginResponseDataModel({
    this.code,
    this.secretKey,
    this.deviceId,
    this.expireTime,
  });

  factory UserLoginResponseDataModel.fromJson(Map<String, dynamic> json) {
    return UserLoginResponseDataModel(
      code: json['code'] as String?,
      secretKey: json['secretKey'] as String,
      deviceId: json['deviceId'] as String,
      expireTime: json['expireTime'] != null
          ? DateTime.parse(json['expireTime'])
          : null,
    );
  }
}
