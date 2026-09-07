import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Entities/card_list_entity.dart';

abstract class AllCardRepository {
  Future<List<CardEntity>> getAllCards();
}
