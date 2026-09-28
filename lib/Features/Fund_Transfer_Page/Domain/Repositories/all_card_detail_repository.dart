import '../Entities/ali_card_pan_entity.dart';

abstract class AllCardDetailRepository {

  Future<List<String>> getAllCardsPan();

  Future<List<String>> getAllCardsDeposit();

  Future<List<AliCardPanEntity>> getAllCards();
}
