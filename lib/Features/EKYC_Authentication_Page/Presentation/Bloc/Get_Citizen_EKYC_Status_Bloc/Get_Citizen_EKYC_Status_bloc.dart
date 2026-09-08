import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Repository/get_citizen_ekyc_status_repository.dart';
import 'Get_Citizen_EKYC_Status_event.dart';
import 'Get_Citizen_EKYC_Status_state.dart';

class GetCitizenEkycStatusBloc extends Bloc<GetCitizenEkycStatusEvent, GetCitizenEkycStatusState> {
  final GetCitizenEkycStatusRepository getCitizenEkycStatusRepository;

  GetCitizenEkycStatusBloc(this.getCitizenEkycStatusRepository) : super(GetCitizenEkycStatusState.initial()) {
    on<EkycStateInquiryStatusEvent>(_onEkycStateInquiryStatusEvent);
  }

  Future<void> _onEkycStateInquiryStatusEvent(
      EkycStateInquiryStatusEvent event,
      Emitter<GetCitizenEkycStatusState> emit,
      ) async {
    try {
      emit(state.copyWith(status: GetCitizenEkycStatusStateStatus.loading));

      final getCitizenKycStatus = await getCitizenEkycStatusRepository
          .getCitizenEkycStatus();

      if (getCitizenKycStatus.success!) {
        emit(
          state.copyWith(
              status: GetCitizenEkycStatusStateStatus.success,
              state: getCitizenKycStatus.data!.state
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GetCitizenEkycStatusStateStatus.error,
            errorMessage: getCitizenKycStatus.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: GetCitizenEkycStatusStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: GetCitizenEkycStatusStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

}