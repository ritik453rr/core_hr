import 'package:flutter_background_service/flutter_background_service.dart';

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
        Global.printInfo('Background service is already running.');
        return true;
      }
      final started = await _service.startService();

      if (started) {
        Global.printSuccessMsg('Background service started successfully.');
      } else {
        Global.printError('Failed to start background service.');
      }
      return started;
    } catch (error) {
      Global.printError('Error starting background service: $error');
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
        Global.printInfo('Background service is not running.');
        return;
      }
      sendEvent('stopService');
      Global.logger.i("Background service stopped");
    } catch (error) {
      Global.logger.e('Error stopping background service: $error');
    }
  }
}
