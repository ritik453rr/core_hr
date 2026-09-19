import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/core/services/location_service.dart';

enum HomeBuilderIds { home, clockIn, metrics }

/// Controller for managing home page state and consolidated attendance logic.
class HomeController extends GetxController {
  // Consolidated Attendance State
  bool isClockedIn = false;
  bool isLoadingLatLong = false;
  String currentLatLong = 'Unknown';

  @override
  void onInit() {
    super.onInit();
    getLatLang();
  }

  /// Fetches the current latitude and longitude.
  Future<void> getLatLang() async {
    isLoadingLatLong = true;
    update([HomeBuilderIds.clockIn]);
    try {
      final position = await LocationService.getCurrentPosition();
      if (position != null) {
        currentLatLong =
            'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
      }
    } catch (e) {
      AppToast.showToast(message: e.toString());
    } finally {
      isLoadingLatLong = false;
      update([HomeBuilderIds.clockIn]);
    }
  }

  void onTapProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  /// Toggles the clock-in status.
  void toggleClockIn() {
    isClockedIn = !isClockedIn;
    update([HomeBuilderIds.clockIn]);
    AppToast.showToast(
      message: isClockedIn ? 'Clocked in successfully!' : 'Clocked out successfully!',
      isSuccess: true,
    );
  }

  /// Handles tap on HR service modules.
  void onTapService(String serviceName) {
    AppToast.showToast(
      message: '$serviceName module integration coming soon.',
      isSuccess: true,
    );
  }
}
