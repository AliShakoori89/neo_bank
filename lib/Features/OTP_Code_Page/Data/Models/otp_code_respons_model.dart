class OtpCodeResponsModel {
  final OtpCodeResponsDataModel? data;
  final bool? success;
  final String? traceId;
  final OtpCodeResponsErrorModel? error;

  OtpCodeResponsModel({this.data, this.success, this.traceId, this.error});

  factory OtpCodeResponsModel.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponsModel(
      data: json['data'] != null
          ? OtpCodeResponsDataModel.fromJson(json['data'])
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null
          ? OtpCodeResponsErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class OtpCodeResponsDataModel {
  final String? token;
  final DateTime? expireAt;
  final String? displayName;
  final String? mobileNumber;

  OtpCodeResponsDataModel({
    this.token,
    this.expireAt,
    this.displayName,
    this.mobileNumber,
  });

  factory OtpCodeResponsDataModel.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponsDataModel(
      token: json['token'] as String,
      displayName: json['displayName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'])
          : null,
    );
  }
}

class OtpCodeResponsErrorModel {
  final int? errorCode;
  final String? errorMessage;
  final String? owner;

  OtpCodeResponsErrorModel({this.errorCode, this.errorMessage, this.owner});

  factory OtpCodeResponsErrorModel.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponsErrorModel(
      errorCode: json['errorCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      owner: json['owner'] as String?,
    );
  }
}
