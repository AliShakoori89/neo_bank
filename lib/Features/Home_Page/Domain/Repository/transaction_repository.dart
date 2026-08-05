import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/transaction_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class TransactionRepository {
  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  ));

  /// شارژ کیف پول
  Future<TransactionResponseModel> chargeWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw AppException('Token not found');

    // ایجاد idempotentKey یکتا بر اساس زمان
    final idempotentKey = DateTime.now().millisecondsSinceEpoch;

    final body = {
      "customerWalletAddress": customerWalletAddress,
      "amount": amount,
      "customerDepositNumber": customerDepositNumber,
      "idempotentKey": idempotentKey,
    };

    try {
      print('🚀 شروع درخواست شارژ کیف پول...');
      print('📦 Body: $body');

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

      print('✅ پاسخ دریافت شد با وضعیت: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        final transactionResponse = TransactionResponseModel.fromJson(response.data);

        if (transactionResponse.success) {
          print('✅ شارژ کیف پول موفق: ${transactionResponse.data.transactionNumber}');
          return transactionResponse;
        } else {
          throw AppException('خطا در شارژ کیف پول: ${transactionResponse.error ?? 'خطای ناشناخته'}');
        }
      } else {
        throw AppException('خطا در شارژ کیف پول: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ DioException در شارژ کیف پول: ${e.message}');
      print('❌ نوع خطا: ${e.type}');

      if (e.type == DioExceptionType.connectionTimeout) {
        throw AppException('زمان ارتباط با سرور به پایان رسید');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw AppException('سرور پاسخ نمی‌دهد');
      } else if (e.type == DioExceptionType.connectionError) {
        throw AppException('لطفاً اتصال اینترنت خود را بررسی کنید');
      } else {
        throw AppException('خطا در ارتباط با سرور: ${e.message}');
      }
    } catch (e) {
      print('❌ خطا در شارژ کیف پول: $e');
      rethrow;
    }
  }

  /// برداشت از کیف پول
  Future<TransactionResponseModel> withdrawWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }) async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    // ایجاد idempotentKey یکتا بر اساس زمان
    final idempotentKey = DateTime.now().millisecondsSinceEpoch;

    final body = {
      "customerWalletAddress": customerWalletAddress,
      "amount": amount,
      "customerDepositNumber": customerDepositNumber,
      "idempotentKey": idempotentKey,
    };

    try {
      print('🚀 شروع درخواست برداشت از کیف پول...');
      print('📦 Body: $body');

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

      print('✅ پاسخ دریافت شد با وضعیت: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        final transactionResponse = TransactionResponseModel.fromJson(response.data);

        if (transactionResponse.success) {
          print('✅ برداشت از کیف پول موفق: ${transactionResponse.data.transactionNumber}');
          return transactionResponse;
        } else {
          throw AppException('خطا در برداشت از کیف پول: ${transactionResponse.error ?? 'خطای ناشناخته'}');
        }
      } else {
        throw AppException('خطا در برداشت از کیف پول: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ DioException در برداشت از کیف پول: ${e.message}');
      print('❌ نوع خطا: ${e.type}');

      if (e.type == DioExceptionType.connectionTimeout) {
        throw AppException('زمان ارتباط با سرور به پایان رسید');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw AppException('سرور پاسخ نمی‌دهد');
      } else if (e.type == DioExceptionType.connectionError) {
        throw AppException('لطفاً اتصال اینترنت خود را بررسی کنید');
      } else {
        throw AppException('خطا در ارتباط با سرور: ${e.message}');
      }
    } catch (e) {
      print('❌ خطا در برداشت از کیف پول: $e');
        throw AppException('خطا در برداشت از کیف پول');
    }
  }

  /// بررسی وضعیت تراکنش (متد کمکی)
  Future<bool> checkTransactionStatus(String transactionNumber) async {
    try {
      // این متد را بر اساس API خود پیاده‌سازی کنید
      // اگر API ای برای بررسی وضعیت تراکنش دارید
      print('🔍 بررسی وضعیت تراکنش: $transactionNumber');
      return true; // موقت
    } catch (e) {
      print('❌ خطا در بررسی وضعیت تراکنش: $e');
      return false;
    }
  }
}