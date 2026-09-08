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

  @override
  List<Object?> get props => [data, success, traceId, error];
}
