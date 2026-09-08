import '../../Data/Model/transaction_model.dart';

abstract class TransactionRepository {

  /// شارژ کیف پول
  Future<TransactionResponseModel> chargeWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  });

  /// برداشت از کیف پول
  Future<TransactionResponseModel> withdrawWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  });
  /// بررسی وضعیت تراکنش (متد کمکی)
  Future<bool> checkTransactionStatus(String transactionNumber) async {
    return true; // موقت
  }
}