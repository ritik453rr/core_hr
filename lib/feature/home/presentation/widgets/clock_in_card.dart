import 'package:core_hr/core/shimmer/app_shimmer.dart';
import 'package:core_hr/feature/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import '../../../../core/common_widgets/app_button.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../controller/home_controller.dart';

/// Interactive card for managing work shifts and clock-in/out actions.
class ClockInCard extends StatelessWidget {
  final VoidCallback? onToggleClockIn;

  const ClockInCard({super.key, this.onToggleClockIn});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return GetBuilder<HomeController>(
      id: HomeBuilderIds.clockInCard,
      builder: (controller) {
        final isActive = controller.isCheckIn;

        return AppShimmer(
          enable:
              controller.isLoadingLatLong || profileController.isLoadingProfile,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.c0F172A, AppColors.c1E3A8A],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c1E3A8A.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          StringConstants.kDailyWorkShift,
                          style: AppTextStyle.bold11LightBlue,
                        ),
                        4.h,
                        AppText(
                          isActive
                              ? StringConstants.kActiveShiftInProgress
                              : StringConstants.kNotClockedInToday,
                          style: AppTextStyle.bold18White,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.c22C55E.withValues(alpha: 0.2)
                            : AppColors.cF87171.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive
                              ? AppColors.c22C55E
                              : AppColors.cF87171,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: isActive
                                ? AppColors.c22C55E
                                : AppColors.cF87171,
                          ),
                          6.w,
                          AppText(
                            isActive ? 'Online' : StringConstants.kOffline,
                            style: isActive
                                ? AppTextStyle.bold11White.copyWith(
                                    color: AppColors.c4ADE80,
                                  )
                                : AppTextStyle.bold11White.copyWith(
                                    color: AppColors.cF87171,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                16.h,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.cFFFFFF.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.c38BDF8,
                            size: 18,
                          ),
                          8.w,
                          Expanded(
                            child: AppText(
                              controller.currentAddress.isEmpty
                                  ? StringConstants.kUnknown
                                  : controller.currentAddress,
                              style: AppTextStyle.regular12Grey.copyWith(
                                color: AppColors.cE2E8F0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                16.h,
                AppButton(
                  onPressed: onToggleClockIn,
                  isLoading: controller.isClockInLoading,
                  title: isActive
                      ? StringConstants.kClockOut
                      : StringConstants.kClockInWithLocation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
