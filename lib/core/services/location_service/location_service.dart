import 'package:core_hr/core/services/app_permission_service/app_permission_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../global/global.dart';

/// A service class for handling location-related operations.
class LocationService {
  /// Fetches the current position of the device, handling permissions and service status.
  static Future<Position?> getCurrentPosition() async {
    try {
      final bool permissionStatus =
          await AppPermissionService.isPermanentLocationPermissionGranted();

      if (!permissionStatus) {
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      Global.printError(e.toString());
      return null;
    }
  }
}
