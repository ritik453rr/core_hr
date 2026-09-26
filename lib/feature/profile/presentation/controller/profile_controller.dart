import 'package:core_hr/core/app_enums/app_enums.dart';
import 'package:core_hr/feature/home/presentation/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/common_model/user_profile_model.dart';
import 'package:core_hr/core/dialogs/logout_dialog.dart';
import 'package:core_hr/core/storage/app_storage.dart';
import '../../../../core/common_widgets/app_toast.dart';
import '../../../auth/data/repository/auth_repo.dart';

enum ProfileBuilderIds { profilePage, loadingOverlay }

/// Controller for managing user profile information and account actions.
class ProfileController extends GetxController {
  // Instances
  final authRepo = AuthRepo();

  // Variables
  bool isLoadingProfile = false;
  var showLoadingOverlay = false;
  UserProfileData? userProfileData;

  @override
  void onInit() {
    super.onInit();
    getLocalStorageProfile();
    getUserProfile();
  }

  /// Loads user profile from local storage and updates UI state.
  void getLocalStorageProfile() {
    userProfileData = AppStorage.getUserProfile();
  }

  /// Fetches user profile from API and updates UI state.
  Future<void> getUserProfile() async {
    isLoadingProfile = true;
    update([ProfileBuilderIds.profilePage]);

    final ResponseModel resModel = await authRepo.getUserProfile();
    if (resModel.status) {
      final UserProfileModel userProfileModel = resModel.data;
      if (userProfileModel.userProfileData != null) {
        userProfileData = userProfileModel.userProfileData;
        final homeController = Get.find<HomeController>();
        final status = userProfileData?.status?.toLowerCase();
        homeController.isCheckIn = status == ShiftStatus.active.name;
        AppStorage.saveUserProfile(userProfileData);
      }
    } else {
      AppToast.showToast(message: resModel.message);
    }
    isLoadingProfile = false;
    update([ProfileBuilderIds.profilePage]);
    update([HomeBuilderIds.clockInCard]);
    update([HomeBuilderIds.homeAppBar]);
  }

  /// Displays the logout confirmation dialog.
  void onTapLogout() {
    showLogoutDialog(onConfirm: logout);
  }

  /// Handles the logout process when confirmed by the user.
  Future<void> logout() async {
    showLoadingOverlay = true;
    update([ProfileBuilderIds.loadingOverlay]);
    final resModel = await authRepo.logout();
    if (resModel.status) {
      AppStorage.logOut();
    } else {
      AppToast.showToast(message: resModel.message);
    }
    showLoadingOverlay = false;
    update([ProfileBuilderIds.loadingOverlay]);
  }

  void downloadIdCard() {
    AppToast.showToast(message: 'This service is currently not available.');
  }

  void editProfileInfo() {
    AppToast.showToast(message: 'This service is currently not available.');
  }
}
