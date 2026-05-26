import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/transaction_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class TransactionRepository {

  final dio = Dio();

  Future<TransactionModel> chargeWallet(String customerWalletAddress, int amount, String customerDepositNumber) async{

    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "customerWalletAddress": customerWalletAddress,
      "amount": amount,
      "customerDepositNumber": customerDepositNumber,
      "idempotentKey": 123213213131
    };

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/transactions/charge",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {

        TransactionModel transactionStatus = response.data;
        return transactionStatus;

      } else {
        throw Exception('خطا در شارژ کیف پول: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در شارژ کیف پول: $e');
      rethrow;
    }
  }

  Future<TransactionModel> withdrawWallet(String customerWalletAddress, int amount, String customerDepositNumber) async{

    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "customerWalletAddress": customerWalletAddress,
      "amount": amount,
      "customerDepositNumber": customerDepositNumber,
      "idempotentKey": 123213213131
    };

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/transactions/withdraw",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {

        TransactionModel transactionStatus = response.data;
        return transactionStatus;

      } else {
        throw Exception('خطا در برداشت از کیف پول: ${response.statusCode}');
      }
    } catch (e) {
      print('خطا در برداشت از کیف پول: $e');
      rethrow;
    }
  }

}