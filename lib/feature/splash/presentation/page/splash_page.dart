import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/feature/splash/presentation/controller/splash_controller.dart';
import '../../../../core/common_widgets/app_loading_indicator.dart';
import '../../../../core/common_widgets/app_safe_area.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../widgets/splash_logo_widget.dart';

/// Initial entry screen of the app displaying branding and handling initialization.
class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.setSafeArea();

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.cFFFFFF, AppColors.cF8FAFC, AppColors.cF1F5F9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppSafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              40.h,

              // Middle Logo and Branding
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Container
                  const SplashLogoWidget(),
                  28.h,

                  // App Title
                  const AppText(
                    StringConstants.kAppTitle,
                    style: AppTextStyle.bold32,
                  ),
                  10.h,

                  // Subtitle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.c2563EB.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.c2563EB.withValues(alpha: 0.15),
                      ),
                    ),
                    child: const AppText(
                      StringConstants.kAppSubtitle,
                      style: AppTextStyle.semiBold12Blue,
                    ),
                  ),
                ],
              ),

              // Bottom Loading Indicator & Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  children: [
                    const AppLoadingIndicator(color: AppColors.c2563EB),
                    20.h,
                    const AppText(
                      StringConstants.kAppFooterText,
                      style: AppTextStyle.regular12Grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
