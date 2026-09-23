abstract class LocalNotificationService {
  Future<void> initialize();

  Future<void> requestPermission();

  Future<void> showOtpNotification({
    required String otp,
  });
}