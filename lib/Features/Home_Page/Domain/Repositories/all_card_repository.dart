import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

abstract class AllCardRepository {
  Future<CardListModel> getAllCards();
}
