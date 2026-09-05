import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Data_Sources/statement_data_sources.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Repositories/statement_repository.dart';
import '../Model/statement_model.dart';

class StatementRepositoryImpl implements StatementRepository{

  final StatementDataSources statementDataSources;

  StatementRepositoryImpl({required this.statementDataSources});

  @override
  Future<StatementResponseModel> getLastestStatement(
  {
    required String depositNumber,
    required int offset}
  ) async {
    try {

      final data = await statementDataSources.getLastestStatement(
        depositNumber: depositNumber,
        offset: offset
      );

      if (data.success == true) { return data; }

      throw AppException('خطا در دریافت صورت‌حساب');
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }

  @override
  Future<StatementResponseModel> getFilterStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final data = await statementDataSources.getFilterStatement(
        depositNumber: depositNumber,
        offset: offset,
        statementActionType: statementActionType,
        startDate: startDate,
        endDate: endDate,
      );

      if (data.success == true) {
        return data;
      }

      throw AppException('خطا در دریافت صورت‌حساب فیلتر شده');
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error!;
      }

      throw AppException(
        e.message ?? 'خطایی در ارتباط با سرور رخ داده است.',
      );
    } catch (e) {
      if (e is AppException) rethrow;

      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}