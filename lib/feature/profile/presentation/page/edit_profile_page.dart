import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/app_validator/app_validator.dart';
import 'package:core_hr/core/common_widgets/app_button.dart';
import 'package:core_hr/core/common_widgets/app_loading_overlay.dart';
import 'package:core_hr/core/common_widgets/app_safe_area.dart';
import 'package:core_hr/core/common_widgets/app_text_field.dart';
import 'package:core_hr/core/common_widgets/custom_app_bar.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import '../controller/profile_controller.dart';
import '../widgets/avatar_picker_widget.dart';

/// Page for updating user profile information (name, email, phone, profile photo).
class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.prefillEditProfilePage();

    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstants.kEditProfile,
        showBackButton: true,
      ),
      body: AppSafeArea(
        child: Stack(
          children: [
            _buildBody(context),
            GetBuilder<ProfileController>(
              id: ProfileBuilderIds.updateLoadingOverlay,
              builder: (ctrl) {
                return AppLoadingOverlay(enable: ctrl.isUpdateLoading);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: controller.editProfileFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.hzSpace,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            16.h,

            // --- Avatar with Camera Overlay ---
            Center(
              child: AvatarPickerWidget(
                onTap: () => controller.onTapAvatarPicker(context),
              ),
            ),
            32.h,

            // --- First Name ---
            AppTextField(
              title: StringConstants.kFirstName,
              controller: controller.firstNameController,
              textInputAction: TextInputAction.next,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              hintText: StringConstants.kFirstNameHint,
              prefixIcon: Icons.person_outline,
              validator: (value) => AppValidator.validateRequired(value),
            ),
            20.h,

            // --- Last Name ---
            AppTextField(
              title: StringConstants.kLastName,
              controller: controller.lastNameController,
              textInputAction: TextInputAction.next,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              hintText: StringConstants.kLastNameHint,
              prefixIcon: Icons.person_outline,
              validator: (value) => AppValidator.validateRequired(value),
            ),
            20.h,

            // --- Email Address ---
            AppTextField(
              title: StringConstants.kEmailAddress,
              controller: controller.emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              hintText: StringConstants.kEmailHint,
              prefixIcon: Icons.mail_outline,
              validator: (value) => AppValidator.validateEmail(value),
            ),
            20.h,

            // --- Phone Number ---
            AppTextField(
              title: StringConstants.kPhoneNumber,
              controller: controller.phoneController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              hintText: StringConstants.kPhoneHint,
              prefixIcon: Icons.phone_iphone_rounded,
              validator: (value) => AppValidator.validatePhoneNumber(value),
            ),
            36.h,

            // --- Save Button ---
            GetBuilder<ProfileController>(
              id: ProfileBuilderIds.updateLoadingOverlay,
              builder: (ctrl) {
                return AppButton(
                  title: StringConstants.kSaveChanges,
                  isLoading: ctrl.isUpdateLoading,
                  onPressed: ctrl.updateProfile,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
