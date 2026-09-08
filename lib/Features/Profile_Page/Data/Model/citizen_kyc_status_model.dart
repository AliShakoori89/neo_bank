import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/citizen_ekyc_status_entity.dart';

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
  final bool? hasApprovedKYC;
  final int? state;

  KycData({
    this.hasApprovedKYC,
    this.state,
  });

  factory KycData.fromJson(Map<String, dynamic> json) {
    return KycData(
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

  CitizenEkycStatusEntity toEntity(){
    return CitizenEkycStatusEntity(
      state: state,
      hasApprovedKYC: hasApprovedKYC
    );
  }
}