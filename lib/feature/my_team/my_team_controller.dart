import 'package:get/get.dart';

class TeamMember {
  final String name;
  final String role;
  final String attendanceStatus; // Present, Clocked Out, On Leave
  final String location;
  final String avatarUrl;

  TeamMember({
    required this.name,
    required this.role,
    required this.attendanceStatus,
    required this.location,
    required this.avatarUrl,
  });
}

class PendingApproval {
  final String id;
  final String employeeName;
  final String requestType; // Leave, Loan
  final String details;
  final String date;
  var status = 'Pending'.obs;

  PendingApproval({
    required this.id,
    required this.employeeName,
    required this.requestType,
    required this.details,
    required this.date,
  });
}

class MyTeamController extends GetxController {
  var teamMembers = <TeamMember>[
    TeamMember(
      name: 'Sarah Connor',
      role: 'Field Sales Lead',
      attendanceStatus: 'Present',
      location: 'Downtown Office, NY',
      avatarUrl: '',
    ),
    TeamMember(
      name: 'Michael Chang',
      role: 'Account Executive',
      attendanceStatus: 'Present',
      location: 'Client Site, Chicago',
      avatarUrl: '',
    ),
    TeamMember(
      name: 'Emily Watson',
      role: 'Senior Field Representative',
      attendanceStatus: 'On Leave',
      location: 'Annual Leave',
      avatarUrl: '',
    ),
    TeamMember(
      name: 'David Miller',
      role: 'Technical Specialist',
      attendanceStatus: 'Clocked Out',
      location: 'Home Office',
      avatarUrl: '',
    ),
  ].obs;

  var pendingApprovals = <PendingApproval>[
    PendingApproval(
      id: 'APP-101',
      employeeName: 'Emily Watson',
      requestType: 'Casual Leave',
      details: 'Aug 10 - Aug 12 (3 Days)',
      date: 'Aug 04, 2026',
    ),
    PendingApproval(
      id: 'APP-102',
      employeeName: 'Michael Chang',
      requestType: 'Personal Loan',
      details: 'Amount: ₹40,000 for 12 Months',
      date: 'Aug 03, 2026',
    ),
  ].obs;

  void approveRequest(PendingApproval req) {
    req.status.value = 'Approved';
    Get.snackbar('Approved', 'Request by ${req.employeeName} approved.', snackPosition: SnackPosition.TOP);
  }

  void rejectRequest(PendingApproval req) {
    req.status.value = 'Rejected';
    Get.snackbar('Rejected', 'Request by ${req.employeeName} rejected.', snackPosition: SnackPosition.TOP);
  }
}
