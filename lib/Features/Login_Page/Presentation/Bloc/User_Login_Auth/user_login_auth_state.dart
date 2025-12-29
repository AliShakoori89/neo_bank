import 'package:equatable/equatable.dart';

enum UserLoginAuthStatus { initial, success, error, loading }

extension UserLoginAuthStatusX on UserLoginAuthStatus {
  bool get isInitial => this == UserLoginAuthStatus.initial;
  bool get isSuccess => this == UserLoginAuthStatus.success;
  bool get isError => this == UserLoginAuthStatus.error;
  bool get isLoading => this == UserLoginAuthStatus.loading;
}

class UserLoginAuthState extends Equatable {
  const UserLoginAuthState({required this.status, required this.loginStatus});

  static UserLoginAuthState initial() => UserLoginAuthState(
    status: UserLoginAuthStatus.initial,
    loginStatus: false,
  );

  final UserLoginAuthStatus status;
  final bool loginStatus;

  @override
  List<Object?> get props => [status, loginStatus];

  UserLoginAuthState copyWith({
    UserLoginAuthStatus? status,
    bool? loginStatus,
  }) {
    return UserLoginAuthState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
