class LoginResult {
  final bool success;
  final String message;
  final String secretKey;
  final String deviceId;
  final String expireTime;

  LoginResult({
    required this.success,
    required this.message,
    required this.secretKey,
    required this.deviceId,
    required this.expireTime,
  });
}
