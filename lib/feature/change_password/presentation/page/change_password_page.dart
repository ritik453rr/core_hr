import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/app_validator/app_validator.dart';
import 'package:core_hr/core/common_widgets/app_button.dart';
import 'package:core_hr/core/common_widgets/app_loading_overlay.dart';
import 'package:core_hr/core/common_widgets/app_safe_area.dart';
import 'package:core_hr/core/common_widgets/app_text.dart';
import 'package:core_hr/core/common_widgets/app_text_field.dart';
import 'package:core_hr/core/common_widgets/custom_app_bar.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import '../controller/change_password_controller.dart';

/// Page for authenticated users to update their account password.
class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstants.kChangePassword,
        showBackButton: true,
      ),
      body: AppSafeArea(
        child: Stack(
          children: [
            _buildBody(),
            Obx(() => AppLoadingOverlay(enable: controller.isLoading.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.hzSpace,
          vertical: 40,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.h,
              // --- Title & Subtitle ---
              const Center(
                child: AppText(
                  StringConstants.kChangePassword,
                  style: AppTextStyle.bold32,
                ),
              ),
              8.h,
              const Center(
                child: AppText(
                  StringConstants.kUpdatePasswordSubtitle,
                  style: AppTextStyle.regular16Grey,
                ),
              ),
              30.h,

              // --- Current Password ---
              Obx(
                () => AppTextField(
                  title: StringConstants.kCurrentPassword,
                  controller: controller.currentPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: !controller.isCurrentPasswordVisible.value,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: StringConstants.kPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: controller.isCurrentPasswordVisible.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixTap: controller.toggleCurrentPasswordVisibility,
                  validator: (value) => AppValidator.validateRequired(value),
                ),
              ),
              20.h,

              // --- New Password ---
              Obx(
                () => AppTextField(
                  title: StringConstants.kNewPassword,
                  controller: controller.newPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: !controller.isNewPasswordVisible.value,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: StringConstants.kPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: controller.isNewPasswordVisible.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixTap: controller.toggleNewPasswordVisibility,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppValidator.validateRequired(value);
                    }
                    if (value.length < 6) {
                      return StringConstants.kPasswordMinLengthError;
                    }
                    return null;
                  },
                ),
              ),
              20.h,

              // --- Confirm Password ---
              Obx(
                () => AppTextField(
                  title: StringConstants.kConfirmNewPassword,
                  controller: controller.confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: StringConstants.kPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: controller.isConfirmPasswordVisible.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixTap: controller.toggleConfirmPasswordVisibility,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppValidator.validateRequired(value);
                    }
                    if (value != controller.newPasswordController.text) {
                      return StringConstants.kPasswordMatchError;
                    }
                    return null;
                  },
                ),
              ),
              32.h,

              // --- Update Password Button ---
              Obx(
                () => AppButton(
                  title: StringConstants.kUpdatePassword,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.changePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
