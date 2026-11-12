import 'dart:async';
import 'dart:ui';
import 'package:core_hr/core/services/location_service/location_tracking_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import '../../global/global.dart';

const String locationNotificationChannelId = 'location_tracking';
const int locationNotificationId = 888;



/// Initializes the background service.
Future<void> configuredBackgroundService() async {
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    locationNotificationChannelId,
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final localNotificationPlugin = FlutterLocalNotificationsPlugin();

  await localNotificationPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: locationServiceEntryPoint,
      autoStart: false,
      autoStartOnBoot: false,
      isForegroundMode: true,
      notificationChannelId: locationNotificationChannelId,
      initialNotificationTitle: 'Background Tracking',
      initialNotificationContent: 'Background tracking is running',
      foregroundServiceNotificationId: locationNotificationId,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: locationServiceEntryPoint,
      onBackground: iosBackgroundHandler,
    ),
  );
  Global.printSuccessMsg("background service configured");
}

/// iOS background-fetch handler.
/// This does not provide continuous location tracking.
@pragma('vm:entry-point')
Future<bool> iosBackgroundHandler(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

/// Background service entry point.
@pragma('vm:entry-point')
Future<void> locationServiceEntryPoint(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");






  // Keep Android tracking in foreground mode.
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  // Register listeners before announcing readiness.
  service.on('startTracking').listen((event) async {
    await LocationTrackingService.instance.startLocationUpdates();
  });

  service.on('stopTracking').listen((event) async {
    await LocationTrackingService.instance.stopLocationUpdates();
  });

  service.on('stopService').listen((event) async {
    await LocationTrackingService.instance.stopLocationUpdates();
    service.stopSelf();
  });
  // Tell the UI isolate that the service is ready to receive commands.
  service.invoke('serviceReady');
  Global.printSuccessMsg('Background service initialized.');
}


