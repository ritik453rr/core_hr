import 'package:flutter/cupertino.dart';
import '../constants/app_colors.dart';

/// A customizable circular loading indicator.
class AppLoadingIndicator extends StatelessWidget {
  final Color color;
  final double radius;

  /// Creates an [AppLoadingIndicator] with customizable [color], [strokeWidth], and [radius].
  const AppLoadingIndicator({
    super.key,
    this.color = AppColors.c2563EB,
    this.radius = 20,
  });

  /// Builds a circular loading indicator constrained by the specified [radius].
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(color: color, radius: radius);
  }
}
