import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';
import '../../../../Core/Network/app_exception.dart';

class LastTransactionRepository {
  final Dio _dio;

  LastTransactionRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  Future<StatementResponseModel> getLastestStatement(String depositNumber) async {
    final body = {
      "depositNumber": depositNumber,
      "useDefaultFilter": true,
      "description": "string",
      "length": 10,
      "offset": 0,
    };

    try {
      final response = await _dio.post(
        '/api/Statements/get-all',
        data: jsonEncode(body),
      );

      if (response.data is Map<String, dynamic>) {
        final result = StatementResponseModel.fromJson(response.data);
        if (response.statusCode == 200 && result.success == true) {
          return result;
        }
      }
      return StatementResponseModel();
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error!;
      throw AppException(e.message ?? 'خطایی در ارتباط با سرور رخ داده است.');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('خطای غیرمنتظره: $e');
    }
  }
}