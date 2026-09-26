import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../global/global.dart';

/// A service class for handling location-related operations.
class LocationService {
  static final _geocoding = Geocoding();

  /// Fetches the current position of the device, handling permissions and service status.
  static Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  /// Returns the placemark for the provided latitude and longitude.
  static Future<Placemark?> getPlacemark({
    required double latitude,
    required double longitude,
  }) async {
    try {
      if (!await Global.checkInternet(showMsg: false)) {
        return null;
      }

      final List<Placemark> placemarks = await _geocoding
          .placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        return null;
      }

      return placemarks.first;
    } catch (e) {
      return null;
    }
  }
}
