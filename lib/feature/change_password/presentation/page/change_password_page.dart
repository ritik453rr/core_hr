import '../../../../core/app_validator/app_validator.dart';
import '../../../../core/constants/shared_imports.dart';
import '../controller/change_password_controller.dart';

/// Page for authenticated users to update their account password.
class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.kChangePassword,
          style: AppTextStyle.bold18,
        ),
        backgroundColor: AppColors.cFFFFFF,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.c111827),
          onPressed: () => Get.back(),
        ),
      ),
      body: AppSafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  StringConstants.kUpdatePasswordSubtitle,
                  style: AppTextStyle.regular16Grey,
                ),
                32.h,
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cCBD5E1, width: 1),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Current Password
                      Obx(
                        () => AppTextField(
                          label: StringConstants.kCurrentPassword,
                          controller: controller.currentPasswordController,
                          obscureText:
                              !controller.isCurrentPasswordVisible.value,
                          hintText: StringConstants.kPasswordHint,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: controller.isCurrentPasswordVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onSuffixTap:
                              controller.toggleCurrentPasswordVisibility,
                          validator: (value) =>
                              AppValidator.validateRequired(
                            value,
                            StringConstants.kCurrentPassword,
                          ),
                        ),
                      ),
                      20.h,

                      // New Password
                      Obx(
                        () => AppTextField(
                          label: StringConstants.kNewPassword,
                          controller: controller.newPasswordController,
                          obscureText: !controller.isNewPasswordVisible.value,
                          hintText: StringConstants.kPasswordHint,
                          prefixIcon: Icons.lock_reset,
                          suffixIcon: controller.isNewPasswordVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onSuffixTap: controller.toggleNewPasswordVisibility,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppValidator.validateRequired(
                                  value, StringConstants.kNewPassword);
                            }
                            if (value.length < 6) {
                              return StringConstants.kPasswordMinLengthError;
                            }
                            return null;
                          },
                        ),
                      ),
                      20.h,

                      // Confirm Password
                      Obx(
                        () => AppTextField(
                          label: StringConstants.kConfirmNewPassword,
                          controller: controller.confirmPasswordController,
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          hintText: StringConstants.kPasswordHint,
                          prefixIcon: Icons.check_circle_outline,
                          suffixIcon: controller.isConfirmPasswordVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onSuffixTap:
                              controller.toggleConfirmPasswordVisibility,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppValidator.validateRequired(
                                  value, StringConstants.kConfirmNewPassword);
                            }
                            if (value != controller.newPasswordController.text) {
                              return StringConstants.kPasswordMatchError;
                            }
                            return null;
                          },
                        ),
                      ),
                      32.h,

                      // Change Password Button
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
