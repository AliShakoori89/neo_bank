import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_event.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Card_Slider_Bloc/refresh_count_state.dart';

class RefreshCountBloc extends Bloc<RefreshCountEvent, RefreshCountState> {
  static const int maxRefreshCount = 5;

  RefreshCountBloc() : super(RefreshCountState.initial()) {
    on<GetRefreshCountEvent>(_mapGetRefreshCountEventToState);
  }

  void _mapGetRefreshCountEventToState(
    GetRefreshCountEvent event,
    Emitter<RefreshCountState> emit,
  ) async {
    if (state.refreshCount >= maxRefreshCount) {
      emit(state.copyWith(status: RefreshCountStatus.refreshLimitExceeded));
      return;
    }

    try {
      emit(
        state.copyWith(
          status: RefreshCountStatus.loading,
          refreshCount: state.refreshCount + 1,
        ),
      );

      emit(state.copyWith(status: RefreshCountStatus.success));
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      emit(state.copyWith(status: RefreshCountStatus.error));
    } catch (e) {
      print('Other error: $e');
      emit(state.copyWith(status: RefreshCountStatus.error));
    }
  }
}
