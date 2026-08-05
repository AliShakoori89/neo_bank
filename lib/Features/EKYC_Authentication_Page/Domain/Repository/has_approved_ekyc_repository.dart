import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/has_approved_ekyc.dart';
import '../../../../Core/Const/app_exception.dart';

class HasApprovedEkycRepository {
  final Dio dio;

  HasApprovedEkycRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<HasApprovedEkycModel> getHasApprovedEkycRepository() async {
    try {
      final response = await dio.post("/api/kycs/has-approved-kyc");

      if (response.statusCode == 200) {
        return HasApprovedEkycModel.fromJson(response.data);
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