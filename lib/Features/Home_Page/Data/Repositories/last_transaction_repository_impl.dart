import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/last_transaction_data_source.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/last_transaction_repository.dart';

import '../../../../Core/Network/app_exception.dart';
import '../../../Statement_Page/Data/Model/statement_model.dart';

class LastTransactionRepositoryImpl implements LastTransactionRepository{

  final LastTransactionDataSource lastTransactionDataSource;

  LastTransactionRepositoryImpl({required this.lastTransactionDataSource});

  @override
  Future<StatementResponseModel> getLastestStatement(String depositNumber) async {
    try {

      final data = await lastTransactionDataSource.getLastestStatement(depositNumber);
      return data;

    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}