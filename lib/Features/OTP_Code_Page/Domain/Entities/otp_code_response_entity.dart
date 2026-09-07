class OtpCodeResponseEntity {
  final String? token;
  final DateTime? expireAt;
  final String? displayName;
  final String? mobileNumber;

  OtpCodeResponseEntity({this.token, this.expireAt, this.displayName, this.mobileNumber});
}