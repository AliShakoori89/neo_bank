import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Repositories/transaction_repository.dart';
import '../Data_Sources/transaction_data_source.dart';
import '../Model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository{

  final TransactionDataSource transactionDataSource;

  TransactionRepositoryImpl({required this.transactionDataSource});

  @override
  Future<TransactionResponseModel> chargeWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }) async {

    try {
      final data = await transactionDataSource.chargeWallet(
          customerWalletAddress: customerWalletAddress,
          amount: amount,
          customerDepositNumber: customerDepositNumber);

      if (data.success) {
        return data;
      }else {
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

  @override
  Future<TransactionResponseModel> withdrawWallet({
    required String customerWalletAddress,
    required int amount,
    required String customerDepositNumber,
  }) async {

    try {

      final data = await transactionDataSource.withdrawWallet(
          customerWalletAddress: customerWalletAddress,
          amount: amount,
          customerDepositNumber: customerDepositNumber);

      if (data.success) {
        return data;
      }else {
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

  @override
  Future<bool> checkTransactionStatus(String transactionNumber) async {
    return true; // موقت
  }


}