import 'package:dio/dio.dart';
import 'package:neo_bank_mehr_iran/Core/Const/api_key.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Models/all_cards_pans_model.dart';

class AllCardPanRepository {
  final dio = Dio();

  Future<List<String>> getAllCardsPan() async {

    try {
      final token = await LocalStorage.read('access_token');
      if (token == null) throw Exception('Token not found');

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
        final cards = AllCardsPansModel.fromJson(response.data);
        final List<String> cardsPan = [];
        if (cards.data != null) {
          for (final card in cards.data!) {
            if (card.pan != null) cardsPan.add(card.pan!);
          }
        }
        return cardsPan;
      } else {
        throw Exception('Failed to fetch cards');
      }
    } catch (e) {
      rethrow; // Bloc handle
    }
  }
}
