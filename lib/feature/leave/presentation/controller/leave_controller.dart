import 'package:core_hr/core/constants/shared_imports.dart';

class LeaveRequest {
  final String leaveType;
  final String startDate;
  final String endDate;
  final int totalDays;
  final String reason;
  final String status;
  final String appliedOn;

  LeaveRequest({
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.reason,
    required this.status,
    required this.appliedOn,
  });
}

class LeaveController extends GetxController {
  static const String leaveId = 'leave';
  static const String applyLeaveFormId = 'apply_leave_form';

  // Leave balances
  int casualLeaveBalance = 6;
  int sickLeaveBalance = 4;
  int earnedLeaveBalance = 8;

  // Form controls
  String selectedLeaveType = 'Casual Leave';
  final reasonController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  List<LeaveRequest> leaveRequests = <LeaveRequest>[
    LeaveRequest(
      leaveType: 'Casual Leave',
      startDate: 'Aug 20, 2026',
      endDate: 'Aug 21, 2026',
      totalDays: 2,
      reason: 'Personal family occasion',
      status: 'Pending',
      appliedOn: 'Aug 04, 2026',
    ),
    LeaveRequest(
      leaveType: 'Sick Leave',
      startDate: 'Jul 12, 2026',
      endDate: 'Jul 12, 2026',
      totalDays: 1,
      reason: 'Fever and rest',
      status: 'Approved',
      appliedOn: 'Jul 11, 2026',
    ),
    LeaveRequest(
      leaveType: 'Earned Leave',
      startDate: 'Jun 01, 2026',
      endDate: 'Jun 05, 2026',
      totalDays: 5,
      reason: 'Annual summer vacation',
      status: 'Approved',
      appliedOn: 'May 20, 2026',
    ),
  ];

  void setLeaveType(String type) {
    selectedLeaveType = type;
    update([applyLeaveFormId]);
  }

  void setStartDate(DateTime date) {
    startDate = date;
    update([applyLeaveFormId]);
  }

  void setEndDate(DateTime date) {
    endDate = date;
    update([applyLeaveFormId]);
  }

  void submitLeaveApplication() {
    if (startDate == null || endDate == null) {
      AppToast.showToast(
        message: 'Please select start and end dates.',
        isSuccess: false,
      );
      return;
    }
    if (reasonController.text.trim().isEmpty) {
      AppToast.showToast(
        message: 'Please specify a reason for leave.',
        isSuccess: false,
      );
      return;
    }

    final days = endDate!.difference(startDate!).inDays + 1;
    if (days <= 0) {
      AppToast.showToast(
        message: 'End date must be on or after start date.',
        isSuccess: false,
      );
      return;
    }

    final newReq = LeaveRequest(
      leaveType: selectedLeaveType,
      startDate: "${startDate!.day}/${startDate!.month}/${startDate!.year}",
      endDate: "${endDate!.day}/${endDate!.month}/${endDate!.year}",
      totalDays: days,
      reason: reasonController.text.trim(),
      status: 'Pending',
      appliedOn: 'Aug 05, 2026',
    );

    leaveRequests.insert(0, newReq);
    reasonController.clear();
    startDate = null;
    endDate = null;

    update([leaveId, applyLeaveFormId]);
    Get.back();
    AppToast.showToast(
      message: 'Your leave request has been sent for manager approval.',
      isSuccess: true,
    );
  }
}
