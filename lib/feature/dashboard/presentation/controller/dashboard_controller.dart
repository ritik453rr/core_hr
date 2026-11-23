import 'package:core_hr/core/dialogs/location_permission_dialog.dart';
import 'package:core_hr/core/services/app_permission_service/app_permission_service.dart';
import 'package:core_hr/core/services/notification_service/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum DashboardBuilderIds { dashboard }

/// Controller for managing the main dashboard state, including navigation between tabs.
class DashboardController extends GetxController with WidgetsBindingObserver {
  // Variables
  int selectedNavIndex = 0;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    requestPermissions();
    getFcmToken();
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkLocationPermission();
    }
  }

  Future<void> requestPermissions() async {
    await checkLocationPermission();
    await NotificationService.requestNotificationPermission();
  }

  Future<void> checkLocationPermission() async {
    final isPermission =
        await AppPermissionService.isPermanentLocationPermissionGranted();
    if (!isPermission) {
      if (Get.isDialogOpen == false) {
        showLocationPermissionDialog();
      }
    } else {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  void getFcmToken() {
    NotificationService.getFcmToken();
  }

  /// Changes the active navigation index and updates the UI.
  void changeNavIndex(int index) {
    selectedNavIndex = index;
    update([DashboardBuilderIds.dashboard]);
  }
}
