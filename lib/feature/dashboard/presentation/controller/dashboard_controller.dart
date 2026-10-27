import 'package:get/get.dart';

import '../../../../core/services/location_service/location_tracking_service.dart';

enum DashboardBuilderIds { dashboard }

/// Controller for managing the main dashboard state, including navigation between tabs.
class DashboardController extends GetxController {
  // Variables
  int selectedNavIndex = 0;

  @override
  void onInit() {
    // LocationTrackingService.instance.startTracking();
    LocationTrackingService.instance.stopTracking();
    super.onInit();
  }

  /// Changes the active navigation index and updates the UI.
  void changeNavIndex(int index) {
    selectedNavIndex = index;
    update([DashboardBuilderIds.dashboard]);
  }
}
