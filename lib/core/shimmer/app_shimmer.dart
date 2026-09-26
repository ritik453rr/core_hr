import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final bool enable;

  const AppShimmer({super.key, required this.child, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enable,
      effect: const ShimmerEffect(
        baseColor: Color(0xFFADB2B8),
        highlightColor: Color(0xFFD9DDE1),
      ),
      child: child,
    );
  }
}
