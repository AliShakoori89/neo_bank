import '../../../../Core/Utils/api_error_model.dart';

class CitizenEkycStatusModel {
  final KycData? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  CitizenEkycStatusModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory CitizenEkycStatusModel.fromJson(Map<String, dynamic> json) {
    return CitizenEkycStatusModel(
      data: json['data'] != null
          ? KycData.fromJson(json['data'])
          : null,
      success: json['success'],
      traceId: json['traceId'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'success': success,
      'traceId': traceId,
      'error': error,
    };
  }
}

class KycData {
  final int? kycStatus;
  final int? kycRequestStatus;

  KycData({
    this.kycStatus,
    this.kycRequestStatus,
  });

  factory KycData.fromJson(Map<String, dynamic> json) {
    return KycData(
      kycStatus: json['kycStatus'],
      kycRequestStatus: json['kycRequestStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kycStatus': kycStatus,
      'kycRequestStatus': kycRequestStatus,
    };
  }
}