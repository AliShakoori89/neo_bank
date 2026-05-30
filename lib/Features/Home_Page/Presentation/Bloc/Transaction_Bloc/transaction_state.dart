// transaction_state.dart
import 'package:equatable/equatable.dart';

enum TransactionStatus {
  initial,
  loading,
  success,
  error,
  // completed را حذف کنید - نیازی به آن نیست
}

class TransactionState extends Equatable {
  final TransactionStatus status;
  final String? transactionNumber;
  final String? traceId;
  final String? message;

  const TransactionState({
    required this.status,
    this.transactionNumber,
    this.traceId,
    this.message,
  });

  factory TransactionState.initial() {
    return const TransactionState(
      status: TransactionStatus.initial,
      transactionNumber: null,
      traceId: null,
      message: null,
    );
  }

  TransactionState copyWith({
    TransactionStatus? status,
    String? transactionNumber,
    String? traceId,
    String? message,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      traceId: traceId ?? this.traceId,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    transactionNumber,
    traceId,
    message,
  ];
}