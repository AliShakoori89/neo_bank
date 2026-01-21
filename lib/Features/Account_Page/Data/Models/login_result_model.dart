class LoginResultModel {
  final bool success;
  final String message;
  final String secretKey;
  final String deviceId;

  LoginResultModel({
    required this.success,
    required this.message,
    required this.secretKey,
    required this.deviceId,
  });
}
