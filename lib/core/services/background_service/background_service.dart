import 'dart:async';
import 'dart:ui';
import 'package:core_hr/core/services/background_service/background_service_events.dart';
import 'package:core_hr/core/services/background_service/background_service_manager.dart';
import 'package:core_hr/core/services/location_service/location_service_events.dart';
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
  try {
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

    final bool configured = await BackgroundServiceManager.backgroundService
        .configure(
          androidConfiguration: AndroidConfiguration(
            onStart: locationServiceEntryPoint,
            autoStart: false,
            autoStartOnBoot: false,
            isForegroundMode: true,
            notificationChannelId: locationNotificationChannelId,
            initialNotificationTitle: 'Background Tracking',
            initialNotificationContent: 'Background tracking is running',
            foregroundServiceNotificationId: locationNotificationId,
            foregroundServiceTypes: [AndroidForegroundType.location],
          ),
          iosConfiguration: IosConfiguration(
            autoStart: false,
            onForeground: locationServiceEntryPoint,
            onBackground: iosBackgroundHandler,
          ),
        );

    if (configured) {
      Global.printSuccessMsg('Background service configured successfully.');
    } else {
      Global.printErrorMsg('Background service configuration failed.');
    }
  } catch (error) {
    Global.printErrorMsg('Error configuring background service: $error');
  }
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
  try {
    // Initialize background dependencies.
    await GetStorage.init();
    await dotenv.load(fileName: '.env');

    // Enable Android foreground service.
    if (service is AndroidServiceInstance) {
      await service.setAsForegroundService();
    }

    // Start location tracking.
    service.on(LocationServiceEvents.startTracking).listen((event) async {
      try {
        await LocationTrackingService.instance.startLocationUpdates();
      } catch (error) {
        Global.printErrorMsg('Failed to start location tracking:$error');
      }
    });

    // Stop location tracking.
    service.on(LocationServiceEvents.stopTracking).listen((event) async {
      try {
        await LocationTrackingService.instance.stopLocationUpdates();
      } catch (error) {
        Global.printErrorMsg('Failed to stop location tracking: $error');
      }
    });

    // Stop the entire background service.
    service.on(BackgroundServiceEvents.stopService).listen((event) async {
      try {
        await LocationTrackingService.instance.stopLocationUpdates();
      } catch (error) {
        Global.printErrorMsg('Failed to stop location updates:$error');
      } finally {
        service.invoke(BackgroundServiceEvents.serviceStopped);
        await service.stopSelf();
      }
    });

    // Notify UI isolate that initialization is complete.
    service.invoke(BackgroundServiceEvents.serviceReady);
    Global.printSuccessMsg('Background service started successfully.');
  } catch (error, stackTrace) {
    Global.printErrorMsg('''Background service initialization failed: $error\n
      stackTrace: $stackTrace,''');
    service.invoke(BackgroundServiceEvents.serviceInitializationFailed, {
      'message': error.toString(),
    });
    await service.stopSelf();
  }
}
