import '../../../../Core/Network/Models/api_error_model.dart';

class RandomTextModel {
  final RandomTextDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  RandomTextModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory RandomTextModel.fromJson(Map<String, dynamic> json) {
    return RandomTextModel(
      data: json['data'] != null
          ? RandomTextDataModel.fromJson(json['data'])
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

class RandomTextDataModel {
  final List<String>? result;
  final String? failureResult;
  final String? message;
  final int? state;

  RandomTextDataModel({
    this.result,
    this.failureResult,
    this.message,
    this.state
  });

  factory RandomTextDataModel.fromJson(Map<String, dynamic> json) {
    return RandomTextDataModel(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      failureResult: json['failureResult'],
      message: json['message'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'failureResult': failureResult,
      'message': message,
      'state': state,
    };
  }
}