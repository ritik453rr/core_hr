import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/common_button.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Reset Password', style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF111827)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Icon
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: const Icon(Icons.lock_reset, color: Color(0xFF2563EB), size: 36),
                ),
              ),
              const SizedBox(height: 24),

              // Title and Description
              Obx(() => Text(
                    controller.forgotStep.value == 0
                        ? 'Forgot Password?'
                        : controller.forgotStep.value == 1
                            ? 'Verify Security Code'
                            : 'Set New Password',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  )),
              const SizedBox(height: 8),

              Obx(() => Text(
                    controller.forgotStep.value == 0
                        ? 'Enter your registered work email to receive a password reset code.'
                        : controller.forgotStep.value == 1
                            ? 'Enter the 4-digit code sent to ${controller.forgotEmailController.text}.'
                            : 'Create a strong new password for your account.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  )),
              const SizedBox(height: 32),

              // Main Step Form Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Obx(() {
                  if (controller.forgotStep.value == 0) {
                    return _buildEmailStep(controller);
                  } else if (controller.forgotStep.value == 1) {
                    return _buildOtpStep(controller);
                  } else {
                    return _buildNewPasswordStep(controller);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailStep(AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Work Email Address', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4B5563), fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller.forgotEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'name@company.com',
            prefixIcon: const Icon(Icons.mail_outline, color: Color(0xFF94A3B8)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 24),
        Obx(() => CommonButton(
              text: 'SEND VERIFICATION CODE',
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              isLoading: controller.isForgotLoading.value,
              onPressed: controller.sendOtp,
            )),
      ],
    );
  }

  Widget _buildOtpStep(AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('4-Digit Verification Code', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4B5563), fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 10),
          decoration: InputDecoration(
            hintText: '••••',
            counterText: '',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        const SizedBox(height: 24),
        Obx(() => CommonButton(
              text: 'VERIFY CODE',
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              isLoading: controller.isForgotLoading.value,
              onPressed: controller.verifyOtp,
            )),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => controller.forgotStep.value = 0,
          child: const Text('Resend Code / Change Email', style: TextStyle(color: Color(0xFF003E99), fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildNewPasswordStep(AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('New Password', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4B5563), fontSize: 14)),
        const SizedBox(height: 8),
        Obx(() => TextField(
              controller: controller.newPasswordController,
              obscureText: controller.obscureNewPassword.value,
              decoration: InputDecoration(
                hintText: 'At least 6 characters',
                prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8)),
                suffixIcon: IconButton(
                  icon: Icon(controller.obscureNewPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  onPressed: () => controller.obscureNewPassword.value = !controller.obscureNewPassword.value,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            )),
        const SizedBox(height: 16),

        const Text('Confirm New Password', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4B5563), fontSize: 14)),
        const SizedBox(height: 8),
        Obx(() => TextField(
              controller: controller.confirmPasswordController,
              obscureText: controller.obscureConfirmPassword.value,
              decoration: InputDecoration(
                hintText: 'Re-enter new password',
                prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8)),
                suffixIcon: IconButton(
                  icon: Icon(controller.obscureConfirmPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  onPressed: () => controller.obscureConfirmPassword.value = !controller.obscureConfirmPassword.value,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            )),
        const SizedBox(height: 24),

        Obx(() => CommonButton(
              text: 'RESET PASSWORD NOW',
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              isLoading: controller.isForgotLoading.value,
              onPressed: controller.resetPassword,
            )),
      ],
    );
  }
}
