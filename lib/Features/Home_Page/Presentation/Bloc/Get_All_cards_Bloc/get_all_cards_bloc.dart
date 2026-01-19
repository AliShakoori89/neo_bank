import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/get_all_card_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_All_cards_Bloc/get_all_cards_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_All_cards_Bloc/get_all_cards_state.dart';

class GetAllCardsBloc extends Bloc<GetAllCardsEvent, GetAllCardsState> {
  GetAllCardRepository getAllCardsRepository;

  GetAllCardsBloc(this.getAllCardsRepository)
    : super(GetAllCardsState.initial()) {
    on<GetUserAllCardsEvent>(_mapGetUserAllCardsEventToState);
  }

  void _mapGetUserAllCardsEventToState(
    GetUserAllCardsEvent event,
    Emitter<GetAllCardsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GetAllCardsStatus.loading));

      final cards = await getAllCardsRepository.getAllCards();

      emit(
        state.copyWith(status: GetAllCardsStatus.success, cards: cards.data),
      );
    } on DioException catch (e) {
      // if (e.error == 'TOKEN_EXPIRED' || e.response?.statusCode == 401) {
      //   emit(state.copyWith(status: GetAllCardsStatus.tokenExpired));
      // } else {
      //   emit(state.copyWith(status: GetAllCardsStatus.error));
      // }
    } catch (error) {
      emit(state.copyWith(status: GetAllCardsStatus.error));
    }
  }
}
