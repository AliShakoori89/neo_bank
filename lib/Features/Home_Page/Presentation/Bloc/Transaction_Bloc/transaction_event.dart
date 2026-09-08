import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class ChargeTransactionEvent extends TransactionEvent {
  final String customerWalletAddress;
  final int amount;
  final String customerDepositNumber;

  const ChargeTransactionEvent({required this.customerWalletAddress, required this.amount, required this.customerDepositNumber});
}

class WithdrawTransactionEvent extends TransactionEvent {
  final String customerWalletAddress;
  final int amount;
  final String customerDepositNumber;

  const WithdrawTransactionEvent({required this.customerWalletAddress, required this.amount, required this.customerDepositNumber});
}
