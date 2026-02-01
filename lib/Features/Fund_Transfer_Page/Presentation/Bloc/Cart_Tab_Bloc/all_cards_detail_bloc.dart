import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repository/all_card_detail_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_state.dart';

class AllCardsDetailBloc
    extends Bloc<AllCardsDetailEvent, AllCardsDetailState> {
  AllCardDetailRepository allCardDetailRepository;

  AllCardsDetailBloc(this.allCardDetailRepository)
    : super(AllCardsDetailState.initial()) {
    on<GetAllCardsDetailEvent>(_mapGetAllCardsPanEvent);
  }

  void _mapGetAllCardsPanEvent(
    GetAllCardsDetailEvent event,
    Emitter<AllCardsDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AllCardsDetailStatus.loading));

      final cardsPan = await allCardDetailRepository.getAllCardsPan();

      final cardsDeposit = await allCardDetailRepository.getAllCardsDeposit();

      emit(
        state.copyWith(
          status: AllCardsDetailStatus.success,
          cardsPan: cardsPan,
          cardsDeposit: cardsDeposit,
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(state.copyWith(status: AllCardsDetailStatus.tokenExpired));
      } else {
        emit(state.copyWith(status: AllCardsDetailStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: AllCardsDetailStatus.error));
    }
  }
}
