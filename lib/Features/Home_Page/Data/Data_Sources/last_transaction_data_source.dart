import 'package:dio/dio.dart';
import '../../../Statement_Page/Data/Model/statement_model.dart';

class LastTransactionDataSource {
  final Dio dio;

  LastTransactionDataSource({
    required this.dio,
  });

  Future<StatementResponseModel> getLastestStatement(String depositNumber) async{

    final body = {
      "depositNumber": depositNumber,
      "useDefaultFilter": true,
      "description": "string",
      "length": 10,
      "offset": 0,
    };

    final response = await dio.post(
      '/api/Statements/get-all',
      data: body,
    );

    if (response.data is Map<String, dynamic>) {
      final result = StatementResponseModel.fromJson(response.data);
      if (response.statusCode == 200 && result.success == true) {
        return result;
      }
    }

    return StatementResponseModel();
  }
}