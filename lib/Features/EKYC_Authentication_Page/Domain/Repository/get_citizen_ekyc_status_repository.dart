import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Data/Model/get_citizen_ekyc_status_model.dart';

class GetCitizenEkycStatusRepository {
  final Dio dio;

  GetCitizenEkycStatusRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<GetCitizenEkycStatusModel> getCitizenEkycStatus() async {
    try {
      final response = await dio.post("/api/kycs/get-citizen-kyc-status");

      if (response.statusCode == 200) {
        return GetCitizenEkycStatusModel.fromJson(response.data);
      } else {
        throw AppException('خطا در ارتباط با سرور');
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