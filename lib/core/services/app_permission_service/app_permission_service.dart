import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../global/global.dart';

class AppPermissionService {
  /// Checks whether permanent (Always) location permission is granted.
  static Future<bool> isPermanentLocationPermissionGranted() async {
    try {
      //  Check whether location services are enabled.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Global.printErrorMsg('''device location is off''');
        return false;
      }

      final status = await Permission.locationAlways.status;
      if (!status.isGranted) {
        Global.printErrorMsg('''Always location permission is not granted''');
        return false;
      }

      return true;
    } catch (e, s) {
      Global.printErrorMsg(
        "Failed to check location Permission ${e.toString()}\n${s.toString()}",
      );
      return false;
    }
  }
}
