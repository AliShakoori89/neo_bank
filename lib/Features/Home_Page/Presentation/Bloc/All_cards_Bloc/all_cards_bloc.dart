import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/all_card_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_state.dart';

class AllCardsBloc extends Bloc<AllCardsEvent, AllCardsState> {
  AllCardRepository allCardRepository;
  static const int maxRefreshCount = 5;

  AllCardsBloc(this.allCardRepository) : super(AllCardsState.initial()) {
    on<GetUserAllCardsEvent>(_mapGetUserAllCardsEventToState);
  }

  void _mapGetUserAllCardsEventToState(
    GetUserAllCardsEvent event,
    Emitter<AllCardsState> emit,
  ) async {
    if (state.refreshCount >= maxRefreshCount) {
      emit(
        state.copyWith(
          status: GetAllCardsStatus.refreshLimitExceeded,
          cards: state.cards,
        ),
      );
      return;
    }

    try {
      emit(
        state.copyWith(
          status: GetAllCardsStatus.loading,
          refreshCount: state.refreshCount + 1,
        ),
      );

      final cards = await allCardRepository.getAllCards();

      await Future.delayed(const Duration(milliseconds: 100));

      emit(
        state.copyWith(status: GetAllCardsStatus.success, cards: cards.data),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(state.copyWith(status: GetAllCardsStatus.tokenExpired));
      } else {
        emit(state.copyWith(status: GetAllCardsStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: GetAllCardsStatus.error));
    }
  }
}
