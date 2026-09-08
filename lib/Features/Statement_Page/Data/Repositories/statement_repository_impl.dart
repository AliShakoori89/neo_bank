import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Entities/statement_entity.dart';
import '../../Domain/Repositories/statement_repository.dart';
import '../Data_Sources/statement_data_sources.dart';

@LazySingleton(as: StatementRepository)
class StatementRepositoryImpl implements StatementRepository{

  final StatementDataSources statementDataSources;

  StatementRepositoryImpl({required this.statementDataSources});

  @override
  Future<StatementEntity> getLastestStatement(
  {
    required String depositNumber,
    required int offset}
  ) async {
    try {

      final data = await statementDataSources.getLastestStatement(
        depositNumber: depositNumber,
        offset: offset
      );

      if (data.success == true && data.data != null) {
        return data.data!.toEntity();
      }

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
  Future<StatementEntity> getFilterStatement({
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

      if (data.success == true && data.data != null) {
        return data.data!.toEntity();
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