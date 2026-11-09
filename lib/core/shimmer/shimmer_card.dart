import 'package:core_hr/core/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Bone(
        width: Get.width,
        height: 130,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
