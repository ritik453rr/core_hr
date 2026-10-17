import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core_hr/core/app_enums/app_enums.dart';
import 'package:core_hr/core/bottomsheets/avatar_picker_bottom_sheet.dart';
import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/common_model/user_profile_model.dart';
import 'package:core_hr/core/dialogs/logout_dialog.dart';
import 'package:core_hr/core/services/media_service/media_service.dart';
import 'package:core_hr/core/storage/app_storage.dart';
import 'package:core_hr/feature/home/presentation/controller/home_controller.dart';
import '../../../../core/common_widgets/app_toast.dart';
import '../../../auth/data/repository/auth_repo.dart';
import '../../data/entity/update_profile_entity.dart';
import '../../data/repository/profile_repo.dart';

enum ProfileBuilderIds {
  profilePage,
  loadingOverlay,
  editProfileAvatar,
  updateLoadingOverlay,
}

/// Controller for managing user profile information, edit profile actions, and account settings.
class ProfileController extends GetxController {
  // Repositories & Services
  final authRepo = AuthRepo();
  final profileRepo = ProfileRepo();
  final _mediaService = MediaService();

  // Profile View State
  bool isLoadingProfile = false;
  var showLoadingOverlay = false;
  UserProfileData? userProfileData;

  // Edit Profile State
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final editProfileFormKey = GlobalKey<FormState>();

  var selectedImage = Rx<File?>(null);
  bool isUpdateLoading = false;

  @override
  void onInit() {
    super.onInit();
    getLocalStorageProfile();
    getUserProfile();
  }

  /// Loads user profile from local storage and updates UI state.
  void getLocalStorageProfile() {
    userProfileData = AppStorage.getUserProfile();
    prefillEditProfilePage();
  }

  /// Prefills edit profile text fields with user profile data.
  void prefillEditProfilePage() {
    final user = userProfileData ?? AppStorage.getUserProfile();
    if (user != null) {
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phone ?? '';
    }
    selectedImage.value = null;
    update([ProfileBuilderIds.editProfileAvatar]);
  }

  /// Fetches user profile from API and updates UI state.
  Future<void> getUserProfile() async {
    isLoadingProfile = true;
    update([ProfileBuilderIds.profilePage]);

    final ApiResponseModel resModel = await authRepo.getUserProfile();
    if (resModel.status) {
      final UserProfileModel userProfileModel = resModel.data;
      if (userProfileModel.userProfileData != null) {
        userProfileData = userProfileModel.userProfileData;
        prefillEditProfilePage();
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
    final homeController = Get.find<HomeController>();
    homeController.update([HomeBuilderIds.clockInCard]);
    homeController.update([HomeBuilderIds.homeAppBar]);
  }

  /// Opens bottom sheet for selecting profile image.
  void onTapAvatarPicker(BuildContext context) {
    showAvatarPickerBottomSheet(context: context, onSourceSelected: pickImage);
  }

  /// Opens image picker to select photo from camera or gallery via MediaService.
  Future<void> pickImage(ImageSource source) async {
    final file = await _mediaService.pickImage(source: source);
    if (file != null) {
      selectedImage.value = file;
      update([ProfileBuilderIds.editProfileAvatar]);
    }
  }

  /// Submits updated profile data to the update profile API.
  Future<void> updateProfile() async {
    if (!editProfileFormKey.currentState!.validate()) return;

    isUpdateLoading = true;
    update([ProfileBuilderIds.updateLoadingOverlay]);

    final entity = UpdateProfileEntity(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      profilePhoto: selectedImage.value,
    );

    final ApiResponseModel response = await profileRepo.updateProfile(entity);

    if (response.status) {
      AppToast.showToast(isSuccess: true, message: response.message);

      if (response.data is UserProfileModel) {
        final UserProfileModel updatedModel = response.data;
        if (updatedModel.userProfileData != null) {
          userProfileData = updatedModel.userProfileData;
          AppStorage.saveUserProfile(userProfileData);
        }
      }
      await getUserProfile();

      update([ProfileBuilderIds.profilePage]);
      Get.back();
    } else {
      AppToast.showToast(isSuccess: false, message: response.message);
    }

    isUpdateLoading = false;
    update([ProfileBuilderIds.updateLoadingOverlay]);
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

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
