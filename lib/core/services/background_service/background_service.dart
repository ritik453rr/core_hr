import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import '../../global/global.dart';

const String locationNotificationChannelId = 'location_tracking';
const int locationNotificationId = 888;

/// Initializes the background service.
Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    locationNotificationChannelId,
    'Location Tracking',
    description: 'Notification displayed while location tracking is active.',
    importance: Importance.low,
  );

  final notifications = FlutterLocalNotificationsPlugin();

  await notifications
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
      initialNotificationTitle: 'Location Tracking',
      initialNotificationContent: 'Preparing location tracking...',
      foregroundServiceNotificationId: locationNotificationId,
      foregroundServiceTypes: [AndroidForegroundType.location],
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
  StreamSubscription<Position>? positionSubscription;

  bool trackingRequested = false;

  /// Starts listening to location updates.
  Future<void> startLocationUpdates() async {
    if (positionSubscription != null) {
      debugPrint('Location tracking is already running.');
      return;
    }

    trackingRequested = true;

    print('📍 Starting location updates...');

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    try {
      // 1. Check whether location services are enabled.
      final bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return;
      }

      final subscription =
          Geolocator.getPositionStream(
            locationSettings: locationSettings,
          ).listen(
            (Position position) {
              onLocationUpdate(position);
            },
            onError: (Object error) {
              print('Location stream error: $error');
              positionSubscription = null;
            },
            onDone: () {
              print('Location stream closed.');
              positionSubscription = null;
            },
          );

      // The subscription may have been stopped while being initialized.
      if (!trackingRequested) {
        await subscription.cancel();
        return;
      }
      positionSubscription = subscription;
    } catch (error, stackTrace) {
      positionSubscription = null;
      print('❌ Failed to start location updates: $error');
      print(stackTrace);
    }
  }

  /// Stops the location stream without stopping the service.
  Future<void> stopLocationUpdates() async {
    trackingRequested = false;

    final subscription = positionSubscription;
    positionSubscription = null;

    await subscription?.cancel();

    print('🛑 Location tracking stopped.');
  }

  // Keep Android tracking in foreground mode.
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    service.setForegroundNotificationInfo(
      title: 'Location Tracking',
      content: 'Location tracking is active.',
    );
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

  print('✅ Background service initialized.');
}

Future<void> onLocationUpdate(Position position) async {
  try {
    print('📍 New location received');
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
    print('Accuracy: ${position.accuracy}');
    print('Timestamp: ${position.timestamp}');
  } catch (error, stackTrace) {
    print('❌ Failed to send location to Firestore: $error');
    print(stackTrace);
  }
}
