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
    required this.loginStatus,
    required this.loginMessage,
    required this.isLogin,
    required this.secretKey,
    required this.deviceId,
  });

  static UserLoginAuthState initial() => UserLoginAuthState(
    status: UserLoginAuthStatus.initial,
    loginStatus: false,
    loginMessage: '',
    isLogin: false,
    secretKey: '',
    deviceId: '',
  );

  final UserLoginAuthStatus status;
  final bool loginStatus;
  final String loginMessage;
  final bool isLogin;
  final String secretKey;
  final String deviceId;

  @override
  List<Object?> get props => [
    status,
    loginStatus,
    loginMessage,
    isLogin,
    secretKey,
    deviceId,
  ];

  UserLoginAuthState copyWith({
    UserLoginAuthStatus? status,
    bool? loginStatus,
    String? loginMessage,
    bool? isLogin,
    String? secretKey,
    String? deviceId,
  }) {
    return UserLoginAuthState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      loginMessage: loginMessage ?? this.loginMessage,
      isLogin: isLogin ?? this.isLogin,
      secretKey: secretKey ?? this.secretKey,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
