import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routing/app_routes.dart';


class ProfileController extends GetxController {
  final name = 'Alex Morgan'.obs;
  final role = 'Senior HR Specialist'.obs;
  final empId = 'EMP-2024-884'.obs;
  final department = 'Human Resources & Talent'.obs;
  final email = 'alex.morgan@corehr.com'.obs;
  final phone = '+1 (555) 019-2834'.obs;
  final joiningDate = 'March 15, 2021'.obs;
  final location = 'HQ - San Francisco, CA'.obs;
  final manager = 'Sarah Jenkins (Director of HR)'.obs;
  final workShift = 'General (09:00 AM - 06:00 PM)'.obs;

  final totalExperience = '3.5 Years'.obs;
  final leaveBalance = '14 Days'.obs;
  final activeLoan = '\$2,500'.obs;

  void downloadIdCard() {
    Get.snackbar(
      'Digital ID Card',
      'Employee ID Card downloaded successfully to Downloads.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F172A),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.badge_rounded, color: Color(0xFF38BDF8)),
    );
  }

  void editProfileInfo() {
    Get.snackbar(
      'Edit Request',
      'Contact details edit request submitted to HR admin.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2563EB),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
    );
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to log out of your HR Book account?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Get.back();
              Get.offAllNamed(AppRoutes.login);
              Get.snackbar('Logged Out', 'You have logged out successfully.', snackPosition: SnackPosition.BOTTOM);

            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
