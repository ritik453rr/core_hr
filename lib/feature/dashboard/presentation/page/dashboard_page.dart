import 'package:core_hr/core/constants/shared_imports.dart';
import '../../../attendance/presentation/page/attendance_page.dart';
import '../../../field_tracking/presentation/page/field_tracking_page.dart';
import '../../../home/presentation/page/home_page.dart';
import '../../../my_team/presentation/page/my_team_page.dart';
import '../controller/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DashboardController>()) {
      Get.put(DashboardController());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: GetBuilder<DashboardController>(
        id: DashboardController.dashboardId,
        builder: (controller) => IndexedStack(
          index: controller.selectedNavIndex,
          children: const [
            HomePage(),
            AttendancePage(),
            FieldTrackingPage(),
            MyTeamPage(),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<DashboardController>(
        id: DashboardController.dashboardId,
        builder: (controller) => BottomNavigationBar(
          currentIndex: controller.selectedNavIndex,
          onTap: (index) => controller.changeNavIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF2563EB),
          unselectedItemColor: const Color(0xFF94A3B8),
          backgroundColor: Colors.white,
          elevation: 10,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: [
            _buildNavItem(icon: Icons.home_rounded, label: 'Home'),
            _buildNavItem(icon: Icons.access_time_filled, label: 'Attendance'),
            _buildNavItem(icon: Icons.map_rounded, label: 'Tracking'),
            _buildNavItem(icon: Icons.group_rounded, label: 'My Team'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    IconData? activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: activeIcon != null ? Icon(activeIcon) : null,
      label: label,
    );
  }
}
