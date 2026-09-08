import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Repository/abort_token_repository.dart';
import 'abort_token_event.dart';
import 'abort_token_state.dart';

class AbortTokenBloc extends Bloc<AbortTokenEvent, AbortTokenState> {
  final AbortTokenRepository abortTokenRepository;

  AbortTokenBloc(this.abortTokenRepository) : super(AbortTokenState.initial()) {
    on<GetAbortTokenEvent>(_onGetAbortTokenEvent);
  }

  Future<void> _onGetAbortTokenEvent(
      GetAbortTokenEvent event,
      Emitter<AbortTokenState> emit,
      ) async {
    try {
      emit(state.copyWith(status: AbortTokenStateStatus.loading));

      final abortToken = await abortTokenRepository.abortToken();

      print(abortToken.data);

      if (abortToken.success!) {
        emit(
          state.copyWith(
            status: AbortTokenStateStatus.success,
            abortToken: abortToken,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: AbortTokenStateStatus.error,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: AbortTokenStateStatus.error,
        ),
      );
    }
  }

}