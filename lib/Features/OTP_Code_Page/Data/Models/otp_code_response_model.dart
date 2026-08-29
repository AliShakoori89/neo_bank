
import '../../../../Core/Network/Models/api_error_model.dart';

class OtpCodeResponseModel {
  final OtpCodeResponseDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  OtpCodeResponseModel({this.data, this.success, this.traceId, this.error});

  factory OtpCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponseModel(
      data: json['data'] != null
          ? OtpCodeResponseDataModel.fromJson(json['data'])
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'],
    );
  }
}

class OtpCodeResponseDataModel {
  final String? token;
  final DateTime? expireAt;
  final String? displayName;
  final String? mobileNumber;

  OtpCodeResponseDataModel({
    this.token,
    this.expireAt,
    this.displayName,
    this.mobileNumber,
  });

  factory OtpCodeResponseDataModel.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponseDataModel(
      token: json['token'] as String,
      displayName: json['displayName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'])
          : null,
    );
  }
}

class OtpCodeResponseErrorModel {
  final int? errorCode;
  final String? errorMessage;
  final String? owner;

  OtpCodeResponseErrorModel({this.errorCode, this.errorMessage, this.owner});

  factory OtpCodeResponseErrorModel.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponseErrorModel(
      errorCode: json['errorCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      owner: json['owner'] as String?,
    );
  }
}
