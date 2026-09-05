import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repositories/deposits_repository.dart';
import '../../../../Core/Network/app_exception.dart';
import '../DataSources/deposit_remote_data_source.dart';
import '../Models/deposits_model.dart';

class DepositsRepositoryImpl implements DepositsRepository{

  final DepositRemoteDataSource depositRemoteDataSource;

  DepositsRepositoryImpl({
    required this.depositRemoteDataSource});

  @override
  Future<DepositsModel> getUserAllAccount() async{
    try {
      final data = await depositRemoteDataSource.getUserAllAccount();

      if (data.success == true) {
        return data;
      } else {
        throw AppException('Failed to fetch deposits');
      }
    } on DioException catch (e) {
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