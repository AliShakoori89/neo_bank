import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

class GetAllCardRepository {
  Future<CardListModel> getAllCards() async {
    try {
      final response = await DioClient.dio.post("/api/cards/get-all");

      if (response.statusCode == 200) {
        return CardListModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow; // بزار Bloc تصمیم بگیره
    }
    return CardListModel();
  }
}
