import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';
import '../../../../Core/Const/app_exception.dart';

class StatementRepository {
  final Dio _dio;

  StatementRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  Future<StatementResponseModel> getLastestStatement({
    required String depositNumber,
    required int offset,
  }) async {
    final body = {
      "depositNumber": depositNumber,
      "useDefaultFilter": true,
      "description": "",
      "length": 10,
      "offset": offset,
      "fromDate": "2026-02-03T05:39:52.955Z",
      "toDate": "2026-02-11T05:39:52.955Z"
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

  Future<StatementResponseModel> getFilterStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  }) async {
    final body = {
      "depositNumber": depositNumber,
      "useDefaultFilter": false,
      "description": "",
      "length": 10,
      "offset": offset,
      if (statementActionType != null) "statementActionType": statementActionType,
      "fromDate": startDate,
      "toDate": endDate
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