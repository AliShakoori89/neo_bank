import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/random_text_model.dart';

class RandomTextRepository {
  final Dio dio;

  RandomTextRepository({Dio? dio}) : dio = dio ?? Dio();

  Future<RandomTextModel> getRandomText() async {
    final token = await LocalStorage.read('access_token');

    if (token == null || token.isEmpty) {
      throw AppException('Token not found');
    }

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/get-random-text",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": token,
          },
        ),
      );

      print('/api/kycs/get-random-text');
      print(response.data);

      if (response.statusCode == 200) {
        final data = response.data;

        return RandomTextModel.fromJson(data);
      }

      throw AppException('خطا در ارتباط با سرور');
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? e.message;
      throw AppException(message);
    } catch (e) {
      throw AppException('Unexpected error: $e');
    }
  }
}