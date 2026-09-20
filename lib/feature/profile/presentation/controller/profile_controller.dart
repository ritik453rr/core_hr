import 'package:get/get.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/dialogs/logout_dialog.dart';
import 'package:core_hr/core/storage/app_storage.dart';
import 'package:core_hr/feature/profile/data/repository/profile_repo.dart';

import '../../../../core/common_widgets/app_toast.dart';

/// Controller for managing user profile information and account actions.
class ProfileController extends GetxController {
  static const String profileId = 'profile';

  final profileRepo = ProfileRepo();

  // User status overview
  String employeeName = 'Alex Morgan';
  String employeeRole = 'Senior Field Specialist';
  String employeeId = 'EMP-2024-884';
  String department = 'Sales Operations';
  String profileImageUrl = StringConstants.kDefaultProfileImageUrl;

  String email = 'alex.morgan@corehr.com';
  String phone = '+1 (555) 019-2834';
  String joiningDate = 'March 15, 2021';
  String location = 'HQ - San Francisco, CA';
  String manager = 'Sarah Jenkins (Director of HR)';
  String workShift = 'General (09:00 AM - 06:00 PM)';

  String totalExperience = '3.5 Years';
  String leaveBalance = '14 Days';
  String activeLoan = '\$2,500';

  String get employeeInitials {
    final parts = employeeName.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return StringConstants.kDefaultAvatarInitials;
  }

  String get employeeSubtitle =>
      '$employeeRole${StringConstants.kBulletSeparator}$employeeId';

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
