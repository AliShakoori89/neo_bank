import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Repository/has_approved_ekyc_repository.dart';
import 'has_approved_ekyc_event.dart';
import 'has_approved_ekyc_state.dart';

class HasApprovedEkycBloc extends Bloc<HasApprovedEkycEvent, HasApprovedEkycState> {
  final HasApprovedEkycRepository hasApprovedEkycRepository;

  HasApprovedEkycBloc(this.hasApprovedEkycRepository) : super(HasApprovedEkycState.initial()) {
    on<GetHasApprovedEkycEvent>(_onGetHasApprovedEkycEvent);
  }

  Future<void> _onGetHasApprovedEkycEvent(
      GetHasApprovedEkycEvent event,
      Emitter<HasApprovedEkycState> emit,
      ) async {
    try {
      emit(state.copyWith(status: HasApprovedEkycStateStatus.loading));

      final hasApprovedEkyc = await hasApprovedEkycRepository
          .getHasApprovedEkycRepository();

      if (hasApprovedEkyc.success!) {
        emit(
          state.copyWith(
              status: HasApprovedEkycStateStatus.success,
              hasApprovedKYC: hasApprovedEkyc.data!.hasApprovedKYC
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: HasApprovedEkycStateStatus.error,
            errorMessage: hasApprovedEkyc.error!.errorMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.message}');
      emit(
        state.copyWith(
          status: HasApprovedEkycStateStatus.error,
          errorMessage: e.response?.data?.toString() ?? e.message,
        ),
      );
    } catch (error) {
      print('❌ Error: $error');
      emit(
        state.copyWith(
          status: HasApprovedEkycStateStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

}