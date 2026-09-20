import 'package:get/get.dart';

enum DashboardBuilderIds { dashboard }

/// Controller for managing the main dashboard state, including navigation between tabs.
class DashboardController extends GetxController {
  // Variables
  int selectedNavIndex = 0;

  /// Changes the active navigation index and updates the UI.
  void changeNavIndex(int index) {
    selectedNavIndex = index;
    update([DashboardBuilderIds.dashboard]);
  }
}
