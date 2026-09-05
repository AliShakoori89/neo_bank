import 'package:equatable/equatable.dart';

enum RequestOtpAgainStatus { initial, success, error, loading }

extension RequerstOtpAgainStatusX on RequestOtpAgainStatus {
  bool get isInitial => this == RequestOtpAgainStatus.initial;
  bool get isSuccess => this == RequestOtpAgainStatus.success;
  bool get isError => this == RequestOtpAgainStatus.error;
  bool get isLoading => this == RequestOtpAgainStatus.loading;
}

class RequestOtpAgainState extends Equatable {
  const RequestOtpAgainState({
    required this.status,
    required this.loginStatus,
    required this.loginMessage,
    required this.isLogin,
    required this.secretKey,
    required this.deviceId,
  });

  static RequestOtpAgainState initial() => RequestOtpAgainState(
    status: RequestOtpAgainStatus.initial,
    loginStatus: false,
    loginMessage: '',
    isLogin: false,
    secretKey: '',
    deviceId: '',
  );

  final RequestOtpAgainStatus status;
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

  RequestOtpAgainState copyWith({
    RequestOtpAgainStatus? status,
    bool? loginStatus,
    String? loginMessage,
    bool? isLogin,
    String? secretKey,
    String? deviceId,
  }) {
    return RequestOtpAgainState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      loginMessage: loginMessage ?? this.loginMessage,
      isLogin: isLogin ?? this.isLogin,
      secretKey: secretKey ?? this.secretKey,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
