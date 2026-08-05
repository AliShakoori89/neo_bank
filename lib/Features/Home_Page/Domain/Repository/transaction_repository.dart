import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/transaction_model.dart';
import '../../../../Core/Const/app_exception.dart';

class TransactionRepository {
  final Dio dio;

  TransactionRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  /// شارژ کیف پول
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

    try {
      final response = await dio.post(
        "/api/transactions/charge",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 && response.data != null) {
        final transactionResponse = TransactionResponseModel.fromJson(response.data);
        if (transactionResponse.success) {
          return transactionResponse;
        } else {
          throw AppException(transactionResponse.error?.toString() ?? 'خطا در شارژ کیف پول');
        }
      } else {
        throw AppException('خطا در شارژ کیف پول');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  /// برداشت از کیف پول
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

    try {
      final response = await dio.post(
        "/api/transactions/withdraw",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 && response.data != null) {
        final transactionResponse = TransactionResponseModel.fromJson(response.data);
        if (transactionResponse.success) {
          return transactionResponse;
        } else {
          throw AppException(transactionResponse.error?.toString() ?? 'خطا در برداشت از کیف پول');
        }
      } else {
        throw AppException('خطا در برداشت از کیف پول');
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  /// بررسی وضعیت تراکنش (متد کمکی)
  Future<bool> checkTransactionStatus(String transactionNumber) async {
    return true; // موقت
  }
}