class LocationUpdateEntity {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String recordedAt;

  const LocationUpdateEntity({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.recordedAt,
  });

  factory LocationUpdateEntity.fromJson(Map<String, dynamic> json) {
    return LocationUpdateEntity(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      recordedAt: json['recorded_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'recorded_at': recordedAt,
    };
  }
}
