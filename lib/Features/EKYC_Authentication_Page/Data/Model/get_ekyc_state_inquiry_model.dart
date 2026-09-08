
import '../../../../Core/Network/Models/api_error_model.dart';

class GetEkycStateInquiryModel {
  final GetEkycStateInquiryDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  GetEkycStateInquiryModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory GetEkycStateInquiryModel.fromJson(Map<String, dynamic> json) {
    return GetEkycStateInquiryModel(
      data: json['data'] != null
          ? GetEkycStateInquiryDataModel.fromJson(json['data'])
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

class GetEkycStateInquiryDataModel {
  final int? state;

  GetEkycStateInquiryDataModel({
    this.state,
  });

  factory GetEkycStateInquiryDataModel.fromJson(Map<String, dynamic> json) {
    return GetEkycStateInquiryDataModel(
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
    };
  }
}

