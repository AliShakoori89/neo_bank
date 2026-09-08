import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Data/Model/create_token_model.dart';

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