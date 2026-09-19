import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A customizable circular loading indicator.
class AppLoadingIndicator extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double? value;
  final Color? backgroundColor;

  const AppLoadingIndicator({
    super.key,
    this.color = AppColors.c2563EB,
    this.strokeWidth = 3.0,
    this.value,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: strokeWidth,
      value: value,
      backgroundColor: backgroundColor,
    );
  }
}

typedef AppCircularProgressIndicator = AppLoadingIndicator;
