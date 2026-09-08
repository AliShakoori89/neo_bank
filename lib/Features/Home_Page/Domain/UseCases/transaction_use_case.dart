import '../Entities/transaction_entity.dart';
import '../Repositories/transaction_repository.dart';

class TransactionUseCase {
  final TransactionRepository transactionRepository;

  TransactionUseCase({required this.transactionRepository});

  /// شارژ کیف پول
  Future<TransactionEntity> chargeWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }){
    return transactionRepository.chargeWallet(
        customerWalletAddress: customerWalletAddress,
        amount: amount,
        customerDepositNumber: customerDepositNumber);
  }

  /// برداشت از کیف پول
  Future<TransactionEntity> withdrawWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }){
    return transactionRepository.withdrawWallet(
        customerWalletAddress: customerWalletAddress,
        amount: amount,
        customerDepositNumber: customerDepositNumber);
  }

  /// بررسی وضعیت تراکنش (متد کمکی)
  Future<bool> checkTransactionStatus(String transactionNumber) async {
    return true; // موقت
  }
}