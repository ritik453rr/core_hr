import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// A customizable TextButton with left alignment, compact sizing, and built-in haptic feedback.
class AppTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;
  final Alignment alignment;

  const AppTextButton({
    super.key,
    required this.title,
    this.onPressed,
    this.padding = EdgeInsets.zero,
    this.style,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: alignment,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        overlayColor: Colors.grey,
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        minimumSize: const Size(0, 0),
      ),
      onPressed: () {
        AppConstants.hapticFeedBack();
        onPressed?.call();
      },
      child: Text(title, style: style),
    );
  }
}
