import 'dart:async';
import 'package:core_hr/core/services/background_service/background_service_events.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../../feature/home/data/entity/location_update_entity.dart';
import '../../global/global.dart';
import '../app_permission_service/app_permission_service.dart';
import '../background_service/background_service.dart';

class LocationTrackingService {
  LocationTrackingService._();

  static final LocationTrackingService instance = LocationTrackingService._();

  final _backgroundService = FlutterBackgroundService();

  bool _starting = false;
  StreamSubscription<Position>? positionSubscription;
  bool trackingRequested = false;

  Future<void> startLocationTracking() async {
    if (_starting) {
      Global.logger.i('Location tracking is already starting.');
      return;
    }
    _starting = true;
    try {
      // 1. Check Always location permission.
      final bool hasPermission =
          await AppPermissionService.isPermanentLocationPermissionGranted();

      if (!hasPermission) {
        Global.printErrorMsg(
          'Unable to start location tracking: '
          '\nLocation permission is not granted.',
        );
        return;
      }

      // 2. Check whether the background service is running.
      final bool isRunning = await _backgroundService.isRunning();

      if (isRunning) {
        // Service is already running.
        _backgroundService.invoke(BackgroundServiceEvents.startLocationTracking);
        Global.printInfoMsg('Start tracking command sent.');
        return;
      }

      // 3. Listen for readiness BEFORE starting the service.
      final ready = Completer<void>();

      final subscription = _backgroundService.on(BackgroundServiceEvents.serviceReady).listen((
        event,
      ) {
        if (!ready.isCompleted) {
          ready.complete();
        }
      });

      try {
        // 4. Start the background service.
        final bool started = await startBackgroundService();

        if (!started) {
          Global.logger.e('Failed to start background service.');
          return;
        }

        // 5. Wait until background isolate is initialized.
        await ready.future.timeout(const Duration(seconds: 15));

        // 6. Send the tracking command.
        _backgroundService.invoke(
          BackgroundServiceEvents.startLocationTracking,
        );

        Global.logger.i('Location tracking started.');
      } on TimeoutException {
        Global.logger.e('Background service readiness timed out.');
      } finally {
        await subscription.cancel();
      }
    } catch (error) {
      Global.logger.e('Failed to start location tracking: $error');
    } finally {
      _starting = false;
    }
  }

  // Stops location tracking but keeps the background service running.
  Future<void> stopLocationTracking() async {
    try {
      if (!await _backgroundService.isRunning()) {
        Global.printInfoMsg('Background service is not running.');
        return;
      }
      _backgroundService.invoke(BackgroundServiceEvents.stopLocationTracking);
      Global.printInfoMsg('Stop tracking command sent.');
    } catch (error) {
      Global.printErrorMsg('Failed to stop location tracking: $error');
    }
  }

  /// Starts listening to location updates.
  Future<void> startLocationUpdates() async {
    if (positionSubscription != null) {
      Global.printInfoMsg('Location tracking is already running.');
      return;
    }
    trackingRequested = true;
    Global.printInfoMsg('Starting location updates...');

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
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 0,
            ),
          ).listen(
            (Position position) {
              onLocationUpdate(position);
            },
            onError: (Object error) {
              Global.printErrorMsg('Location stream error: $error');
              positionSubscription = null;
            },
            onDone: () {
              Global.printInfoMsg('Location stream closed.');
              positionSubscription = null;
            },
          );

      // The subscription may have been stopped while being initialized.
      if (!trackingRequested) {
        await subscription.cancel();
        return;
      }
      positionSubscription = subscription;
    } catch (error) {
      positionSubscription = null;
      Global.printErrorMsg('Failed to start location updates: $error');
    }
  }

  /// Stops the location stream without stopping the service.
  Future<void> stopLocationUpdates() async {
    trackingRequested = false;
    final subscription = positionSubscription;
    positionSubscription = null;
    await subscription?.cancel();
    Global.printInfoMsg('Location tracking stopped.');
  }

  Future<void> onLocationUpdate(Position position) async {
    try {
      final locationUpdateEntity = LocationUpdateEntity(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        recordedAt: _formatDateTime(position.timestamp),
      );

      Global.printInfoMsg(
        'New location received: ${locationUpdateEntity.toJson()}',
      );

      // final response = await HomeRepo().updateLocation(
      //   locationUpdateEntity: locationUpdateEntity,
      // );
      //
      // if (response.status) {
      //   Global.printSuccessMsg(
      //     'Background location posted successfully: ${response.message}',
      //   );
      // } else {
      //   Global.printErrorMsg(
      //     'Failed to post background location: ${response.message}',
      //   );
      // }
    } catch (error) {
      Global.logger.e('Failed to process location: $error');
    }
  }

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
}
