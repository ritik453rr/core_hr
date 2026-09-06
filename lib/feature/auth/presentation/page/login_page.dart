import 'package:core_hr/core/app_validator/app_validator.dart';
import 'package:core_hr/core/common_widgets/loading_overlay.dart';
import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/core/widgets/logo_widget.dart';
import '../controller/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppSafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.hzSpace,
                  vertical: AppConstants.vtSpace,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- Top Logo ---
                    const LogoWidget(),

                    const SizedBox(height: 32),

                    // --- Welcome Text ---
                    const Center(
                      child: Text(
                        StringConstants.kWelcomeBack,
                        style: TextStyle(
                          color: AppColors.c111827,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        StringConstants.kSignInSubtitle,
                        style: TextStyle(
                          color: AppColors.c4B5563,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                AppValidator.validateEmail(value),
                            prefixIcon: Icons.mail_outline,
                          ),
                          const SizedBox(height: 20),

                          // -- Password Field Label --
                          const Text(
                            StringConstants.kPasswordLabel,
                            style: TextStyle(
                              color: AppColors.c6B7280,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // -- Password Field Input --
                          GetBuilder<AuthController>(
                            id: AuthBuilderIds.passwordVisibility,
                            builder: (ctrl) => AppTextField(
                              controller: ctrl.loginPasswordController,
                              textInputAction: TextInputAction.done,
                              obscureText: ctrl.obscurePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  AppValidator.validateRequired(
                                    value,
                                    'Password',
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
                            id: AuthBuilderIds.loginButton,
                            builder: (ctrl) => AppButton(
                              text: StringConstants.kLoginButton,
                              icon: Icons.arrow_forward,
                              enable: ctrl.isLoginValid,
                              isLoading: ctrl.isLoginLoading,
                              onPressed: ctrl.onTapLogin,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<AuthController>(
              id: AuthBuilderIds.loginButton,
              builder: (ctrl) {
                return LoadingOverlay(enable: controller.isLoginLoading);
              },
            ), 
          ],
        ),
      ),
    );
  }
}
