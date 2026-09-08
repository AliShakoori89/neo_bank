import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Network/dio_client.dart';
import '../Model/statement_model.dart';

@lazySingleton
class StatementDataSources {
  final Dio _dio;

  StatementDataSources({
    required DioClient dioClient,
  }) : _dio = dioClient.dio;

  Future<StatementResponseModel> getLastestStatement({
    required String depositNumber,
    required int offset,
  }) async{

    final body = {
      "depositNumber": depositNumber,
      "useDefaultFilter": true,
      "description": "",
      "length": 10,
      "offset": offset,
      "fromDate": "2026-02-03T05:39:52.955Z",
      "toDate": "2026-02-11T05:39:52.955Z"
    };

    final response = await _dio.post(
      '/api/Statements/get-all',
      data: body,
    );

    return StatementResponseModel.fromJson(response.data);
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

    final response = await _dio.post(
      '/api/Statements/get-all',
      data: body,
    );

    return StatementResponseModel.fromJson(response.data);
  }
}