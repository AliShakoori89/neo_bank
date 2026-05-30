import 'package:equatable/equatable.dart';

// مدل داده داخلی
class TransactionData extends Equatable {
  final String transactionNumber;

  const TransactionData({
    required this.transactionNumber,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      transactionNumber: json['transactionNumber'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionNumber': transactionNumber,
    };
  }

  @override
  List<Object?> get props => [transactionNumber];
}

// مدل پاسخ اصلی API
class TransactionResponseModel extends Equatable {
  final TransactionData data;
  final bool success;
  final String traceId;
  final dynamic error;

  const TransactionResponseModel({
    required this.data,
    required this.success,
    required this.traceId,
    this.error,
  });

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionResponseModel(
      data: TransactionData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
      success: json['success'] as bool? ?? false,
      traceId: json['traceId'] as String? ?? '',
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'success': success,
      'traceId': traceId,
      'error': error,
    };
  }

  @override
  List<Object?> get props => [data, success, traceId, error];
}

// ✅ Extension برای بررسی وضعیت تراکنش (این قسمت را اضافه کنید)
extension TransactionResponseExtension on TransactionResponseModel {
  bool get isSuccess => success;

  bool get isDuplicateTransaction =>
      data.transactionNumber == 'تراکنش تکراری است';

  bool get hasValidTransactionNumber =>
      isSuccess && data.transactionNumber.isNotEmpty &&
          data.transactionNumber != 'تراکنش تکراری است';

  String get displayMessage {
    if (!success) return 'خطا در انجام تراکنش';
    if (isDuplicateTransaction) return 'این تراکنش قبلاً انجام شده است';
    return 'تراکنش با موفقیت انجام شد';
  }
}