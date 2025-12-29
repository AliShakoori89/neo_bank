import 'package:equatable/equatable.dart';

enum UserLoginAuthStatus { initial, success, error, loading }

extension UserLoginAuthStatusX on UserLoginAuthStatus {
  bool get isInitial => this == UserLoginAuthStatus.initial;
  bool get isSuccess => this == UserLoginAuthStatus.success;
  bool get isError => this == UserLoginAuthStatus.error;
  bool get isLoading => this == UserLoginAuthStatus.loading;
}

class UserLoginAuthState extends Equatable {
  const UserLoginAuthState({
    required this.status,
    required this.logedin,
    required this.isLogin,
  });

  static UserLoginAuthState initial() => UserLoginAuthState(
    status: UserLoginAuthStatus.initial,
    logedin: false,
    isLogin: false,
  );

  final UserLoginAuthStatus status;
  final bool logedin;
  final bool isLogin;

  @override
  List<Object?> get props => [status, logedin, isLogin];

  UserLoginAuthState copyWith({
    UserLoginAuthStatus? status,
    bool? logedin,
    bool? isLogin,
  }) {
    return UserLoginAuthState(
      status: status ?? this.status,
      logedin: logedin ?? this.logedin,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
