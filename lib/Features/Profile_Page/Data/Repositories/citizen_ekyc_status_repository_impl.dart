import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Domain/Repositories/citizen_kyc_status_repository.dart';
import '../Data_Sources/citizen_ekyc_status_remote_data_source.dart';

@LazySingleton(as: GetCitizenEKYCStatusRepository)
class CitizenEkycStatusRepositoryImpl implements GetCitizenEKYCStatusRepository{

  final CitizenEkycStatusRemoteDataSource citizenEkycStatusRemoteDataSource;

  CitizenEkycStatusRepositoryImpl({required this.citizenEkycStatusRemoteDataSource});

  @override
  Future<bool> fetchEKYCStatus() async {
    try {
      final data = await citizenEkycStatusRemoteDataSource.fetchEKYCStatus();

      if (data.success == true && data.data != null) {
        return data.data!.hasApprovedKYC ?? false;
      }
      return false;
    } on DioException catch (e) {
      print('DIO ERROR');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('MESSAGE: ${e.message}');
      if (e.error is AppException) throw e.error!;
      print(AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.'));
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      print(AppException('خطای غیرمنتظره: $e'));
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }

  }
}