import 'package:core_hr/core/constants/shared_imports.dart';

class FieldStaffLocation {
  final String staffName;
  final String staffId;
  final String designation;
  final String currentArea;
  final String latLong;
  final String batteryLevel;
  final String lastPingTime;
  final String status; // Active, Idle, Off Duty

  FieldStaffLocation({
    required this.staffName,
    required this.staffId,
    required this.designation,
    required this.currentArea,
    required this.latLong,
    required this.batteryLevel,
    required this.lastPingTime,
    required this.status,
  });
}

class FieldTrackingController extends GetxController {
  static const String fieldTrackingId = 'field_tracking';

  String selectedFilter = 'All';

  List<FieldStaffLocation> fieldStaffList = <FieldStaffLocation>[
    FieldStaffLocation(
      staffName: 'Michael Chang',
      staffId: 'FLD-402',
      designation: 'Field Sales Rep',
      currentArea: 'Financial District, San Francisco',
      latLong: '37.7946° N, 122.3999° W',
      batteryLevel: '85%',
      lastPingTime: '2 mins ago',
      status: 'Active',
    ),
    FieldStaffLocation(
      staffName: 'Robert Vance',
      staffId: 'FLD-309',
      designation: 'Client Onboarding Lead',
      currentArea: 'SOMA Tech Center, SF',
      latLong: '37.7786° N, 122.4058° W',
      batteryLevel: '62%',
      lastPingTime: 'Just now',
      status: 'Active',
    ),
    FieldStaffLocation(
      staffName: 'Sarah Connor',
      staffId: 'FLD-110',
      designation: 'Field Operations Specialist',
      currentArea: 'Oakland Commerce Park',
      latLong: '37.8044° N, 122.2712° W',
      batteryLevel: '45%',
      lastPingTime: '15 mins ago',
      status: 'Idle',
    ),
    FieldStaffLocation(
      staffName: 'David Miller',
      staffId: 'FLD-205',
      designation: 'Technical Field Support',
      currentArea: 'Silicon Valley Hub, San Jose',
      latLong: '37.3382° N, 121.8863° W',
      batteryLevel: '92%',
      lastPingTime: '1 hour ago',
      status: 'Off Duty',
    ),
  ];

  List<FieldStaffLocation> get filteredStaff {
    if (selectedFilter == 'All') return fieldStaffList;
    return fieldStaffList.where((s) => s.status.toLowerCase() == selectedFilter.toLowerCase()).toList();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    update([fieldTrackingId]);
  }

  void refreshLocations() {
    AppToast.showToast(
      message: 'Pinging live field staff coordinates...',
      isSuccess: true,
    );
  }
}
