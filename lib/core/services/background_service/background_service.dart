import 'dart:async';
import 'dart:ui';
import 'package:core_hr/core/services/app_permission_service/app_permission_service.dart';
import 'package:core_hr/feature/home/data/entity/location_update_entity.dart';
import 'package:core_hr/feature/home/data/repository/home_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import '../../global/global.dart';

class BackgroundServiceManager {
  BackgroundServiceManager._();

  static final BackgroundServiceManager instance = BackgroundServiceManager._();

  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<bool> isRunning() {
    return _service.isRunning();
  }


  // Start background service
  Future<bool> startBackgroundService() async {
    try {
      if (await isRunning()) {
        Global.logger.i('Background service is already running.');
        return true;
      }
      final started = await _service.startService();

      if (started) {
        Global.logger.i('Background service started successfully.');
      } else {
        Global.logger.e('Failed to start background service.');
      }
      return started;
    } catch (error) {
      Global.logger.e('Error starting background service: $error');
      return false;
    }
  }

  void sendEvent(String event) {
    _service.invoke(event);
  }

  Stream<Map<String, dynamic>?> listen(String event) {
    return _service.on(event);
  }


  // Stop background service
  Future<void> stopBackgroundService() async {
    try {
      if (!await isRunning()) {
        Global.logger.i('Background service is not running.');
        return;
      }
      sendEvent('stopService');
      Global.logger.i("Background service stopped");
    } catch (error) {
      Global.logger.e('Error stopping background service: $error');
    }
  }
}

const String locationNotificationChannelId = 'location_tracking';
const int locationNotificationId = 888;

/// Formats DateTime to "YYYY-MM-DD HH:mm:ss" string format.
String _formatDateTime(DateTime dateTime) {
  final year = dateTime.year.toString().padLeft(4, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final second = dateTime.second.toString().padLeft(2, '0');
  return '$year-$month-$day $hour:$minute:$second';
}

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

  Global.logger.i("background service configured");
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
  try {
    if (!dotenv.isInitialized) {
      await dotenv.load(fileName: ".env");
    }
  } catch (_) {}

  StreamSubscription<Position>? positionSubscription;
  Timer? apiTimer;
  DateTime? lastApiCallTime;
  Position? latestPosition;
  bool trackingRequested = false;

  void triggerLocationApiCall(Position position) {
    lastApiCallTime = DateTime.now();
    onLocationUpdate(position);
  }

  /// Starts listening to location updates.
  Future<void> startLocationUpdates() async {
    if (positionSubscription != null) {
      Global.logger.i('Location tracking is already running.');
      return;
    }
    trackingRequested = true;
    Global.logger.i('Starting location updates...');

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    try {
      final bool isPermanentLocationEnable =
          await AppPermissionService.isPermanentLocationPermissionGranted();

      if (!isPermanentLocationEnable) {
        Global.logger.e(
          'Unable to start location tracking.\n Permanent location disabled',
        );
        return;
      }

      final subscription =
          Geolocator.getPositionStream(
            locationSettings: locationSettings,
          ).listen(
            (Position position) {
              latestPosition = position;
              final now = DateTime.now();
              if (lastApiCallTime == null ||
                  now.difference(lastApiCallTime!) >=
                      const Duration(minutes: 1)) {
                triggerLocationApiCall(position);
              }
            },
            onError: (Object error) {
              Global.logger.e('Location stream error: $error');
              positionSubscription = null;
            },
            onDone: () {
              Global.logger.e('Location stream closed.');
              positionSubscription = null;
            },
          );

      // Periodic timer to ensure API is called every 1 minute if a location is available
      apiTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
        final pos = latestPosition;
        if (pos != null) {
          final now = DateTime.now();
          if (lastApiCallTime == null ||
              now.difference(lastApiCallTime!) >= const Duration(minutes: 1)) {
            triggerLocationApiCall(pos);
          }
        }
      });

      // The subscription may have been stopped while being initialized.
      if (!trackingRequested) {
        await subscription.cancel();
        apiTimer?.cancel();
        apiTimer = null;
        return;
      }
      positionSubscription = subscription;
    } catch (error) {
      positionSubscription = null;
      apiTimer?.cancel();
      apiTimer = null;
      Global.logger.e('Failed to start location updates: $error');
    }
  }

  /// Stops the location stream without stopping the service.
  Future<void> stopLocationUpdates() async {
    trackingRequested = false;
    apiTimer?.cancel();
    apiTimer = null;
    lastApiCallTime = null;
    latestPosition = null;
    final subscription = positionSubscription;
    positionSubscription = null;
    await subscription?.cancel();
    Global.logger.i('Location tracking stopped.');
  }

  // Keep Android tracking in foreground mode.
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    // service.setForegroundNotificationInfo(
    //   title: 'Location Tracking',
    //   content: 'Location tracking is active.',
    // );
  }

  // Register listeners before announcing readiness.
  service.on('startTracking').listen((event) async {
    await startLocationUpdates();
  });

  service.on('stopTracking').listen((event) async {
    await stopLocationUpdates();
  });

  service.on('stopService').listen((event) async {
    await stopLocationUpdates();
    service.stopSelf();
  });

  // Tell the UI isolate that the service is ready to receive commands.
  service.invoke('serviceReady');
  debugPrint('Background service initialized.');
}

Future<void> onLocationUpdate(Position position) async {
  try {
    debugPrint(
      'New location received: ${position.latitude}, ${position.longitude}',
    );

    final locationUpdateEntity = LocationUpdateEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      recordedAt: _formatDateTime(position.timestamp),
    );

    final response = await HomeRepo().updateLocation(
      locationUpdateEntity: locationUpdateEntity,
    );

    if (response.status) {
      Global.logger.i(
        'Background location posted successfully: ${response.message}',
      );
    } else {
      Global.logger.e(
        'Failed to post background location: ${response.message}',
      );
    }
  } catch (error) {
    Global.logger.e('Failed to process location: $error');
  }
}
