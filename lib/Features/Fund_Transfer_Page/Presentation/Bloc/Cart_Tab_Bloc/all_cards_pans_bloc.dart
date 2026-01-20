import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repository/all_card_pan_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_pans_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_pans_state.dart';

class AllCardsPansBloc extends Bloc<AllCardsPansEvent, AllCardsPansState> {
  AllCardPanRepository allCardPanRepository;

  AllCardsPansBloc(this.allCardPanRepository)
    : super(AllCardsPansState.initial()) {
    on<GetAllCardsPanEvent>(_mapGetAllCardsPanEvent);
  }

  void _mapGetAllCardsPanEvent(
    GetAllCardsPanEvent event,
    Emitter<AllCardsPansState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AllCardsPanStatus.loading));

      final cardsPan = await allCardPanRepository.getAllCardsPan();

      emit(
        state.copyWith(status: AllCardsPanStatus.success, cardsPan: cardsPan),
      );
    } on DioException catch (e) {
      // if (e.error == 'TOKEN_EXPIRED' || e.response?.statusCode == 401) {
      //   emit(state.copyWith(status: GetAllCardsStatus.tokenExpired));
      // } else {
      //   emit(state.copyWith(status: GetAllCardsStatus.error));
      // }
    } catch (error) {
      emit(state.copyWith(status: AllCardsPanStatus.error));
    }
  }
}
