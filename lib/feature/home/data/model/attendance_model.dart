/// Represents an attendance record received from the API.
class AttendanceModel {
  final int id;
  final String date;
  final String? clockIn;
  final String? clockOut;
  final String? location;
  final String status;
  final String? duration;

  AttendanceModel({
    required this.id,
    required this.date,
    this.clockIn,
    this.clockOut,
    this.location,
    required this.status,
    this.duration,
  });

  /// Factory method to create an [AttendanceModel] from a JSON map.
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? "",
      clockIn: json['check_in_time'],
      clockOut: json['check_out_time'],
      location: json['check_in_location'] ?? json['check_out_location'],
      status: json['status'] ?? "present",
      duration: json['duration'],
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'check_in_time': clockIn,
      'check_out_time': clockOut,
      'check_in_location': location,
      'status': status,
      'duration': duration,
    };
  }
}
