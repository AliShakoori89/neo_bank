import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';
import 'package:flutter/foundation.dart';

class StatementRepository {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<StatementResponseModel> getLastestStatement({
    required String depositNumber,
    required int offset,
  }) async {
    try {
      /// 🔐 read token
      final token = await LocalStorage.read('access_token');

      if (token == null || token.isEmpty) {
        throw Exception('Access token not found');
      }

      final body = {
        "depositNumber": depositNumber,
        "useDefaultFilter": false,
        "description": "",
        "length": 10,
        "offset": offset,
        "statementActionType": 0,
        "fromDate": "2026-02-03T05:39:52.955Z",
        "toDate": "2026-02-11T05:39:52.955Z"};

      final response = await _dio.post(
        '${APIKey.baseUrl}/api/Statements/get-all',
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );

      /// 🛡️ defensive parsing
      if (response.data is Map<String, dynamic>) {
        final result = StatementResponseModel.fromJson(response.data);

        if (response.statusCode == 200 && result.success == true) {
          return result;
        }
      }

      /// fallback
      return StatementResponseModel();
    }
    /// 🌐 dio specific errors
    on DioException catch (e, s) {
      debugPrint('DioException in getAllStatement: ${e.message}');
      debugPrintStack(stackTrace: s);

      return StatementResponseModel(
        success: false,
        error: e.response?.data ?? e.message,
      );
    }
    /// ❌ any other error
    catch (e, s) {
      debugPrint('Unexpected error in getAllStatement: $e');
      debugPrintStack(stackTrace: s);

      return StatementResponseModel(
        success: false,
        error: ApiErrorModel(errorMessage: e.toString()),
      );
    }
  }

  Future<StatementResponseModel> getFilterStatement({
    required String depositNumber,
    required int offset,
    int? statementActionType,
    required String startDate,
    required String endDate,
  }) async {
    try {

      print('2222222222222222222222222222222');
      /// 🔐 read token
      final token = await LocalStorage.read('access_token');

      if (token == null || token.isEmpty) {
        throw Exception('Access token not found');
      }

      final body = {
        "depositNumber": depositNumber,
        "useDefaultFilter": false,
        "description": "",
        "length": 10,
        "offset": offset,
        if (statementActionType != null)
          "statementActionType": statementActionType,
        "fromDate": startDate,
        "toDate": endDate};

      final response = await _dio.post(
        '${APIKey.baseUrl}/api/Statements/get-all',
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );

      /// 🛡️ defensive parsing
      if (response.data is Map<String, dynamic>) {
        final result = StatementResponseModel.fromJson(response.data);

        if (response.statusCode == 200 && result.success == true) {
          return result;
        }
      }

      /// fallback
      return StatementResponseModel();
    }
    /// 🌐 dio specific errors
    on DioException catch (e, s) {
      debugPrint('DioException in getAllStatement: ${e.message}');
      debugPrintStack(stackTrace: s);

      return StatementResponseModel(
        success: false,
        error: e.response?.data ?? e.message,
      );
    }
    /// ❌ any other error
    catch (e, s) {
      debugPrint('Unexpected error in getAllStatement: $e');
      debugPrintStack(stackTrace: s);

      return StatementResponseModel(
        success: false,
        error: ApiErrorModel(errorMessage: e.toString()),
      );
    }
  }

}
