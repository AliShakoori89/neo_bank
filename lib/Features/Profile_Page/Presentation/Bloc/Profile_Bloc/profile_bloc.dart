import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Repository/profile_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_event.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';

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

      final profileFields = await getProfileRepository.getProfileField();

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profileFields: profileFields,
        ),
      );
    } on DioException catch (e) {
      // if (e.error == 'TOKEN_EXPIRED' || e.response?.statusCode == 401) {
      //   emit(state.copyWith(status: GetAllCardsStatus.tokenExpired));
      // } else {
      //   emit(state.copyWith(status: GetAllCardsStatus.error));
      // }
    } catch (error) {
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }
}
