import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/language/string_constants.dart';
import '../../../home/presentation/page/home_page.dart';
import '../../../profile/presentation/page/profile_page.dart';
import '../controller/dashboard_controller.dart';

/// Main dashboard page that hosts the bottom navigation and top-level feature screens.
class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
        id: DashboardBuilderIds.dashboard,
        builder: (controller) => IndexedStack(
          index: controller.selectedNavIndex,
          children: const [
            HomePage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<DashboardController>(
        id: DashboardBuilderIds.dashboard,
        builder: (controller) => BottomNavigationBar(
          currentIndex: controller.selectedNavIndex,
          onTap: (index) => controller.changeNavIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.c2563EB,
          unselectedItemColor: AppColors.c94A3B8,
          backgroundColor: Colors.white,
          elevation: 10,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: [
            _buildNavItem(
              icon: Icons.home_rounded,
              label: StringConstants.kHome,
            ),
            _buildNavItem(
              icon: Icons.person_rounded,
              label: StringConstants.kMyProfile,
            ),
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
