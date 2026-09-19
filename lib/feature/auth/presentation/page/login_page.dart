import 'package:core_hr/core/app_validator/app_validator.dart';
import 'package:core_hr/core/common_widgets/app_loading_overlay.dart';
import 'package:core_hr/core/constants/shared_imports.dart';
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
          vertical: AppConstants.vtSpace,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            // --- Welcome Text ---
            const Center(
              child: Text(
                StringConstants.kWelcomeBack,
                style: AppTextStyle.bold32,
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                StringConstants.kSignInSubtitle,
                style: AppTextStyle.regular16Grey,
              ),
            ),
            const SizedBox(height: 40),

            // --- Main Form Container ---
            Container(
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cCBD5E1, width: 1),
              ),
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -- Email Field --
                  AppTextField(
                    label: StringConstants.kEmailLabel,
                    hintText: StringConstants.kEmailHint,
                    controller: controller.loginEmailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => AppValidator.validateEmail(value),
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 20),

                  // -- Password Field Label --
                  const Text(
                    StringConstants.kPasswordLabel,
                    style: AppTextStyle.semiBold14Grey,
                  ),
                  const SizedBox(height: 8),

                  // -- Password Field Input --
                  GetBuilder<AuthController>(
                    id: AuthBuilderIds.passwordVisibility,
                    builder: (ctrl) => AppTextField(
                      controller: ctrl.loginPasswordController,
                      textInputAction: TextInputAction.done,
                      obscureText: ctrl.obscurePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => AppValidator.validateRequired(
                        value,
                        StringConstants.kPasswordLabel,
                      ),
                      hintText: StringConstants.kPasswordHint,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: ctrl.obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      onSuffixTap: ctrl.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),

                  // -- Login Button --
                  GetBuilder<AuthController>(
                    id: AuthBuilderIds.loginLoadingOverlay,
                    builder: (ctrl) => AppButton(
                      text: StringConstants.kLoginButton,
                      enable: ctrl.isLoginValid,
                      isLoading: ctrl.isLogging,
                      onPressed: ctrl.onTapLogin,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
