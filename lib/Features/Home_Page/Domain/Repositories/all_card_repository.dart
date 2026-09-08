import '../Entities/card_list_entity.dart';

abstract class AllCardRepository {
  Future<List<CardEntity>> getAllCards();
}
