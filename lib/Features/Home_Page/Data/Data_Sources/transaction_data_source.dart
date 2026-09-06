import 'package:dio/dio.dart';

import '../Model/transaction_model.dart';

class TransactionDataSource {
  final Dio dio;

  TransactionDataSource({
    required this.dio,
  });

  Future<TransactionResponseModel> chargeWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }) async {

    final idempotentKey = DateTime.now().millisecondsSinceEpoch;

    final body = {
      "customerWalletAddress": customerWalletAddress,
      "amount": amount,
      "customerDepositNumber": customerDepositNumber,
      "idempotentKey": idempotentKey,
    };

    final response = await dio.post(
      "/api/transactions/charge",
      data: body,
    );

    return TransactionResponseModel.fromJson(response.data);
  }

  Future<TransactionResponseModel> withdrawWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }) async {
    final idempotentKey = DateTime.now().millisecondsSinceEpoch;

    final body = {
      "customerWalletAddress": customerWalletAddress,
      "amount": amount,
      "customerDepositNumber": customerDepositNumber,
      "idempotentKey": idempotentKey,
    };

    final response = await dio.post(
      "/api/transactions/withdraw",
      data: body,
    );

    return TransactionResponseModel.fromJson(
      response.data,
    );
  }

  /// بررسی وضعیت تراکنش
  Future<bool> checkTransactionStatus(
      String transactionNumber,
      ) async {
    // موقت
    return true;
  }

}