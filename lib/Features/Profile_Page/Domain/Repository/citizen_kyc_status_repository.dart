import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../Data/Model/citizen_kyc_status_model.dart';

class GetCitizenKycStatusRepository {
  final Dio dio;

  GetCitizenKycStatusRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<bool> fetchEKYCStatus() async {
    try {
      final response = await dio.post('/api/kycs/get-citizen-kyc-status');

      if (response.statusCode == 200) {
        final result = CitizenEkycStatusModel.fromJson(response.data);
        if (result.success != true || result.data == null) {
          return false;
        }
        return result.data!.hasApprovedKYC!;
      }
      return false;
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}