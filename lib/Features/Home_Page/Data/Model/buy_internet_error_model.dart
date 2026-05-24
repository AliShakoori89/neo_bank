class ServiceErrorModel {
  final bool success;
  final String traceId;
  final ErrorDetail error;

  ServiceErrorModel({
    required this.success,
    required this.traceId,
    required this.error,
  });

  factory ServiceErrorModel.fromJson(Map<String, dynamic> json) {
    return ServiceErrorModel(
      success: json['success'] ?? false,
      traceId: json['traceId'] ?? '',
      error: ErrorDetail.fromJson(json['error'] ?? {}),
    );
  }

  bool get isSuccess => success;
  int get errorCode => error.errorCode;
  String get errorMessage => error.errorMessage;
}

class ErrorDetail {
  final int errorCode;
  final String errorMessage;
  final dynamic owner;

  ErrorDetail({
    required this.errorCode,
    required this.errorMessage,
    this.owner,
  });

  factory ErrorDetail.fromJson(Map<String, dynamic> json) {
    return ErrorDetail(
      errorCode: json['errorCode'] ?? 0,
      errorMessage: json['errorMessage'] ?? 'خطای ناشناخته',
      owner: json['owner'],
    );
  }
}