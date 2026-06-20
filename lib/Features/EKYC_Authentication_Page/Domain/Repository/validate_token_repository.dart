import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/validate_token_model.dart';

import '../../../../Core/Const/api_key.dart';
import '../../../Account_Page/Data/Data_Sources/Local/token_storage.dart';

class ValidateTokenRepository {
  final dio = Dio();

  Future<ValidateTokenModel> validateTokenResponse(String tokenValue, int orderId, String tokenExpirationDateTime) async{
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    final body = {
      "tokenValue": tokenValue,
      "orderId": orderId,
      "tokenExpirationDateTime": tokenExpirationDateTime
    };

    try{

      final response = await dio.post(
        "${APIKey.baseUrl}/api/kycs/validate-token",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        return ValidateTokenModel.fromJson(response.data);
      } else {
        throw Exception('خطا در اعتبارسنجی توکن');
      }

    }catch (e) {
      rethrow;
    }
  }

}