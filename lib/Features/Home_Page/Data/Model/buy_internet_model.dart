class BuyInternetModel {
  final bool success;
  final String traceId;
  final BuyInternetErrorDetail error;

  BuyInternetModel({
    required this.success,
    required this.traceId,
    required this.error,
  });

  factory BuyInternetModel.fromJson(Map<String, dynamic> json) {
    return BuyInternetModel(
      success: json['success'] ?? false,
      traceId: json['traceId'] ?? '',
      error: BuyInternetErrorDetail.fromJson(json['error'] ?? {}),
    );
  }

  bool get isSuccess => success;
  int get errorCode => error.errorCode;
  String get errorMessage => error.errorMessage;
}

class BuyInternetErrorDetail {
  final int errorCode;
  final String errorMessage;
  final dynamic owner;

  BuyInternetErrorDetail({
    required this.errorCode,
    required this.errorMessage,
    this.owner,
  });

  factory BuyInternetErrorDetail.fromJson(Map<String, dynamic> json) {
    return BuyInternetErrorDetail(
      errorCode: json['errorCode'] ?? 0,
      errorMessage: json['errorMessage'] ?? 'خطای ناشناخته',
      owner: json['owner'],
    );
  }
}