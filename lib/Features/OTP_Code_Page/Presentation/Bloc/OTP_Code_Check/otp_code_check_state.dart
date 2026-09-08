import 'package:equatable/equatable.dart';

enum OtpCodeCheckStatus { initial, success, error, loading }

extension OtpCodeCheckStatusX on OtpCodeCheckStatus {
  bool get isInitial => this == OtpCodeCheckStatus.initial;
  bool get isSuccess => this == OtpCodeCheckStatus.success;
  bool get isError => this == OtpCodeCheckStatus.error;
  bool get isLoading => this == OtpCodeCheckStatus.loading;
}

class OtpCodeCheckState extends Equatable {
  const OtpCodeCheckState({
    required this.status,
    required this.otpLoginStatus,
    required this.otpLoginMessage,
  });

  static OtpCodeCheckState initial() => OtpCodeCheckState(
    status: OtpCodeCheckStatus.initial,
    otpLoginStatus: false,
    otpLoginMessage: '',
  );

  final OtpCodeCheckStatus status;
  final bool otpLoginStatus;
  final String otpLoginMessage;

  @override
  List<Object?> get props => [status, otpLoginStatus, otpLoginMessage];

  OtpCodeCheckState copyWith({
    OtpCodeCheckStatus? status,
    bool? otpLoginStatus,
    String? otpLoginMessage,
  }) {
    return OtpCodeCheckState(
      status: status ?? this.status,
      otpLoginStatus: otpLoginStatus ?? this.otpLoginStatus,
      otpLoginMessage: otpLoginMessage ?? this.otpLoginMessage,
    );
  }
}
