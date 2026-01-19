import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

class GetAllCardRepository {
  final dio = Dio();

  Future<CardListModel> getAllCards() async {
    print('GetAllCardRepository');
    try {
      final token = await LocalStorage.read('access_token');

      print(token);

      final response = await dio.post(
        "${APIKey.baseUrl}/api/cards/get-all",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': '$token',
          },
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = response.data;
        print(CardListModel.fromJson(data));
        return CardListModel.fromJson(data);
      }
    } catch (e) {
      rethrow; // بزار Bloc تصمیم بگیره
    }
    return CardListModel();
  }
}
