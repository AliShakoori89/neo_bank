class OtpRequestAgainResultEntity {
  final bool success;
  final String message;
  final String secretKey;
  final String deviceId;

  OtpRequestAgainResultEntity({
    required this.success,
    required this.message,
    required this.secretKey,
    required this.deviceId,
  });
}
