import 'dart:async';
import '../../global/global.dart';
import '../app_permission_service/app_permission_service.dart';
import '../background_service/background_service.dart';

class LocationTrackingService {
  LocationTrackingService._();

  static final LocationTrackingService instance =
  LocationTrackingService._();

  final BackgroundServiceManager _backgroundService =
      BackgroundServiceManager.instance;

  bool _starting = false;

  Future<void> startLocationBgService() async {
    if (_starting) {
      Global.logger.i('Location tracking is already starting.');
      return;
    }

    _starting = true;

    try {
      // 1. Check Always location permission.
      final bool hasPermission =
      await AppPermissionService
          .isPermanentLocationPermissionGranted();

      if (!hasPermission) {
        Global.logger.e(
          'Unable to start location tracking: '
              'Always location permission is not granted.',
        );
        return;
      }

      // 2. Check whether the background service is running.
      final bool isRunning = await _backgroundService.isRunning();

      if (isRunning) {
        // Service is already running.
        _backgroundService.sendEvent('startTracking');

        Global.logger.i('Start tracking command sent.');
        return;
      }

      // 3. Listen for readiness BEFORE starting the service.
      final ready = Completer<void>();

      final subscription =
      _backgroundService.listen('serviceReady').listen((event) {
        if (!ready.isCompleted) {
          ready.complete();
        }
      });

      try {
        // 4. Start the background service.
        final bool started =
        await _backgroundService.startBackgroundService();

        if (!started) {
          Global.logger.e('Failed to start background service.');
          return;
        }

        // 5. Wait until background isolate is initialized.
        await ready.future.timeout(const Duration(seconds: 15));

        // 6. Send the tracking command.
        _backgroundService.sendEvent('startTracking');

        Global.logger.i('Location tracking started.');
      } on TimeoutException {
        Global.logger.e(
          'Background service readiness timed out.',
        );
      } finally {
        await subscription.cancel();
      }
    } catch (error) {
      Global.logger.e(
        'Failed to start location tracking: $error',
      );
    } finally {
      _starting = false;
    }
  }

  // Stops location tracking but keeps the background service running.
  Future<void> stopLocationTracking() async {
    try {
      if (!await _backgroundService.isRunning()) {
        Global.logger.i('Background service is not running.');
        return;
      }

      _backgroundService.sendEvent('stopTracking');

      Global.logger.i('Stop tracking command sent.');
    } catch (error) {
      Global.logger.e('Failed to stop location tracking: $error');
    }
  }

  // Stops the entire background service.
  Future<void> stopBackgroundService() async {
    await _backgroundService.stopBackgroundService();
  }
}