import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/abort_token_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class AbortTokenRepository {
  final dio = Dio();

  Future<AbortTokenModel> abortToken() async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/abort-token",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      print('/api/kycs/abort-token');
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);
        return AbortTokenModel.fromJson(response.data);
      } else {
        throw Exception('خطا در امحاء توکن');
      }

    }catch (e) {
      rethrow;
    }
  }

}