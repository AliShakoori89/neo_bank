import '../../../../Core/Network/Models/api_error_model.dart';

class BuyInternetModel {
  final bool success;
  final String traceId;
  final ApiErrorModel? error;

  BuyInternetModel({
    required this.success,
    required this.traceId,
    this.error,
  });

  factory BuyInternetModel.fromJson(Map<String, dynamic> json) {
    return BuyInternetModel(
      success: json['success'] ?? false,
      traceId: json['traceId'] ?? '',
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }

  bool get isSuccess => success;
  int get errorCode => error?.errorCode ?? 0;
  String get errorMessage => error?.errorMessage ?? 'خطای ناشناخته';
}
