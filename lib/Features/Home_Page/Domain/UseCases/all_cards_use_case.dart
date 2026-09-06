import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/all_card_repository.dart';
import '../../Data/Model/card_list_model.dart';

class AllCardsUseCase {
  final AllCardRepository allCardRepository;

  AllCardsUseCase({required this.allCardRepository});

  Future<CardListModel> getAllCards(){
    return allCardRepository.getAllCards();
  }
}