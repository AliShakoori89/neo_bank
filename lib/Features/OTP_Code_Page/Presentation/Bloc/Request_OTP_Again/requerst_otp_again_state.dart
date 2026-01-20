import 'package:equatable/equatable.dart';

enum RequerstOtpAgainStatus { initial, success, error, loading }

extension RequerstOtpAgainStatusX on RequerstOtpAgainStatus {
  bool get isInitial => this == RequerstOtpAgainStatus.initial;
  bool get isSuccess => this == RequerstOtpAgainStatus.success;
  bool get isError => this == RequerstOtpAgainStatus.error;
  bool get isLoading => this == RequerstOtpAgainStatus.loading;
}

class RequerstOtpAgainState extends Equatable {
  const RequerstOtpAgainState({
    required this.status,
    required this.loginStatus,
    required this.loginMessage,
    required this.isLogin,
    required this.secretKey,
    required this.deviceId,
  });

  static RequerstOtpAgainState initial() => RequerstOtpAgainState(
    status: RequerstOtpAgainStatus.initial,
    loginStatus: false,
    loginMessage: '',
    isLogin: false,
    secretKey: '',
    deviceId: '',
  );

  final RequerstOtpAgainStatus status;
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

  RequerstOtpAgainState copyWith({
    RequerstOtpAgainStatus? status,
    bool? loginStatus,
    String? loginMessage,
    bool? isLogin,
    String? secretKey,
    String? deviceId,
  }) {
    return RequerstOtpAgainState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      loginMessage: loginMessage ?? this.loginMessage,
      isLogin: isLogin ?? this.isLogin,
      secretKey: secretKey ?? this.secretKey,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
