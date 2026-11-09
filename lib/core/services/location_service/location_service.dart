import 'package:core_hr/core/services/app_permission_service/app_permission_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../global/global.dart';

/// A service class for handling location-related operations.
class LocationService {

  /// Fetches the current position of the device, handling permissions and service status.
  static Future<Position?> getCurrentPosition() async {
    final bool serviceEnabled =
        await AppPermissionService.isPermanentLocationPermissionGranted();

    if (!serviceEnabled) {
      Global.logger.e(
        "Unable to get current position:permanent location is not enabled",
      );
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }
}
