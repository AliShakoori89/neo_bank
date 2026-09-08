
import '../../../../Core/Network/Models/api_error_model.dart';

class GetCitizenEkycStatusModel {
  final GetCitizenEkycDataStatusModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  GetCitizenEkycStatusModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory GetCitizenEkycStatusModel.fromJson(Map<String, dynamic> json) {
    return GetCitizenEkycStatusModel(
      data: json['data'] != null
          ? GetCitizenEkycDataStatusModel.fromJson(json['data'])
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

class GetCitizenEkycDataStatusModel {
  final bool? hasApprovedKYC;
  final int? state;

  GetCitizenEkycDataStatusModel({
    this.state, this.hasApprovedKYC,
  });

  factory GetCitizenEkycDataStatusModel.fromJson(Map<String, dynamic> json) {
    return GetCitizenEkycDataStatusModel(
      hasApprovedKYC: json['hasApprovedKYC'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasApprovedKYC': hasApprovedKYC,
      'state': state,
    };
  }
}

