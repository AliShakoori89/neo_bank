import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Domain/Repository/user_login_auth_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_state.dart';

class UserLoginAuthBloc extends Bloc<UserLoginAuthEvent, UserLoginAuthState> {
  UserLoginAuthRepository userAuthRepository;

  UserLoginAuthBloc(this.userAuthRepository)
    : super(UserLoginAuthState.initial()) {
    on<UserLoginEvent>(_mapUserLoginEventToState);
  }

  void _mapUserLoginEventToState(
    UserLoginEvent event,
    Emitter<UserLoginAuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserLoginAuthStatus.loading));

      final logined = await userAuthRepository.userLogin(
        event.username,
        event.password,
      );

      emit(
        state.copyWith(
          status: UserLoginAuthStatus.success,
          loginStatus: logined!,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserLoginAuthStatus.error));
    }
  }
}
