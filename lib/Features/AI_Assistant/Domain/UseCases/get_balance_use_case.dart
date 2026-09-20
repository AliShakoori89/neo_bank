import 'package:injectable/injectable.dart';
import '../../../Home_Page/Domain/UseCases/all_cards_use_case.dart';

@injectable
class GetBalanceUseCase {
  final AllCardsUseCase allCardsUseCase;

  GetBalanceUseCase({
    required this.allCardsUseCase,
  });

  Future<String> call() async {
    final cards = await allCardsUseCase.getAllCards();

    if (cards.isEmpty) {
      return '0 تومان';
    }

    final balance = cards.first.availableBalance ?? 0;

    return '$balance تومان';
  }
}