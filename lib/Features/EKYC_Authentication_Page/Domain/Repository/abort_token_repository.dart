import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Data/Model/abort_token_model.dart';

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