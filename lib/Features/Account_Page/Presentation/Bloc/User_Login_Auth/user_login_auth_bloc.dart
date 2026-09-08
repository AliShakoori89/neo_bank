import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_event.dart';
import 'package:neo_bank/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_state.dart';
import '../../../Domain/UseCases/check_login_status_use_case.dart';
import '../../../Domain/UseCases/login_use_case.dart';

class UserLoginAuthBloc extends Bloc<UserLoginAuthEvent, UserLoginAuthState> {
  final LoginUseCase loginUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;

  UserLoginAuthBloc({
    required this.loginUseCase,
    required this.checkLoginStatusUseCase})
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

      final result = await loginUseCase(
        nationalNumber: event.nationalCode,
        mobileNumber: event.phoneNumber,
      );

      if (result.success) {
        emit(
          state.copyWith(
            status: UserLoginAuthStatus.success,
            loginStatus: true,
            loginMessage: result.message,
            secretKey: result.secretKey,
            deviceId: result.deviceId,
            expireTime: int.parse(result.expireTime),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UserLoginAuthStatus.error,
            loginStatus: false,
            loginMessage: result.message,
            secretKey: '',
            deviceId: '',
            expireTime: 0,
          ),
        );
      }
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

      final isLogin = await checkLoginStatusUseCase();

      emit(
        state.copyWith(status: UserLoginAuthStatus.success, isLogin: isLogin),
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
