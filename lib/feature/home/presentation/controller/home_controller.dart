import 'package:core_hr/core/constants/shared_imports.dart';

enum HomeBuilderIds {
  home,
  userProfile,
  clockIn,
  metrics,
}

class HomeController extends GetxController {
  // User status overview
  String employeeName = 'Alex Morgan';
  String employeeRole = 'Senior Field Specialist';
  String employeeId = 'EMP-2024-884';
  String department = 'Sales Operations';
  String profileImageUrl = StringConstants.kDefaultProfileImageUrl;

  String get employeeInitials {
    final parts = employeeName.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return StringConstants.kDefaultAvatarInitials;
  }

  String get employeeSubtitle =>
      '$employeeRole${StringConstants.kBulletSeparator}$employeeId';

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

  void toggleClockIn() {
    isClockedIn = !isClockedIn;
    final now = DateTime.now();
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    if (isClockedIn) {
      clockInTime = formattedTime;
      clockOutTime = '--:--';
      AppToast.showToast(
        message: '${StringConstants.kLiveLocationRecorded}$liveLocation',
        isSuccess: true,
      );
    } else {
      clockOutTime = formattedTime;
      AppToast.showToast(
        message: StringConstants.kWorkDurationCalculated,
        isSuccess: true,
      );
    }
    update([HomeBuilderIds.home, HomeBuilderIds.clockIn]);
  }

  void onTapProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  void onTapNotifications() {
    AppToast.showToast(
      message: StringConstants.kNoNewAnnouncements,
      isSuccess: true,
    );
  }
}
