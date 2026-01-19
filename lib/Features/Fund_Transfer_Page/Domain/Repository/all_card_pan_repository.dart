import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

class AllCardPanRepository {
  final dio = Dio();

  Future<List<String>> getAllCardsPan() async {
    List<String> cardsPan = <String>[];

    try {
      final token = await LocalStorage.read('access_token');

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

      if (response.statusCode == 200) {
        final data = response.data;
        final cards = CardListModel.fromJson(data);
        for (int i = 0; i < cards.data!.length; i++) {
          cardsPan.add(cards.data![i].pan!);
        }

        print('cardsPan          ' + cardsPan.toString());
        return cardsPan;
      }
    } catch (e) {
      rethrow; // بزار Bloc تصمیم بگیره
    }
    return [];
  }
}
