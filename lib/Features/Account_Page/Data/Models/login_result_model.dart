class LoginResultModel {
  final bool success;
  final String message;
  final String secretKey;
  final String deviceId;
  final String expireTime;

  LoginResultModel({
    required this.success,
    required this.message,
    required this.secretKey,
    required this.deviceId,
    required this.expireTime,
  });
}
