import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

/// A reusable pull-to-refresh indicator wrapper widget.
class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color color;
  final Color backgroundColor;
  final double displacement;
  final double edgeOffset;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color = AppColors.c2563EB,
    this.backgroundColor = AppColors.cFFFFFF,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color,
      backgroundColor: backgroundColor,
      displacement: displacement,
      edgeOffset: edgeOffset,
      child: child,
    );
  }
}
