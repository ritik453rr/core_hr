import 'package:core_hr/core/services/background_service/background_service_events.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../global/global.dart';

class BackgroundServiceManager {
  BackgroundServiceManager._();

  static final BackgroundServiceManager instance = BackgroundServiceManager._();

  static final FlutterBackgroundService backgroundService =
      FlutterBackgroundService();

  Future<bool> isRunning() {
    return backgroundService.isRunning();
  }

  // Start background service
  Future<bool> startBackgroundService() async {
    try {
      if (await isRunning()) {
        Global.printInfoMsg('Background service is already running.');
        return true;
      }
      final started = await backgroundService.startService();

      if (started) {
        Global.printSuccessMsg('Background service started successfully.');
      } else {
        Global.printErrorMsg('Failed to start background service.');
      }
      return started;
    } catch (error) {
      Global.printErrorMsg('Error starting background service: $error');
      return false;
    }
  }

  void sendEvent(String event) {
    try {
      backgroundService.invoke(event);
    } catch (error) {
      Global.printErrorMsg('Failed to send background service event: $event');
    }
  }

  Stream<Map<String, dynamic>?> listen(String event) {
    return backgroundService.on(event);
  }

  // Stop background service
  Future<void> stopBackgroundService() async {
    try {
      if (!await isRunning()) {
        Global.printInfoMsg('Background service is not running.');
        return;
      }
      sendEvent(BackgroundServiceEvents.stopService);
      Global.printInfoMsg("Background service stopped");
    } catch (error) {
      Global.printErrorMsg('Error stopping background service: $error');
    }
  }
}
