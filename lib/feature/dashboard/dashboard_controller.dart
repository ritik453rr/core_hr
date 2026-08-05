import 'package:get/get.dart';
import '../../core/routing/app_routes.dart';

class DashboardController extends GetxController {
  var selectedNavIndex = 0.obs;
  
  // User status overview
  var employeeName = 'Alex Morgan'.obs;
  var employeeRole = 'Senior Field Specialist'.obs;
  var employeeId = 'EMP-2024-884'.obs;
  var department = 'Sales Operations'.obs;

  var isClockedIn = false.obs;
  var clockInTime = ''.obs;
  var clockOutTime = ''.obs;
  var liveLocation = 'San Francisco, CA (37.7749° N, 122.4194° W)'.obs;
  var activeHours = '00:00:00'.obs;

  // Quick stats
  var leaveBalance = 14.obs;
  var okrProgress = 78.obs;
  var pendingApprovals = 3.obs;
  var activeLeads = 12.obs;

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void toggleClockIn() {
    isClockedIn.value = !isClockedIn.value;
    final now = DateTime.now();
    final formattedTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    
    if (isClockedIn.value) {
      clockInTime.value = formattedTime;
      clockOutTime.value = '--:--';
      Get.snackbar('Clock-in Successful', 'Live location recorded: ${liveLocation.value}',
        snackPosition: SnackPosition.TOP);
    } else {
      clockOutTime.value = formattedTime;
      Get.snackbar('Clock-out Successful', 'Total work duration calculated.',
        snackPosition: SnackPosition.TOP);
    }
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout Confirmation',
      middleText: 'Are you sure you want to log out of HR Book?',
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: Get.theme.colorScheme.onError,
      buttonColor: Get.theme.colorScheme.error,
      onConfirm: () {
        Get.back();
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}
