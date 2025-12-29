class UserLoginAuthModel {
  final UserLoginAuthData? data;
  final bool? success;
  final String? traceId;
  final ApiError? error;

  UserLoginAuthModel({this.data, this.success, this.traceId, this.error});

  factory UserLoginAuthModel.fromJson(Map<String, dynamic> json) {
    return UserLoginAuthModel(
      data: json['data'] != null
          ? UserLoginAuthData.fromJson(json['data'])
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null ? ApiError.fromJson(json['error']) : null,
    );
  }
}

class UserLoginAuthData {
  final String? token;
  final DateTime? expireAt;
  final String? displayName;

  UserLoginAuthData({this.token, this.expireAt, this.displayName});

  factory UserLoginAuthData.fromJson(Map<String, dynamic> json) {
    return UserLoginAuthData(
      token: json['token'] as String?,
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'])
          : null,
      displayName: json['displayName'] as String?,
    );
  }
}

class ApiError {
  final int? errorCode;
  final String? errorMessage;
  final String? owner;

  ApiError({this.errorCode, this.errorMessage, this.owner});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      errorCode: json['errorCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      owner: json['owner'] as String?,
    );
  }
}
