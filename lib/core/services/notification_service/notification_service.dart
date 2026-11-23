import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../firebase_options.dart';
import '../../global/global.dart';
import 'local_notification_service.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    try {
      await LocalNotificationService.initializeLocalNotification();
      await _initHandlers();

      Global.printSuccessMsg('Notification service initialized successfully.');
    } catch (e, s) {
      Global.printErrorMsg(
        'Failed to initialize notification service: ${e.toString()}\n${s.toString()}',
      );
      rethrow;
    }
  }

  /// Requests permission to receive notification alerts, badges, and sounds.
  static Future<void> requestNotificationPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    Global.printInfoMsg(
      "Notification permission status: ${settings.authorizationStatus}",
    );
  }

  static Future<void> _initHandlers() async {
    /// Called when an FCM message is received while the app is in the foreground.
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    /// Registers the handler for FCM messages received while the app is in the background or terminated (subject to platform restrictions).
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    /// Called when the user taps an FCM notification while the app is in the background.
    FirebaseMessaging.onMessageOpenedApp.listen(_onTapMessage);

    /// Retrieves the FCM message that launched the app when the user tapped a notification while the app was terminated.
    final RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      Global.printInfoMsg('INITIAL NOTIFICATION RECEIVED');
      Global.printInfoMsg('INITIAL NOTIFICATION: ${initialMessage.toMap()}');
    }
  }

  static void _onForegroundMessage(RemoteMessage message) {
    Global.printInfoMsg('FOREGROUND NOTIFICATION RECEIVED');
    Global.printInfoMsg('FOREGROUND NOTIFICATION: ${message.toMap()}');
    if (message.data.isEmpty && message.notification == null) return;
    if (Platform.isAndroid) {
      LocalNotificationService.show(message);
    }
  }

  static void _onTapMessage(RemoteMessage message) {
    Global.printInfoMsg('BACKGROUND NOTIFICATION TAPPED');
    Global.printInfoMsg('BACKGROUND NOTIFICATION: ${message.toMap()}');
  }

  /// Gets the FCM token after the APNs token is available on iOS.
  static Future<String> getFcmToken() async {
    try {
      final String? token = await _firebaseMessaging.getToken();
      if (token == null || token.isEmpty) {
        Global.printErrorMsg('FCM token is null or empty');
        return '';
      }
      Global.printInfoMsg('FCM TOKEN: $token');
      return token;
    } catch (e, s) {
      Global.printErrorMsg(
        'Error getting FCM token :${e.toString()}\n${s.toString()}',
      );
      return '';
    }
  }
}

/// Handles Firebase background messages when the app is in the background or terminated
@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Global.printInfoMsg('BACKGROUND NOTIFICATION RECEIVED');
    Global.printInfoMsg('BACKGROUND NOTIFICATION: ${message.toMap()}');
  } catch (e, s) {
    Global.printErrorMsg(
      'Error handling background FCM message: ${e.toString()}\n${s.toString()}',
    );
  }
}
