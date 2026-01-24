String calculateExpireTime(String expireDateFromServer) {
  // تاریخ اکسپایر (UTC)
  final expireDate = DateTime.parse(expireDateFromServer);

  // زمان الان (UTC)
  final now = DateTime.now().toUtc();

  // اختلاف به ثانیه
  final diffInSeconds = expireDate.difference(now).inSeconds;

  print(diffInSeconds);

  return diffInSeconds.toString();
}
