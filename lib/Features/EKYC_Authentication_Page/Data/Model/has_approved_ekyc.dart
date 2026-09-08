
import '../../../../Core/Network/Models/api_error_model.dart';

class HasApprovedEkycModel {
  final HasApprovedEkycDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  HasApprovedEkycModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory HasApprovedEkycModel.fromJson(Map<String, dynamic> json) {
    return HasApprovedEkycModel(
      data: json['data'] != null
          ? HasApprovedEkycDataModel.fromJson(json['data'])
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

class HasApprovedEkycDataModel {
  final bool? hasApprovedKYC;

  HasApprovedEkycDataModel({
    this.hasApprovedKYC,
  });

  factory HasApprovedEkycDataModel.fromJson(Map<String, dynamic> json) {
    return HasApprovedEkycDataModel(
      hasApprovedKYC: json['hasApprovedKYC'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasApprovedKYC': hasApprovedKYC,
    };
  }
}

