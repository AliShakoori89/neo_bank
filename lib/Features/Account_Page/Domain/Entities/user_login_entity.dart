class UserLoginEntity {
  final String? code;
  final String? secretKey;
  final String? deviceId;
  final DateTime? expireTime;

  UserLoginEntity({this.code, this.secretKey, this.deviceId, this.expireTime});
}