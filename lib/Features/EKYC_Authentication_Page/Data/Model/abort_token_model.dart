
import '../../../../Core/Network/Models/api_error_model.dart';

class AbortTokenModel {
  final AbortTokenDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  AbortTokenModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory AbortTokenModel.fromJson(Map<String, dynamic> json) {
    return AbortTokenModel(
      data: json['data'] != null ? AbortTokenDataModel.fromJson(json['data']) : null,
      success: json['success'] ?? false,
      traceId: json['traceId'],
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
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

class AbortTokenDataModel {
  final int? responseCode;
  final String? responseMessage;
  final int? state;

  AbortTokenDataModel({
    this.responseCode,
    this.responseMessage,
    this.state
  });

  factory AbortTokenDataModel.fromJson(Map<String, dynamic> json) {
    return AbortTokenDataModel(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseMessage': responseMessage,
      'state': state,

    };
  }
}