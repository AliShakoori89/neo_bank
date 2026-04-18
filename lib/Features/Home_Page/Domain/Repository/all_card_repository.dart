import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

class AllCardRepository {
  final dio = Dio();

  Future<CardListModel> getAllCards() async {
    final token = await LocalStorage.read('access_token');
    if (token == null) throw Exception('Token not found');

    try {
      final response = await dio.post(
        "${APIKey.baseUrl}/api/cards/get-all",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return CardListModel.fromJson(data);
      }
    } catch (e) {
      print('خطا در دریافت کارت‌ها: $e');
      rethrow;
    }
    return CardListModel();
  }
}
