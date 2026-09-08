import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Entities/deposit_entity.dart';
import '../../Domain/Repositories/deposits_repository.dart';
import '../DataSources/deposit_remote_data_source.dart';

@LazySingleton(as: DepositsRepository)
class DepositsRepositoryImpl implements DepositsRepository{

  final DepositRemoteDataSource depositRemoteDataSource;

  DepositsRepositoryImpl({
    required this.depositRemoteDataSource});

  @override
  Future<List<DepositEntity>> getUserAllAccount() async{
    try {
      final data = await depositRemoteDataSource.getUserAllAccount();

      if (data.success == true) {
        return data.data!
            .map((card) => card.toEntity())
            .toList();
      } else {
        throw AppException('Failed to fetch deposits');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException(
          'نشست شما منقضی شده است.',
          statusCode: 401,
        );
      }
      if (e.error is AppException) {
        throw e.error!;
      }
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}