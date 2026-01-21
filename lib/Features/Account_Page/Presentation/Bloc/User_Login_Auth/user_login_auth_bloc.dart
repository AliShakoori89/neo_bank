import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/Repository/user_login_auth_repository.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_state.dart';

class UserLoginAuthBloc extends Bloc<UserLoginAuthEvent, UserLoginAuthState> {
  UserLoginAuthRepository userAuthRepository;

  UserLoginAuthBloc(this.userAuthRepository)
    : super(UserLoginAuthState.initial()) {
    on<UserLoginEvent>(_mapUserLoginEventToState);
    on<UserIsLoginEvent>(_mapUserIsLoginEventToState);
    on<LogoutEvent>(_mapLogoutEventToState);
  }

  void _mapUserLoginEventToState(
    UserLoginEvent event,
    Emitter<UserLoginAuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserLoginAuthStatus.loading));

      final result = await userAuthRepository.userLogin(
        event.nationalCode,
        event.phoneNumber,
      );

      emit(
        state.copyWith(
          status: UserLoginAuthStatus.success,
          loginStatus: result.success,
          loginMessage: result.message,
          secretKey: result.secretKey,
          deviceId: result.deviceId,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserLoginAuthStatus.error));
    }
  }

  void _mapUserIsLoginEventToState(
    UserIsLoginEvent event,
    Emitter<UserLoginAuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserLoginAuthStatus.loading));

      final isLogin = await userAuthRepository.userIsLogin();

      emit(
        state.copyWith(status: UserLoginAuthStatus.success, isLogin: isLogin!),
      );
    } catch (error) {
      emit(state.copyWith(status: UserLoginAuthStatus.error));
    }
  }

  void _mapLogoutEventToState(
    LogoutEvent event,
    Emitter<UserLoginAuthState> emit,
  ) async {
    emit(state.copyWith(status: UserLoginAuthStatus.loading));
    emit(state.copyWith(status: UserLoginAuthStatus.success, isLogin: null));
  }
}
