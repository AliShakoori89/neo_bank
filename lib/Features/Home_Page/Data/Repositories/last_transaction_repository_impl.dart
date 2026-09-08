import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../Statement_Page/Data/Model/statement_model.dart';
import '../../Domain/Repositories/last_transaction_repository.dart';
import '../Data_Sources/last_transaction_data_source.dart';

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