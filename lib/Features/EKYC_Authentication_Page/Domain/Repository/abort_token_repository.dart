import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/abort_token_model.dart';
import '../../../../Core/Const/app_exception.dart';

class AbortTokenRepository {
  final Dio dio;

  AbortTokenRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<AbortTokenModel> abortToken() async {
    try {
      final response = await dio.post("/api/kycs/abort-token");

      if (response.statusCode == 200) {
        return AbortTokenModel.fromJson(response.data);
      } else {
        throw AppException('خطا در امحاء توکن');
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