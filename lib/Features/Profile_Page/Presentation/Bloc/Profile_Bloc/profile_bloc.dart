import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_event.dart';
import 'package:neo_bank/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';
import '../../../Domain/Entities/profile_result_entity.dart';
import '../../../Domain/Repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileRepository getProfileRepository;

  ProfileBloc(this.getProfileRepository) : super(ProfileState.initial()) {
    on<GetProfileEventEvent>(_mapGetUserAllCardsEventToState);
  }

  void _mapGetUserAllCardsEventToState(
    GetProfileEventEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));

      final ProfileResultEntity result = await getProfileRepository
          .getProfileField();

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          userName: result.userName,
          mobileNumber: result.mobileNumber,
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // emit(state.copyWith(status: ProfileStatus.tokenExpired));
      } else {
        emit(state.copyWith(status: ProfileStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }
}
