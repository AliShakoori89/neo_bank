class TransactionModel {
  final bool? success;
  final String? traceId;
  final TransactionErrorDetail? error;

  TransactionModel({
    this.success,
    this.traceId,
    this.error,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      success: json['success'] ?? false,
      traceId: json['traceId'] ?? '',
      error: TransactionErrorDetail.fromJson(json['error'] ?? {}),
    );
  }

  bool get isSuccess => success!;
  int get errorCode => error!.errorCode;
  String get errorMessage => error!.errorMessage;
}

class TransactionErrorDetail {
  final int errorCode;
  final String errorMessage;
  final dynamic owner;

  TransactionErrorDetail({
    required this.errorCode,
    required this.errorMessage,
    this.owner,
  });

  factory TransactionErrorDetail.fromJson(Map<String, dynamic> json) {
    return TransactionErrorDetail(
      errorCode: json['errorCode'] ?? 0,
      errorMessage: json['errorMessage'] ?? 'خطای ناشناخته',
      owner: json['owner'],
    );
  }
}