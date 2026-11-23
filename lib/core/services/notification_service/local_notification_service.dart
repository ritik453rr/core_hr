import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../global/global.dart';

/// Manages local notifications and handles notification display and routing.
class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

  static Future<void> initializeLocalNotification() async {
    try {
      const androidInit = AndroidInitializationSettings('ic_notification');
      const iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const settings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _localNotificationPlugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (response) async {},
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      // Create Android notification channel.
      await _localNotificationPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_androidChannel);

      Global.printSuccessMsg('Local notification initialized successfully.');
    } catch (e, s) {
      Global.printErrorMsg(
        'Failed to initialize local notification: ${e.toString()}\n${s.toString()}',
      );
      rethrow;
    }
  }

  /// Returns a notification ID within the valid 32-bit integer range.
  static int _getNotificationId({
    String? notificationId,
    required RemoteMessage message,
  }) {
    final value = notificationId?.hashCode ?? message.hashCode;
    return value & 0x7FFFFFFF;
  }

  /// Displays a Firebase push message as a local notification.
  static Future<void> show(RemoteMessage message) async {
    final String? titleText = message.notification?.title;
    final String? bodyText = message.notification?.body;
    final notificationId = _getNotificationId(message: message);
    StyleInformation? bigTextStyleInfo;
    if ((bodyText != null && bodyText.isNotEmpty) &&
        titleText != null &&
        titleText.isNotEmpty) {
      bigTextStyleInfo = BigTextStyleInformation(
        bodyText,
        contentTitle: titleText,
        htmlFormatBigText: true,
        htmlFormatContentTitle: true,
      );
    }

    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'notifications',
      importance: Importance.max,
      icon: 'ic_notification',
      priority: Priority.high,
      playSound: true,
      styleInformation: bigTextStyleInfo,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBanner: true,
      presentList: true,
      presentBadge: true,
      presentSound: true,
    );
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    try {
      await _localNotificationPlugin.show(
        id: notificationId,
        title: titleText,
        body: bodyText,
        notificationDetails: notificationDetails,
      );
    } catch (e) {
      Global.printErrorMsg('Local notification error: ${e.toString()}');
    }
  }
}
