import 'package:core_hr/core/constants/shared_imports.dart';
import '../../../../core/shimmer/clock_in_card_shimmer.dart';
import '../controller/home_controller.dart';

/// Interactive card for managing work shifts and clock-in/out actions.
class ClockInCard extends StatelessWidget {
  const ClockInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: HomeBuilderIds.clockIn,
      builder: (controller) {
        if (controller.isLoadingLatLong) {
          return const ClockInCardShimmer();
        }

        return Container(
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
                      const Text(
                        StringConstants.kDailyWorkShift,
                        style: AppTextStyle.bold11LightBlue,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.isClockedIn
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
                      color: controller.isClockedIn
                          ? AppColors.c22C55E.withValues(alpha: 0.2)
                          : AppColors.cF87171.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: controller.isClockedIn
                            ? AppColors.c22C55E
                            : AppColors.cF87171,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: controller.isClockedIn
                              ? AppColors.c22C55E
                              : AppColors.cF87171,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          controller.isClockedIn
                              ? StringConstants.kClockedIn
                              : StringConstants.kOffline,
                          style: controller.isClockedIn
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
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.cFFFFFF.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.my_location,
                      color: AppColors.c38BDF8,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SelectableText(
                        controller.currentLatLong,
                        style: AppTextStyle.regular12Grey.copyWith(
                          color: AppColors.cE2E8F0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                width: Get.width,
                height: 48,
                backgroundColor: AppColors.cFFFFFF,
                foregroundColor: AppColors.c0F172A,
                borderRadius: 12,
                onPressed: controller.toggleClockIn,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      controller.isClockedIn
                          ? Icons.stop_circle_rounded
                          : Icons.play_circle_fill_rounded,
                      color: controller.isClockedIn
                          ? AppColors.cDC2626
                          : AppColors.c2563EB,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.isClockedIn
                          ? StringConstants.kClockOut
                          : StringConstants.kClockInWithLocation,
                      style: AppTextStyle.bold14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
