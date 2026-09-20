import 'package:core_hr/core/app_validator/app_validator.dart';
import 'package:core_hr/core/common_widgets/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import '../../../../core/common_widgets/app_button.dart';
import '../../../../core/common_widgets/app_safe_area.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../controller/auth_controller.dart';

/// Page for user authentication.
class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppSafeArea(
        child: Stack(
          children: [
            _buildBody(),
            GetBuilder<AuthController>(
              id: AuthBuilderIds.loginLoadingOverlay,
              builder: (ctrl) {
                return AppLoadingOverlay(enable: controller.isLogging);
              },
            ),
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
          vertical: 60,
        ),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              24.h,
              // --- Welcome Text ---
              const Center(
                child: AppText(
                  StringConstants.kWelcomeBack,
                  style: AppTextStyle.bold32,
                ),
              ),
              8.h,
              const Center(
                child: AppText(
                  StringConstants.kSignInSubtitle,
                  style: AppTextStyle.regular16Grey,
                ),
              ),
              30.h,
              AppTextField(
                title: StringConstants.kEmailLabel,
                hintText: StringConstants.kEmailHint,
                controller: controller.loginEmailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => AppValidator.validateEmail(value),
                prefixIcon: Icons.mail_outline,
              ),
              20.h,

              // -- Password Field Input --
              GetBuilder<AuthController>(
                id: AuthBuilderIds.passwordVisibility,
                builder: (ctrl) => AppTextField(
                  title: StringConstants.kPasswordLabel,
                  controller: ctrl.loginPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: ctrl.obscurePassword,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => AppValidator.validateRequired(value),
                  hintText: StringConstants.kPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  onSuffixTap: ctrl.togglePasswordVisibility,
                  suffixIcon: ctrl.obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              32.h,

              // -- Login Button --
              GetBuilder<AuthController>(
                id: AuthBuilderIds.loginLoadingOverlay,
                builder: (ctrl) => AppButton(
                  title: StringConstants.kLoginButton,
                  isLoading: ctrl.isLogging,
                  onPressed: ctrl.onTapLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
