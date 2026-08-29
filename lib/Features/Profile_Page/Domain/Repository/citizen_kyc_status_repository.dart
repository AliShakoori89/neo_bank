import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../Data/Model/citizen_kyc_status_model.dart';

class GetCitizenKycStatusRepository {
  final Dio dio;

  GetCitizenKycStatusRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<bool> fetchEKYCStatus() async {
    try {
      final response = await dio.post('/api/kycs/get-citizen-kyc-status');

      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('HEADERS: ${response.headers}');

      if (response.statusCode == 200) {
        final result = CitizenEkycStatusModel.fromJson(response.data);
        if (result.success != true || result.data == null) {
          return false;
        }
        return result.data!.hasApprovedKYC!;
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