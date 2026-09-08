import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../Core/Network/app_exception.dart';
import '../../../../Core/Network/dio_client.dart';
import '../../Data/Model/validate_token_model.dart';

class ValidateTokenRepository {
  final Dio dio;

  ValidateTokenRepository({Dio? dio}) : dio = dio ?? DioClient().dio;

  Future<ValidateTokenModel> validateTokenResponse(String tokenValue, int orderId,
      String tokenExpirationDateTime, String cardSerialNo, String cardExpDate) async {
    final body = {
      "tokenValue": tokenValue,
      "orderId": orderId,
      "tokenExpirationDateTime": tokenExpirationDateTime,
      "cardSerialNo": cardSerialNo,
      "cardExpDate": cardExpDate
    };

    try {
      final response = await dio.post(
        "/api/kycs/validate-token",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return ValidateTokenModel.fromJson(response.data);
      } else {
        throw AppException('خطا در اعتبارسنجی توکن');
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