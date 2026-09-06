import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/core/storage/app_storage.dart';
import 'package:core_hr/feature/profile/data/repository/profile_repo.dart';

class ProfileController extends GetxController {
  static const String profileId = 'profile';

  final profileRepo = ProfileRepo();

  final name = 'Alex Morgan';
  final role = 'Senior HR Specialist';
  final empId = 'EMP-2024-884';
  final department = 'Human Resources & Talent';
  final email = 'alex.morgan@corehr.com';
  final phone = '+1 (555) 019-2834';
  final joiningDate = 'March 15, 2021';
  final location = 'HQ - San Francisco, CA';
  final manager = 'Sarah Jenkins (Director of HR)';
  final workShift = 'General (09:00 AM - 06:00 PM)';

  final totalExperience = '3.5 Years';
  final leaveBalance = '14 Days';
  final activeLoan = '\$2,500';

  void downloadIdCard() {
    AppToast.showToast(
      message: 'Employee ID Card downloaded successfully to Downloads.',
      isSuccess: true,
    );
  }

  void editProfileInfo() {
    AppToast.showToast(
      message: 'Contact details edit request submitted to HR admin.',
      isSuccess: true,
    );
  }

  void logout() {
    LogoutDialog.show(
      onConfirm: onConfirmLogout,
    );
  }

  Future<void> onConfirmLogout() async {
    Get.back();
    final resModel = await profileRepo.logoutRequest();
    if (resModel.status) {
      AppStorage.logOut();
    } else {
      AppToast.showToast(message: resModel.message);
    }
  }
}
