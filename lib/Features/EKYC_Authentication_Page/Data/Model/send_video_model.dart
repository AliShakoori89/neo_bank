
import '../../../../Core/Network/Models/api_error_model.dart';

class SendVideoModel {
  final SendVideoDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  SendVideoModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory SendVideoModel.fromJson(Map<String, dynamic> json) {
    return SendVideoModel(
      data: json['data'] != null ? SendVideoDataModel.fromJson(json['data']) : null,
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

class SendVideoDataModel {
  final String? failureResult;
  final String? result;
  final String? message;
  final int? state;
  final int? responseCode;
  final String? responseMessage;

  SendVideoDataModel({
    this.failureResult,
    this.result,
    this.message,
    this.state,
    this.responseCode,
    this.responseMessage,
  });

  factory SendVideoDataModel.fromJson(Map<String, dynamic> json) {
    return SendVideoDataModel(
      failureResult: json['failureResult'],
      result: json['result'],
      message: json['message'],
      state: json['state'],
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'failureResult': failureResult,
      'result': result,
      'message': message,
      'state': state,
      'responseCode': responseCode,
      'responseMessage': responseMessage,
    };
  }
}

