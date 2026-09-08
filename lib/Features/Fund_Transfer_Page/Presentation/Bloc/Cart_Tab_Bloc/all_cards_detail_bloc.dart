import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Network/app_exception.dart';
import '../../../Domain/UseCases/all_card_detail_use_case.dart';
import 'all_cards_detail_event.dart';
import 'all_cards_detail_state.dart';

class AllCardsDetailBloc
    extends Bloc<AllCardsDetailEvent, AllCardsDetailState> {
  final AllCardDetailUseCase allCardDetailUseCase;

  AllCardsDetailBloc({required this.allCardDetailUseCase})
    : super(AllCardsDetailState.initial()) {
    on<GetAllCardsDetailEvent>(_mapGetAllCardsPanEvent);
  }

  Future<void> _mapGetAllCardsPanEvent(
    GetAllCardsDetailEvent event,
    Emitter<AllCardsDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AllCardsDetailStatus.loading));

      final cardsPan = await allCardDetailUseCase.getAllCardsPan();

      final cardsDeposit = await allCardDetailUseCase.getAllCardsDeposit();

      emit(
        state.copyWith(
          status: AllCardsDetailStatus.success,
          cardsPan: cardsPan,
          cardsDeposit: cardsDeposit,
        ),
      );
    } on AppException catch (e) {
      if (e.statusCode == 401) {
        emit(state.copyWith(status: AllCardsDetailStatus.tokenExpired));
      } else {
        emit(state.copyWith(status: AllCardsDetailStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: AllCardsDetailStatus.error));
    }
  }
}
