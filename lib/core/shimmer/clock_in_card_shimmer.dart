import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/shimmer/app_shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shimmer placeholder for the location card using [Bone] widgets.
class ClockInCardShimmer extends StatelessWidget {
  const ClockInCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(20),
          // Using a subtle border instead of the full gradient/shadow to mimic the shape
          border: Border.all(color: AppColors.cE2E8F0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Bone.text(width: 100),
                    4.h,
                    const Bone.text(width: 160),
                  ],
                ),
                Bone.button(
                  width: 80,
                  height: 28,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            16.h,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cE2E8F0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Bone.icon(size: 18),
                  8.w,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Bone.text(width: double.infinity),
                        4.h,
                        const Bone.text(width: 150),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.h,
            Bone.button(
              width: double.infinity,
              height: 48,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
      ),
    );
  }
}
