import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: androidInit, iOS: iosInit);
    await _localNotificationPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) async {
        // if (response.payload == null || response.payload!.isEmpty) {
        //   return;
        // }
        // try {
        //   final dynamic decoded = jsonDecode(response.payload!);
        //
        //   if (decoded is! Map<String, dynamic>) {
        //     return;
        //   }
        //   final Map<String, dynamic> data = decoded;
        //   if (data['type'] == NotificationType.downloadComplete) {
        //     final String? filePath = data['file_path']?.toString();
        //     debugPrint('Download notification tapped');
        //     debugPrint('Downloaded file path: $filePath');
        //     if (filePath != null && filePath.isNotEmpty) {
        //       await FileSaverService.openDownloadedFile(filePath);
        //     } else {
        //       debugPrint('File path missing from notification payload');
        //     }
        //     return;
        //   }
        //   final PushNotificationModel model = PushNotificationModel.fromJson(
        //     data,
        //   );
        //   NotificationRouter.redirect(model);
        // } catch (e, stackTrace) {
        //   debugPrint('Notification tap error: $e');
        //   debugPrintStack(stackTrace: stackTrace);
        // }
      },
    );
    // Explicitly request iOS local notification permissions.
    final iosPlugin = _localNotificationPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);
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
    '';
    // final data = {...message.data, 'title': titleText, 'description': bodyText};
    // final model = PushNotificationModel.fromJson(data);
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
      icon: '@mipmap/ic_launcher',
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
        // payload: jsonEncode(data),
      );
    } catch (e) {
      debugPrint('Local notification error: $e');
    }
  }
}
