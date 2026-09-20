import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Platform-aware SafeArea that applies platform-aware bottom padding and configurable top insets.
class AppSafeArea extends StatelessWidget {
  final Widget child;

  const AppSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(bottom: !GetPlatform.isIOS, child: child);
  }
}
