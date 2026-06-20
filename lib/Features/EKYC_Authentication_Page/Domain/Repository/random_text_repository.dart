import 'package:dio/dio.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';
import '../../Data/Model/random_text_model.dart';

class RandomTextRepository {
  final dio = Dio();

  Future<RandomTextModel> getRandomTextRepository() async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/get-random-text",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        return RandomTextModel.fromJson(response.data);
      } else {
        throw Exception('خطا در ارتباط با سرور');
      }

    }catch (e) {
      rethrow;
    }
  }

}