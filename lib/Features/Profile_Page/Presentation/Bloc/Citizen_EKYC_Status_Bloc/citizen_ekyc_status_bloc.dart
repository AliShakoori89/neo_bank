import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../Core/Network/app_exception.dart';
import '../../../Domain/UseCases/citizen_ekyc_status_use_case.dart';
import 'citizen_ekyc_status_event.dart';
import 'citizen_ekyc_status_state.dart';

@lazySingleton
class CitizenEkycStatusBloc extends Bloc<CitizenEkycStatusEvent, CitizenEkycStatusState> {
  final CitizenEkycStatusUseCase citizenEkycStatusUseCase;

  CitizenEkycStatusBloc({required this.citizenEkycStatusUseCase}) : super(CitizenEkycStatusState.initial()) {
    on<FetchCitizenEkycStatusEvent>(_onFetchCitizenEkycStatusEvent);
  }

  Future<void> _onFetchCitizenEkycStatusEvent(
      FetchCitizenEkycStatusEvent event,
      Emitter<CitizenEkycStatusState> emit,
      ) async {
    try {
      emit(state.copyWith(status: CitizenEkycStatusStateStatus.loading));

      final citizenEkycStatus = await citizenEkycStatusUseCase.fetchEKYCStatus();

      emit(
        state.copyWith(
          status: CitizenEkycStatusStateStatus.success,
          citizenEkycStatus: citizenEkycStatus,
          errorMessage: ''
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(
          status: CitizenEkycStatusStateStatus.error,
          errorMessage: e.message
      ));
    } catch (e) {
      emit(state.copyWith(
          status: CitizenEkycStatusStateStatus.error,
          errorMessage: 'خطای غیرمنتظره رخ داده است.'
      ));
    }
  }

}
