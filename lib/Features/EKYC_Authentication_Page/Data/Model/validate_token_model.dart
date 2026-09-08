
import '../../../../Core/Network/Models/api_error_model.dart';

class ValidateTokenModel {
  final ValidateTokenDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  ValidateTokenModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory ValidateTokenModel.fromJson(Map<String, dynamic> json) {
    return ValidateTokenModel(
      data: json['data'] != null ? ValidateTokenDataModel.fromJson(json['data']) : null,
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

class ValidateTokenDataModel {
  final DateTime? tokenExpirationDateTime;
  final DateTime? tokenExpirationDateTimeUtc;
  final int? remainedVideoTry;
  final int? state;

  ValidateTokenDataModel({
    this.tokenExpirationDateTime,
    this.tokenExpirationDateTimeUtc,
    this.remainedVideoTry,
    this.state,
  });

  factory ValidateTokenDataModel.fromJson(Map<String, dynamic> json) {
    return ValidateTokenDataModel(
      tokenExpirationDateTime: json['tokenExpirationDateTime'] != null
          ? DateTime.parse(json['tokenExpirationDateTime'])
          : null,
      tokenExpirationDateTimeUtc: json['tokenExpirationDateTimeUtc'] != null
          ? DateTime.parse(json['tokenExpirationDateTimeUtc'])
          : null,
      remainedVideoTry: json['remainedVideoTry'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenExpirationDateTime':
      tokenExpirationDateTime?.toIso8601String(),
      'tokenExpirationDateTimeUtc':
      tokenExpirationDateTimeUtc?.toIso8601String(),
      'remainedVideoTry': remainedVideoTry,
      'state': state,
    };
  }
}