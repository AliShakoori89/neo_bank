import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Network/app_exception.dart';
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
      emit(state.copyWith(status: CitizenEkycStatusStateStatus.loading));

      final citizenEkycStatus = await citizenKycStatusRepository.fetchEKYCStatus();

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
