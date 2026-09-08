import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Data/Model/random_text_model.dart';

class RandomTextRepository {
  final Dio dio;

  RandomTextRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<RandomTextModel> getRandomText() async {
    try {
      final response = await dio.post("/api/kycs/get-random-text");

      if (response.statusCode == 200) {
        return RandomTextModel.fromJson(response.data);
      }

      throw AppException('خطا در دریافت اطلاعات از سرور');
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
