import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/transaction_model.dart';

enum TransactionStatus {
  initial,
  success,
  error,
  loading,
}

extension TransactionStatusX on TransactionStatus {
  bool get isInitial => this == TransactionStatus.initial;
  bool get isSuccess => this == TransactionStatus.success;
  bool get isError => this == TransactionStatus.error;
  bool get isLoading => this == TransactionStatus.loading;
}

class TransactionState extends Equatable {
  const TransactionState({required this.status, required this.transactionModel});

  static TransactionState initial() =>
      TransactionState(status: TransactionStatus.initial, transactionModel: TransactionModel());

  final TransactionStatus status;
  final TransactionModel transactionModel;

  @override
  List<Object?> get props => [status, transactionModel];

  TransactionState copyWith({
    TransactionStatus? status,
    TransactionModel? transactionModel,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactionModel: transactionModel ?? this.transactionModel,
    );
  }
}