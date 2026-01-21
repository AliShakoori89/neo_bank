import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/deposits_model.dart';

class DepositsRepository {
  final dio = Dio();

  Future<DepositsModel> getUserAllAccount() async {
    try {
      final token = await LocalStorage.read('access_token');
      if (token == null) throw Exception('Token not found');

      final response = await dio.post(
        "${APIKey.baseUrl}/api/deposits/get-all",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        return DepositsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch deposits');
      }
    } catch (e) {
      rethrow; // Bloc handle
    }
  }
}
