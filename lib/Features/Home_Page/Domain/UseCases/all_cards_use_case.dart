import '../Entities/card_list_entity.dart';
import '../Repositories/all_card_repository.dart';

class AllCardsUseCase {
  final AllCardRepository allCardRepository;

  AllCardsUseCase({required this.allCardRepository});

  Future<List<CardEntity>> getAllCards(){
    return allCardRepository.getAllCards();
  }
}