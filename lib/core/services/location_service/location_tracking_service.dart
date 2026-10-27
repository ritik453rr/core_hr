import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../global/global.dart';

class LocationTrackingService {
  LocationTrackingService._();

  static final LocationTrackingService instance = LocationTrackingService._();

  final FlutterBackgroundService _backgroundService =
      FlutterBackgroundService();

  Future<void> startTracking() async {
    try {
      //  Check whether location services are enabled.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Global.logger.e('Location services are disabled.');
        return;
      }

      // Check current location permission.
      final LocationPermission permission = await Geolocator.checkPermission();

      // Require Always permission for background tracking.
      if (permission != LocationPermission.always) {
        Global.logger.e(
          'Always location permission is required. '
          'Current permission: $permission',
        );
        await Geolocator.openAppSettings();
        return;
      }

      final isRunning = await _backgroundService.isRunning();

      if (isRunning) {
        _backgroundService.invoke('startTracking');
        Global.logger.i('Start tracking command sent.');
        return;
      }

      // Listen for the readiness event BEFORE starting the service.
      final ready = Completer<void>();

      final subscription = _backgroundService.on('serviceReady').listen((
        event,
      ) {
        if (!ready.isCompleted) {
          ready.complete();
        }
      });

      try {
        debugPrint('Starting background service...');
        final started = await _backgroundService.startService();
        if (!started) {
          Global.logger.e('Failed to start the background service.');
          return;
        }
        // 5. Wait for the background isolate to register its listeners.
        await ready.future.timeout(const Duration(seconds: 15));
        // 6. Start location updates.
        _backgroundService.invoke('startTracking');

        print('✅ Location tracking started.');
      } on TimeoutException {
        Global.logger.e('Background service readiness timed out.');
      } finally {
        await subscription.cancel();
      }
    } catch (error, stackTrace) {
      Global.logger.e('Failed to start location tracking: $error');
      print(stackTrace);
    }
  }

  Future<void> stopTracking() async {
    try {
      final isRunning = await _backgroundService.isRunning();

      if (!isRunning) {
        print('Background service is not running.');
        return;
      }
      _backgroundService.invoke('stopTracking');
      print('🛑 Stop tracking command sent.');
    } catch (error) {
      Global.logger.e('Failed to stop location tracking: $error');
    }
  }
}
