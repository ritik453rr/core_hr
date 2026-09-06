import 'package:core_hr/core/constants/shared_imports.dart';

class DashboardController extends GetxController {
  int selectedNavIndex = 0;

  // User status overview
  String employeeName = 'Alex Morgan';
  String employeeRole = 'Senior Field Specialist';
  String employeeId = 'EMP-2024-884';
  String department = 'Sales Operations';

  bool isClockedIn = false;
  String clockInTime = '';
  String clockOutTime = '';
  String liveLocation = 'San Francisco, CA (37.7749° N, 122.4194° W)';
  String activeHours = '00:00:00';

  // Quick stats
  int leaveBalance = 14;
  int okrProgress = 78;
  int pendingApprovals = 3;
  int activeLeads = 12;

  static const String dashboardId = 'dashboard';

  void changeNavIndex(int index) {
    selectedNavIndex = index;
    update([dashboardId]);
  }

  void toggleClockIn() {
    isClockedIn = !isClockedIn;
    final now = DateTime.now();
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    if (isClockedIn) {
      clockInTime = formattedTime;
      clockOutTime = '--:--';
      AppToast.showToast(
        message: 'Live location recorded: $liveLocation',
        isSuccess: true,
      );
    } else {
      clockOutTime = formattedTime;
      AppToast.showToast(
        message: 'Total work duration calculated.',
        isSuccess: true,
      );
    }
    update([dashboardId]);
  }
}
