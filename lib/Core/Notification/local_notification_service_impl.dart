import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'local_notification_service.dart';

@LazySingleton(as: LocalNotificationService)
class LocalNotificationServiceImpl implements LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
    );
  }

  @override
  Future<void> requestPermission() async {
    final androidImplementation =
    _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  @override
  Future<void> showOtpNotification({
    required String otp,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'otp_channel',
      'OTP',
      channelDescription: 'OTP notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      id: 1001,
      title: 'کد تأیید ورود',
      body: 'کد تأیید شما: $otp',
      notificationDetails: notificationDetails,
    );
  }
}