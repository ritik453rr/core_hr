import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

/// A reusable loading indicator widget typically displayed at the bottom of lists during pagination/load-more.
class AppLoadMoreIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double strokeWidth;
  final Color color;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const AppLoadMoreIndicator({
    super.key,
    this.height = 40.0,
    this.width = 40.0,
    this.strokeWidth = 3.0,
    this.color = AppColors.c2563EB,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget indicator = SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
      ),
    );

    if (padding != null) {
      indicator = Padding(padding: padding!, child: indicator);
    }

    return Center(child: indicator);
  }
}
