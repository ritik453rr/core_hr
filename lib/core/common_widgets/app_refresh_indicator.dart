import 'package:flutter/material.dart';

/// A reusable pull-to-refresh indicator wrapper widget.
class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.blue.shade900,
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
