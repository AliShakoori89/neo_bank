import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/all_cards_pans_model.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/deposits_model.dart';

class DepositsRepository {
  final dio = Dio();

  Future<DepositsModel> getUserAllAccount() async {
    try {
      final token = await LocalStorage.read('access_token');

      final response = await dio.post(
        "${APIKey.baseUrl}/api/deposits/get-all",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': '$token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        return DepositsModel.fromJson(data);
      }
    } catch (e) {
      rethrow; // بزار Bloc تصمیم بگیره
    }
    return DepositsModel();
  }
}
