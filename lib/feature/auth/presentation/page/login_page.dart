import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/common_widgets/common_button.dart';
import '../controller/auth_controller.dart';

// Color palette extracted from the design system
const Color appBgColor = Color(0xFFF4F5F7);
const Color whiteColor = Color(0xFFFFFFFF);
const Color primaryBlue = Color(0xFF003E99);
const Color textDark = Color(0xFF111827);
const Color textMediumGrey = Color(0xFF4B5563);
const Color textLightGrey = Color(0xFF6B7280);
const Color borderGrey = Color(0xFFCBD5E1);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Top Logo ---
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderGrey.withValues(alpha: 0.5), width: 1),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF38BDF8),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF38BDF8),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E3A8A),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // --- Welcome Text ---
                const Center(
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Sign in to sync your professional life',
                    style: TextStyle(
                      color: textMediumGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // --- Main Form Container ---
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderGrey, width: 1),
                  ),
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // -- Email Field --
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          color: textMediumGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller.loginEmailController,
                        style: const TextStyle(color: textDark, fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'name@company.com',
                          hintStyle: const TextStyle(color: textLightGrey, fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.mail_outline, color: textLightGrey, size: 22),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: borderGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // -- Password Field Label & Link --
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: textMediumGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: primaryBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      // -- Password Field Input --
                      Obx(() => TextField(
                            controller: controller.loginPasswordController,
                            obscureText: controller.obscurePassword.value,
                            style: const TextStyle(color: textDark, fontSize: 15, letterSpacing: 2),
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              hintStyle: const TextStyle(color: textLightGrey, letterSpacing: 2),
                              prefixIcon: const Icon(Icons.lock_outline, color: textLightGrey, size: 22),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: textLightGrey,
                                  size: 22,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: borderGrey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: primaryBlue, width: 2),
                              ),
                            ),
                          )),
                      const SizedBox(height: 24),

                      // -- Login Button --
                      Obx(() => CommonButton(
                            text: 'Login',
                            icon: Icons.arrow_forward,
                            isLoading: controller.isLoginLoading.value,
                            onPressed: controller.login,
                          )),
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
