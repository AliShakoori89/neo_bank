import '../Entities/transaction_entity.dart';

abstract class TransactionRepository {

  /// شارژ کیف پول
  Future<TransactionEntity> chargeWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  });

  /// برداشت از کیف پول
  Future<TransactionEntity> withdrawWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  });
  /// بررسی وضعیت تراکنش (متد کمکی)
  Future<bool> checkTransactionStatus(String transactionNumber) async {
    return true; // موقت
  }
}