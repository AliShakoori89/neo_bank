import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Network/app_exception.dart';
import '../../../Domain/UseCases/all_cards_use_case.dart';
import 'all_cards_event.dart';
import 'all_cards_state.dart';

class AllCardsBloc extends Bloc<AllCardsEvent, AllCardsState> {
  final AllCardsUseCase allCardsUseCase;
  static const int maxRefreshCount = 5;

  AllCardsBloc({required this.allCardsUseCase}) : super(AllCardsState.initial()) {
    on<GetUserAllCardsEvent>(_mapGetUserAllCardsEventToState);
  }

  Future<void> _mapGetUserAllCardsEventToState(
    GetUserAllCardsEvent event,
    Emitter<AllCardsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GetAllCardsStatus.loading));

      final cards = await allCardsUseCase.getAllCards();

      await Future.delayed(const Duration(milliseconds: 100));

      emit(
        state.copyWith(status: GetAllCardsStatus.success, cards: cards),
      );
    } on AppException catch (e) {
      if (e.statusCode == 401) {
        emit(
          state.copyWith(
            status: GetAllCardsStatus.tokenExpired,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GetAllCardsStatus.error,
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(status: GetAllCardsStatus.error));
    }
  }
}
