import 'package:equatable/equatable.dart';

class TransactionDataEntity extends Equatable {
  final String transactionNumber;

  const TransactionDataEntity({required this.transactionNumber});

  @override
  List<Object?> get props => [transactionNumber];
}

class TransactionEntity extends Equatable {
  final TransactionDataEntity data;
  final bool success;
  final String traceId;
  final dynamic error;

  const TransactionEntity({
    required this.data,
    required this.success,
    required this.traceId,
    this.error,
  });

  bool get isSuccess => success;

  bool get isDuplicateTransaction =>
      data.transactionNumber == 'تراکنش تکراری است' ||
          data.transactionNumber.contains('تکراری');

  bool get hasValidTransactionNumber =>
      isSuccess &&
          data.transactionNumber.isNotEmpty &&
          !isDuplicateTransaction;

  String get displayMessage {
    if (!success) {
      return 'خطا در انجام تراکنش';
    }

    if (isDuplicateTransaction) {
      return 'این تراکنش قبلاً انجام شده است';
    }

    return 'تراکنش با موفقیت انجام شد';
  }

  @override
  List<Object?> get props => [data, success, traceId, error];
}