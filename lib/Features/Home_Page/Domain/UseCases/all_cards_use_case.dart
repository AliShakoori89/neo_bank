import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Entities/card_list_entity.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/all_card_repository.dart';

class AllCardsUseCase {
  final AllCardRepository allCardRepository;

  AllCardsUseCase({required this.allCardRepository});

  Future<List<CardEntity>> getAllCards(){
    return allCardRepository.getAllCards();
  }
}