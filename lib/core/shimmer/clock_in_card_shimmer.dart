import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/core/shimmer/app_shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shimmer placeholder for the location card using [Bone] widgets.
class ClockInCardShimmer extends StatelessWidget {
  const ClockInCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cE2E8F0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Bone.text(width: 80),
                      SizedBox(height: 8),
                      Bone.text(width: 150),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Bone.button(
                  width: 80,
                  height: 24,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cE2E8F0),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Bone.icon(size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Bone.text(words: 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
