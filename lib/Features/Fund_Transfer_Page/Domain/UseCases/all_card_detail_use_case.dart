import 'package:injectable/injectable.dart';
import '../Entities/ali_card_pan_entity.dart';
import '../Repositories/all_card_detail_repository.dart';

@lazySingleton
class AllCardDetailUseCase {
  final AllCardDetailRepository repository;

  AllCardDetailUseCase({required this.repository});

  Future<List<AliCardPanEntity>> getAllCards() {
    return repository.getAllCards();
  }

  Future<List<String>> getAllCardsPan(){
    return repository.getAllCardsPan();
  }

  Future<List<String>> getAllCardsDeposit(){
    return repository.getAllCardsDeposit();
  }
}