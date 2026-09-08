import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/otp_code_response_entity.dart';

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

  OtpCodeResponseEntity toEntity(){
    return OtpCodeResponseEntity(
      token: token,
      mobileNumber: mobileNumber,
      expireAt: expireAt,
      displayName: displayName
    );
  }
}
