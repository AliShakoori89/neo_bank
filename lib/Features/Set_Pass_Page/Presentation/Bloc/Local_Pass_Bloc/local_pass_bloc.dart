import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_event.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/Bloc/Local_Pass_Bloc/local_pass_state.dart';
import '../../../Domain/Repository/local_pass_repository.dart';

@injectable
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
