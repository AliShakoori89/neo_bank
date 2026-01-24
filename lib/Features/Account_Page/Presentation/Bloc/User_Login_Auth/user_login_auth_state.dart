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
    required this.expireTime,
  });

  static UserLoginAuthState initial() => UserLoginAuthState(
    status: UserLoginAuthStatus.initial,
    loginStatus: false,
    loginMessage: '',
    isLogin: false,
    secretKey: '',
    deviceId: '',
    expireTime: 0,
  );

  final UserLoginAuthStatus status;
  final bool loginStatus;
  final String loginMessage;
  final bool isLogin;
  final String secretKey;
  final String deviceId;
  final int expireTime;

  @override
  List<Object?> get props => [
    status,
    loginStatus,
    loginMessage,
    isLogin,
    secretKey,
    deviceId,
    expireTime,
  ];

  UserLoginAuthState copyWith({
    UserLoginAuthStatus? status,
    bool? loginStatus,
    String? loginMessage,
    bool? isLogin,
    String? secretKey,
    String? deviceId,
    int? expireTime,
  }) {
    return UserLoginAuthState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      loginMessage: loginMessage ?? this.loginMessage,
      isLogin: isLogin ?? this.isLogin,
      secretKey: secretKey ?? this.secretKey,
      deviceId: deviceId ?? this.deviceId,
      expireTime: expireTime ?? this.expireTime,
    );
  }
}
