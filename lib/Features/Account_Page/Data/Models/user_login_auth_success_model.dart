import '../../../../Core/Network/Models/api_error_model.dart';

class UserLoginAuthModel {
  final UserLoginAuthDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  UserLoginAuthModel({this.data, this.success, this.traceId, this.error});

  factory UserLoginAuthModel.fromJson(Map<String, dynamic> json) {
    return UserLoginAuthModel(
      data: json['data'] != null
          ? UserLoginAuthDataModel.fromJson(json['data'])
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class UserLoginAuthDataModel {
  final String? code;
  final String? secretKey;
  final String? deviceId;
  final DateTime? expireTime;

  UserLoginAuthDataModel({
    this.code,
    this.secretKey,
    this.deviceId,
    this.expireTime,
  });

  factory UserLoginAuthDataModel.fromJson(Map<String, dynamic> json) {
    return UserLoginAuthDataModel(
      code: json['code'] as String?,
      secretKey: json['secretKey'] as String,
      deviceId: json['deviceId'] as String,
      expireTime: json['expireTime'] != null
          ? DateTime.parse(json['expireTime'])
          : null,
    );
  }
}
