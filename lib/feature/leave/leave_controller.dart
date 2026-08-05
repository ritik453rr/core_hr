import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  // Leave balances
  var casualLeaveBalance = 6.obs;
  var sickLeaveBalance = 4.obs;
  var earnedLeaveBalance = 8.obs;

  // Form controls
  var selectedLeaveType = 'Casual Leave'.obs;
  final reasonController = TextEditingController();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  var leaveRequests = <LeaveRequest>[
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
  ].obs;

  void submitLeaveApplication() {
    if (startDate.value == null || endDate.value == null) {
      Get.snackbar('Missing Dates', 'Please select start and end dates.', snackPosition: SnackPosition.TOP);
      return;
    }
    if (reasonController.text.trim().isEmpty) {
      Get.snackbar('Missing Reason', 'Please specify a reason for leave.', snackPosition: SnackPosition.TOP);
      return;
    }

    final days = endDate.value!.difference(startDate.value!).inDays + 1;
    if (days <= 0) {
      Get.snackbar('Invalid Dates', 'End date must be on or after start date.', snackPosition: SnackPosition.TOP);
      return;
    }

    final newReq = LeaveRequest(
      leaveType: selectedLeaveType.value,
      startDate: "${startDate.value!.day}/${startDate.value!.month}/${startDate.value!.year}",
      endDate: "${endDate.value!.day}/${endDate.value!.month}/${endDate.value!.year}",
      totalDays: days,
      reason: reasonController.text.trim(),
      status: 'Pending',
      appliedOn: 'Aug 05, 2026',
    );

    leaveRequests.insert(0, newReq);
    reasonController.clear();
    startDate.value = null;
    endDate.value = null;

    Get.back();
    Get.snackbar('Application Submitted', 'Your leave request has been sent for manager approval.', snackPosition: SnackPosition.TOP);
  }
}
