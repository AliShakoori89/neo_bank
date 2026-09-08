
import '../../../../Core/Network/Models/api_error_model.dart';

class CreateTokenModel {
  final CreateTokenDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  CreateTokenModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory CreateTokenModel.fromJson(Map<String, dynamic> json) {
    return CreateTokenModel(
      data: json['data'] != null ? CreateTokenDataModel.fromJson(json['data']) : null,
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

class CreateTokenDataModel {
  final String? tokenValue;
  final String? setTokenMessage;
  final int? orderId;
  final bool? isValidated;
  final DateTime? tokenExpirationDateTime;
  final DateTime? tokenExpirationDateTimeUtc;
  final int? remainedVideoTry;
  final int? state;

  CreateTokenDataModel({
    this.tokenValue,
    this.setTokenMessage,
    this.orderId,
    this.isValidated,
    this.tokenExpirationDateTime,
    this.tokenExpirationDateTimeUtc,
    this.remainedVideoTry,
    this.state,
  });

  factory CreateTokenDataModel.fromJson(Map<String, dynamic> json) {
    return CreateTokenDataModel(
      tokenValue: json['tokenValue'],
      setTokenMessage: json['setTokenMessage'],
      orderId: json['orderId'],
      isValidated: json['isValidated'],
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
      'tokenValue': tokenValue,
      'setTokenMessage': setTokenMessage,
      'orderId': orderId,
      'isValidated': isValidated,
      'tokenExpirationDateTime': tokenExpirationDateTime?.toIso8601String(),
      'tokenExpirationDateTimeUtc': tokenExpirationDateTimeUtc?.toIso8601String(),
      'remainedVideoTry': remainedVideoTry,
      'state': state,
    };
  }
}