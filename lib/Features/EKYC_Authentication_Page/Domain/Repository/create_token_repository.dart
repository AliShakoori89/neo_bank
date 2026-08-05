import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Data/Model/create_token_model.dart';
import '../../../../Core/Const/app_exception.dart';

class CreateTokenRepository {
  final Dio dio;

  CreateTokenRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<CreateTokenModel> createTokenResponse(String cardSerialNo, String cardExpDate) async {
    final body = {
      "cardSerialNo": cardSerialNo,
      "cardExpDate": cardExpDate
    };

    try {
      final response = await dio.post(
        "/api/kycs/create-token",
        data: jsonEncode(body),
      );

      return CreateTokenModel.fromJson(response.data);
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