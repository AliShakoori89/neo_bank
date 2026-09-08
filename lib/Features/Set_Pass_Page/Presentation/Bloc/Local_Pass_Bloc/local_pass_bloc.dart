import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Repository/local_pass_repository.dart';
import 'local_pass_event.dart';
import 'local_pass_state.dart';

class LocalPassBloc extends Bloc<LocalPassEvent, LocalPassState> {
  LocalPassRepository setPassRepository;

  LocalPassBloc(this.setPassRepository)
      : super(LocalPassState.initial()) {
    on<SetPassEvent>(_mapSetPassEventEventToState);
    on<IsFirstLoginEvent>(_mapIsFirstLoginEventToState);
    on<FetchLocalPassEvent>(_mapFetchLocalPassEventToState);
  }

  void _mapSetPassEventEventToState(
      SetPassEvent event,
      Emitter<LocalPassState> emit,
      ) async {
    try {
      emit(state.copyWith(status: LocalPassStatus.loading));

      await setPassRepository.setPass(event.pass);

      emit(
        state.copyWith(status: LocalPassStatus.success),
      );

    } catch (error) {
      emit(state.copyWith(status: LocalPassStatus.error));
    }
  }

  void _mapIsFirstLoginEventToState(
      IsFirstLoginEvent event,
      Emitter<LocalPassState> emit,
      ) async {
    try {
      emit(state.copyWith(status: LocalPassStatus.loading));

      final isFirstLogin = await setPassRepository.isFirstLogin();

      emit(
        state.copyWith(status: LocalPassStatus.success, isFirstLoginStatus: isFirstLogin),
      );
    } catch (error) {
      emit(state.copyWith(status: LocalPassStatus.error));
    }
  }

  void _mapFetchLocalPassEventToState(
      FetchLocalPassEvent event,
      Emitter<LocalPassState> emit,
      ) async {
    try {
      emit(state.copyWith(status: LocalPassStatus.loading));

      final localPass = await setPassRepository.readPass();

      emit(
        state.copyWith(status: LocalPassStatus.success, localPass: localPass),
      );
    } catch (error) {
      emit(state.copyWith(status: LocalPassStatus.error));
    }
  }

}
