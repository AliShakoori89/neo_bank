import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Repository/get_ekyc_state_inquiry_repository.dart';
import 'get_ekyc_state_inquiry_event.dart';
import 'get_ekyc_state_inquiry_state.dart';

class GetEkycStateInquiryBloc extends Bloc<GetEkycStateInquiryEvent, GetEkycStateInquiryState> {
  final GetEkycStateInquiryRepository getCitizenKycStatusRepository;

  GetEkycStateInquiryBloc(this.getCitizenKycStatusRepository) : super(GetEkycStateInquiryState.initial()) {
    on<GetEkycStateInquiryStatusEvent>(_onGetEkycStateInquiryStatusEvent);
  }

  Future<void> _onGetEkycStateInquiryStatusEvent(
      GetEkycStateInquiryStatusEvent event,
      Emitter<GetEkycStateInquiryState> emit,
      ) async {
    try {
      emit(state.copyWith(status: GetEkycStateInquiryStateStatus.loading));

      final getCitizenKycStatus = await getCitizenKycStatusRepository
          .getEKYCStateInquiryRepository();

      if (getCitizenKycStatus.success!) {
        emit(
          state.copyWith(
            status: GetEkycStateInquiryStateStatus.success,
            state: getCitizenKycStatus.data!.state
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GetEkycStateInquiryStateStatus.error,
            errorMessage: getCitizenKycStatus.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: GetEkycStateInquiryStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: GetEkycStateInquiryStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

}