/// Represents the request payload for check-in and check-out API calls.
class AttendanceRequestEntity {
  final double latitude;
  final double longitude;
  final String address;
  final int accuracy;

  AttendanceRequestEntity({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.accuracy,
  });

  /// Converts the entity to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "accuracy": accuracy,
    };
  }
}
