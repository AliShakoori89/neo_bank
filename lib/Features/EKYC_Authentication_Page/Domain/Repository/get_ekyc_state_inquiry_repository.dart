import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/get_ekyc_state_inquiry_model.dart';
import '../../../../Core/Network/app_exception.dart';

class GetEkycStateInquiryRepository {
  final Dio dio;

  GetEkycStateInquiryRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<GetEkycStateInquiryModel> getEKYCStateInquiryRepository() async {
    try {
      final response = await dio.post("/api/kycs/get-kyc-state-inquiry");

      if (response.statusCode == 200) {
        return GetEkycStateInquiryModel.fromJson(response.data);
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