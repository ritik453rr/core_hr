import 'package:permission_handler/permission_handler.dart';

class AppPermissionService {
  /// Checks whether permanent (Always) location permission is granted.
  static Future<bool> isPermanentLocationPermissionGranted() async {
    final status = await Permission.locationAlways.status;
    return status.isGranted;
  }
}
