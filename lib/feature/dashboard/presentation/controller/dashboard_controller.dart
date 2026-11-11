import 'package:core_hr/core/dialogs/location_permission_dialog.dart';
import 'package:core_hr/core/services/app_permission_service/app_permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/services/location_service/location_tracking_service.dart';

enum DashboardBuilderIds { dashboard }

/// Controller for managing the main dashboard state, including navigation between tabs.
class DashboardController extends GetxController with WidgetsBindingObserver {
  // Variables
  int selectedNavIndex = 0;

  @override
  void onInit() {
    checkLocationPermission();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkLocationPermission();
    }
  }

  Future<void> checkLocationPermission() async {
    final isPermission =
        await AppPermissionService.isPermanentLocationPermissionGranted();
    if (!isPermission) {
      showLocationPermissionDialog();
    } else {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  /// Changes the active navigation index and updates the UI.
  void changeNavIndex(int index) {
    selectedNavIndex = index;
    update([DashboardBuilderIds.dashboard]);
  }
}
