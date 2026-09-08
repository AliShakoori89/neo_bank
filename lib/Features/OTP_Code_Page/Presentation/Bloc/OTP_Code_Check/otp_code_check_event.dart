abstract class OtpCodeCheckEvent {
  List<Object> get props => [];
}

class OtpCodeCheckValueEvent extends OtpCodeCheckEvent {
  final String otpCode;
  final String secretKey;
  final String deviceId;

  OtpCodeCheckValueEvent({
    required this.otpCode,
    required this.secretKey,
    required this.deviceId,
  });

  @override
  List<Object> get props => [otpCode, secretKey, deviceId];
}
