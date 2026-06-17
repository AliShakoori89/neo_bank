import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/api_error_model.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Repository/citizen_kyc_status_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_event.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_state.dart';

class CitizenEkycStatusBloc extends Bloc<CitizenEkycStatusEvent, CitizenEkycStatusState> {
  final GetCitizenKycStatusRepository citizenKycStatusRepository;

  CitizenEkycStatusBloc(this.citizenKycStatusRepository) : super(CitizenEkycStatusState.initial()) {
    on<FetchCitizenEkycStatusEvent>(_onFetchCitizenEkycStatusEvent);
  }

  Future<void> _onFetchCitizenEkycStatusEvent(
      FetchCitizenEkycStatusEvent event,
      Emitter<CitizenEkycStatusState> emit,
      ) async {
    try {

      final citizenEkycStatus = await citizenKycStatusRepository.fetchEKYCStatus();

      emit(
        state.copyWith(
          status: CitizenEkycStatusStateStatus.success,
          citizenEkycStatus: citizenEkycStatus,
          errorMessage: ApiErrorModel().errorMessage
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CitizenEkycStatusStateStatus.error));
    }
  }

}
