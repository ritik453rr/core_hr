class CheckInEntity {
  final double latitude;
  final double longitude;
  final String? address;
  final double? accuracy;

  const CheckInEntity({
    required this.latitude,
    required this.longitude,
    this.address,
    this.accuracy,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      if (address != null && address!.isNotEmpty) 'address': address,
      if (accuracy != null) 'accuracy': accuracy,
    };
  }
}
