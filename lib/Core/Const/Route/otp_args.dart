class OtpArgs {
  final String phoneNumber;
  final String nationalCode;
  final String deviceId;
  final String secretKey;

  const OtpArgs({
    required this.phoneNumber,
    required this.nationalCode,
    required this.deviceId,
    required this.secretKey,
  });
}
