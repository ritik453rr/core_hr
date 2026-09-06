import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Platform-aware SafeArea that applies platform-aware bottom padding and configurable top insets.
class AppSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool? bottom;
  final bool left;
  final bool right;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;

  const AppSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom,
    this.left = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom ?? !GetPlatform.isIOS,
      left: left,
      right: right,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }
}
