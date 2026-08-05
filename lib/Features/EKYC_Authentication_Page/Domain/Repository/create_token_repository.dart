import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/create_token_model.dart';
import '../../../../Core/Const/api_key.dart';
import '../../../../Core/Const/app_exception.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class CreateTokenRepository {
  final dio = Dio();

  Future<CreateTokenModel> createTokenResponse(String cardSerialNo, String cardExpDate) async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw AppException('Token not found');

    final body = {
      "cardSerialNo": cardSerialNo,
      "cardExpDate": cardExpDate
    };

    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/create-token",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

      print('/api/kycs/create-token');
      print(response.statusCode);
      return CreateTokenModel.fromJson(response.data);

    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.statusCode);
        print(e.response!.data);
        print(e.response!.data?['error']?['errorMessage'].replaceFirst('Exception: ', ''));

        final message = e.response!.data?['error']?['errorMessage'];

        throw AppException(message ?? 'خطای ناشناخته');
      }

      throw AppException('خطا در برقراری ارتباط با سرور');
    }
  }

}